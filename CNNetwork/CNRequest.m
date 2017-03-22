//
//  CNRequest.m
//  CNNetwork
//
//  Created by czm on 2017/1/11.
//
//

#import "CNRequest.h"
#import "CNNetworkAgent.h"

@implementation CNRequest
- (void)dealloc
{
    [self stop];
}

- (instancetype)initWithTag:(NSInteger)tag
                 HTTPMethod:(NSString *)HTTPMethod
               relativePath:(NSString *)relativePath
                  serverKey:(NSString *)serverKey
               headerParams:(NSDictionary *)headerParams
                 pathParams:(NSDictionary *)pathParams
                queryParams:(NSDictionary *)queryParams
                 formParams:(NSDictionary *)formParams
                  bodyParam:(id)bodyParam
         requestContentType:(NSString *)requestContentType
        responseContentType:(NSString *)responseContentType
               responseType:(NSString *)responseType
                  authNames:(NSArray *)authNames
{
    self = [super init];
    if (self)
    {
        _tag = tag;
        _HTTPMethod = HTTPMethod;
        _relativePath = relativePath;
        _serverKey = serverKey;
        _headerParams = headerParams;
        _pathParams = pathParams;
        _queryParams = queryParams;
        _formParams = formParams;
        _bodyParam = bodyParam;
        _requestContentType = requestContentType;
        _responseContentType = responseContentType;
        _responseType = responseType;
        _authNames = authNames;
        _timeoutInterval = 30;
    }
    
    return self;
}

- (void)startWithCompletionBlock:(void (^)(CNRequest *request, id data, NSError *error))completionBlock
{
    [self startWithCompletionBlock:completionBlock progressBlock:nil constructingBodyWithBlock:nil];
}

- (void)startWithCompletionBlock:(void (^)(CNRequest *request, id data, NSError *error))completionBlock
                   progressBlock:(void (^)(NSProgress *))progressBlock
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBodyBlock
{
    _completionBlock = completionBlock;
    _progressBlock = progressBlock;
    _constructingBodyBlock = constructingBodyBlock;
    
    [self start];
}

- (void)start
{
    if (_dataTask)
    {
        [self stop];
    }
    
    _dataTask = [[CNNetworkAgent sharedInstance] startAsynRequest:self];
}

- (void)stop
{
    if (!_dataTask)
    {
        return;
    }
    
    [[CNNetworkAgent sharedInstance] cancelDataTask:_dataTask];
    _dataTask = nil;
}

- (BOOL)isExecuting
{
    if (!_dataTask)
    {
        return NO;
    }
    
    return _dataTask.state == NSURLSessionTaskStateRunning? YES:NO;
}

@end

@implementation CNURLRequest

@end
