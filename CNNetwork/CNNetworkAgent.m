//
//  CUNetworkAgent.m
//  CNNetwork
//
//  Created by czm on 15/11/22.
//  Copyright © 2015年 czm. All rights reserved.
//

#import "CNNetworkAgent.h"
#import "CNNetworkUtils.h"
#import "AFHTTPSessionManager+CNNetwork.h"

@interface CNNetworkAgent()

@property (nonatomic, strong) NSMutableArray<NSURLSessionDataTask *> *cachedDataTasks;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, CNRequest *> *mutableRequestByTaskIdentifier;
@property (nonatomic, strong) NSLock *lock;

@property (nonatomic, strong) NSDate *lastSessionTime;
@property (nonatomic) BOOL isSessionRefreshing;

@end

@implementation CNNetworkAgent

+ (CNNetworkAgent *)sharedInstance
{
    static CNNetworkAgent *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _sesssionTimeout = 60*20;
        _cachedDataTasks = [[NSMutableArray alloc] init];
        _mutableRequestByTaskIdentifier = [[NSMutableDictionary alloc] init];
        
        _lock = [[NSLock alloc] init];
        _lock.name = @"CNNetworkAgent";
    }
    
    return self;
}

#pragma mark -
#pragma mark private
#pragma mark
- (CNRequest *)requestForDataTask:(NSURLSessionDataTask *)task
{
    NSParameterAssert(task);
    
    CNRequest *request = nil;
    [_lock lock];
    request = _mutableRequestByTaskIdentifier[@(task.taskIdentifier)];
    [_lock unlock];
    
    return request;
}

- (void)addRequest:(CNRequest *)request forTask:(NSURLSessionDataTask *)task
{
    [_lock lock];
    _mutableRequestByTaskIdentifier[@(task.taskIdentifier)] = request;
    [_lock unlock];
}

- (void)removeRequestForTask:(NSURLSessionDataTask *)task
{
    NSParameterAssert(task);
    
    [_lock lock];
    [_mutableRequestByTaskIdentifier removeObjectForKey:@(task.taskIdentifier)];
    [_lock unlock];
}

- (NSString *)pathWithQueryParamsToString:(NSString *)path queryParams:(NSDictionary *)queryParams
{
    if(queryParams.count == 0)
    {
        return path;
    }
    
    NSString *separator = nil;
    NSUInteger counter = 0;
    
    NSMutableString *requestUrl = [NSMutableString stringWithFormat:@"%@", path];
    NSDictionary *separatorStyles = @{@"csv" : @",",
                                      @"tsv" : @"\t",
                                      @"pipes": @"|"
                                      };
    
    for (NSString *key in [queryParams keyEnumerator])
    {
        if (counter == 0)
        {
            separator = @"?";
        }
        else
        {
            separator = @"&";
        }
        
        id queryParam = [queryParams valueForKey:key];
        if(!queryParam)
        {
            continue;
        }
        
        NSString *safeKey = CNPercentEscapedStringFromString(key);
        if ([queryParam isKindOfClass:[NSString class]])
        {
            [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator, safeKey, CNPercentEscapedStringFromString(queryParam)]];
            
        }
        else if ([queryParam isKindOfClass:[CNQueryParamCollection class]])
        {
            CNQueryParamCollection *coll = (CNQueryParamCollection*) queryParam;
            NSArray *values = [coll values];
            NSString *format = [coll format];
            
            if([format isEqualToString:@"multi"])
            {
                for(id obj in values)
                {
                    if (counter > 0)
                    {
                        separator = @"&";
                    }
                    
                    NSString *safeValue = CNPercentEscapedStringFromString([NSString stringWithFormat:@"%@",obj]);
                    [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator, safeKey, safeValue]];
                    counter += 1;
                }
                
                continue;
            }
            
            NSString *separatorStyle = separatorStyles[format];
            NSString *safeValue = CNPercentEscapedStringFromString([values componentsJoinedByString:separatorStyle]);
            [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator, safeKey, safeValue]];
        }
        else
        {
            NSString *safeValue = CNPercentEscapedStringFromString([NSString stringWithFormat:@"%@",queryParam]);
            [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator, safeKey, safeValue]];
        }
        
        counter += 1;
    }
    
    return requestUrl;
}

- (AFSecurityPolicy *)securityPolicyForServerConfig:(CNNetworkServerConfig *)serverConfig
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    if (serverConfig.sslCaCert)
    {
        NSData *certData = [NSData dataWithContentsOfFile:serverConfig.sslCaCert];
        [securityPolicy setPinnedCertificates:[NSSet setWithObject:certData]];
    }
    
    if (serverConfig.verifySSL)
    {
        [securityPolicy setAllowInvalidCertificates:NO];
    }
    else
    {
        [securityPolicy setAllowInvalidCertificates:YES];
        [securityPolicy setValidatesDomainName:NO];
    }
    
    return securityPolicy;
}

- (NSURLSessionDataTask *)dataTaskForRequest:(CNRequest *)request
{
    __weak CNNetworkAgent *wself = self;
    NSURLSessionDataTask *dataTask = nil;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // setting request serializer
    if ([request.requestContentType isEqualToString:@"application/json"])
    {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if ([request.requestContentType isEqualToString:@"application/x-www-form-urlencoded"])
    {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    else if ([request.requestContentType isEqualToString:@"multipart/form-data"])
    {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    else
    {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSAssert(NO, @"Unsupported request type %@", request.requestContentType);
    }
    
    // setting response serializer
    if ([request.responseContentType isEqualToString:@"application/json"])
    {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    else
    {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    // url request
    if ([request isKindOfClass:[CNURLRequest class]])
    {
        CNURLRequest *urlRequest = (CNURLRequest *)request;
        dataTask = [manager dataTaskWithRequest:urlRequest.urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [wself onRequest:request completedWithError:nil responseObject:responseObject];
        }];
    }
    // normal request
    else
    {
        CNNetworkServer *server = [CNNetworkServer sharedInstance];
        CNNetworkServerConfig *serverConfig = [server serverConfigForKey:request.serverKey];
        manager.securityPolicy = [self securityPolicyForServerConfig:serverConfig];
        
        NSDictionary *pathParams = request.pathParams;
        NSDictionary *queryParams = request.queryParams;
        NSDictionary *formParams = request.formParams;
        NSDictionary *headerParams = request.headerParams;
        id bodyParam = request.bodyParam;
        if (_requestParamSerializer)
        {
            pathParams = [_requestParamSerializer serializationParam:pathParams];
            queryParams = [_requestParamSerializer serializationParam:queryParams];
            headerParams = [_requestParamSerializer serializationParam:headerParams];
            formParams = [_requestParamSerializer serializationParam:formParams];
            if(![bodyParam isKindOfClass:[NSData class]])
            {
                bodyParam = [_requestParamSerializer serializationParam:bodyParam];
            }
        }
        
        // auth setting
        [serverConfig updateHeaderParams:&headerParams queryParams:&queryParams withAuthNames:request.authNames];
        
        NSMutableString *resourcePath = [NSMutableString stringWithString:request.relativePath];
        [pathParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *safeString = ([obj isKindOfClass:[NSString class]]) ? obj : [NSString stringWithFormat:@"%@", obj];
            safeString = CNPercentEscapedStringFromString(safeString);
            [resourcePath replaceCharactersInRange:[resourcePath rangeOfString:[NSString stringWithFormat:@"{%@}", key]] withString:safeString];
        }];
        
        NSString *pathWithQueryParams = [self pathWithQueryParamsToString:resourcePath queryParams:queryParams];
        NSString *baseUrl = [serverConfig.host stringByAppendingString:pathWithQueryParams];
        
        BOOL hasHeaderParams = [headerParams count] > 0;
        if (hasHeaderParams)
        {
            for(NSString * key in [headerParams keyEnumerator])
            {
                [manager.requestSerializer setValue:[headerParams valueForKey:key] forHTTPHeaderField:key];
            }
        }
#ifdef DEBUG
        NSLog(@"request----->%@ %@", baseUrl, formParams? formParams:bodyParam);
#endif
        dataTask = [manager cn_dataTaskWithHTTPMethod:request.HTTPMethod
                                            URLString:baseUrl
                                           parameters:bodyParam? bodyParam:formParams
                            constructingBodyWithBlock:request.constructingBodyBlock
                                             progress:request.progressBlock
                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                  [wself onRequest:request completedWithError:nil responseObject:responseObject];
                                              } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                  [wself onRequest:request completedWithError:error responseObject:nil];
                                              }];
    }
    
    return dataTask;
}

#pragma mark -
#pragma mark public
#pragma mark

- (NSURLSessionDataTask *)startAsynRequest:(CNRequest *)request
{
    __weak CNNetworkAgent *wself = self;
    if (![CNNetworkUtils canReachNetwork])
    {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSError *error = [NSError errorWithDomain:@"NSURLErrorNotConnectedToInternet"
                                                 code:NSURLErrorNotConnectedToInternet
                                             userInfo:nil];
            [wself onRequest:request completedWithError:error responseObject:nil];
        });
        
        return nil;
    }
    
    if (_delegate)
    {
        [_delegate networkAgent:self willStartRequest:request];
    }
    
    NSURLSessionDataTask *dataTask = [self dataTaskForRequest:request];
    [self addRequest:request forTask:dataTask];
    
    if (_sessionDelegate  && [self isSessionTimeout] && [_sessionDelegate sessionAvailableForRequest:request])
    {
        CNRequest *sessionRequest = [_sessionDelegate requestForSession];
        if (sessionRequest)
        {
            [_cachedDataTasks addObject:dataTask];
            if (!_isSessionRefreshing)
            {
                _isSessionRefreshing = YES;
                [sessionRequest startWithCompletionBlock:^(CNRequest *theRequest, id data, NSError *error) {
                    [wself onSessionRequestCompleted:theRequest data:data error:error];
                }];
            }
        }
        else
        {
            [dataTask resume];
        }
    }
    else
    {
        [dataTask resume];
    }
    
    return dataTask;
}

- (void)cancelDataTask:(NSURLSessionDataTask *)dataTask
{
    NSParameterAssert(dataTask);
    
    CNRequest *request = [self requestForDataTask:dataTask];
    if (!request)
    {
        return;
    }
    
    __strong CNRequest *strongRequest = request;
    
    if (_delegate)
    {
        [_delegate networkAgent:self willStopRequest:strongRequest];
    }
    
    [self removeRequestForTask:dataTask];
    [dataTask cancel];
    
    if (_delegate)
    {
        [_delegate networkAgent:self didStopRequest:strongRequest error:nil];
    }
}

- (void)cancelAll
{
    for (CNRequest *request in [_mutableRequestByTaskIdentifier allValues])
    {
        [request stop];
    }
}

#pragma mark -
#pragma mark session
#pragma mark
- (BOOL)isSessionTimeout
{
    if (!_lastSessionTime)
    {
        return YES;
    }
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:_lastSessionTime];
    if (time > _sesssionTimeout)
    {
        return YES;
    }
    
    return NO;
}

- (void)onSessionRequestCompleted:(CNRequest *)request data:(id)data error:(NSError *)error
{
    _isSessionRefreshing = NO;
    [_cachedDataTasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj resume];
    }];
    
    [_sessionDelegate sessionRequestCompleted:request data:data error:error];
    [_cachedDataTasks removeAllObjects];
}

#pragma mark -
#pragma mark request completed
#pragma mark
- (void)onRequest:(CNRequest *)request completedWithError:(NSError *)error responseObject:(id)responseObject
{
    if (_delegate)
    {
        [_delegate networkAgent:self willStopRequest:request];
    }
    
    if (error)
    {
        if (_errorSerializer)
        {
            error = [_errorSerializer serializationError:error];
        }
        
        [self request:request completedWithData:nil andError:error];
        return;
    }
    
    if (!_responseDeserializer)
    {
        [self request:request completedWithData:responseObject andError:error];
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *theError = error;
        id data = [_responseDeserializer deserialize:responseObject class:request.responseType error:&theError];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self request:request completedWithData:data andError:theError];
        });
    });
}

- (void)request:(CNRequest *)request completedWithData:(id)data andError:(NSError *)error
{
    //更新session时间
    if (!error)
    {
        if (_sessionDelegate
            && ([_sessionDelegate isSessionRequest:request]
                || [_sessionDelegate sessionAvailableForRequest:request]))
        {
            _lastSessionTime = [NSDate date];
        }
    }
    
    __strong CNRequest *strongRequest = request;
    if (strongRequest.completionBlock)
    {
        strongRequest.completionBlock(strongRequest, data, error);
    }
    
    if (strongRequest.completionBlockForBatch)
    {
        strongRequest.completionBlockForBatch(strongRequest, data, error);
    }
    
    if (strongRequest.dataTask)
    {
        [self removeRequestForTask:strongRequest.dataTask];
    }
    
    if (_delegate)
    {
        [_delegate networkAgent:self didStopRequest:strongRequest error:error];
    }
}

@end
