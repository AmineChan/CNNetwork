//
//  CNNetworkManager.m
//  iEcoalAmb
//
//  Created by czm on 15/12/5.
//  Copyright © 2015年 czm. All rights reserved.
//

#import "NetworkManager.h"
#import "CNNetwork.h"
#import <Api/OSCRequestParamSerializer.h>
#import <Api/OSCResponseDeserializer.h>

@interface NetworkManager ()
{
    OSCRequestParamSerializer *paramSerializer;
    OSCResponseDeserializer *responseDeserializer;
}
@end
@implementation NetworkManager

+ (NetworkManager *)sharedInstance;
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        CNNetworkServerConfig *webHostServer = [CNNetworkServerConfig new];
        webHostServer.host = @"https://git.oschina.net/api/v3";
        [[CNNetworkServer sharedInstance] setServerConfig:webHostServer forKey:@"WEB_HOST"];

        paramSerializer = [[OSCRequestParamSerializer alloc] init];
        responseDeserializer = [[OSCResponseDeserializer alloc] init];

        CNNetworkAgent *agent = [CNNetworkAgent sharedInstance];
        agent.delegate = self;
        agent.requestParamSerializer = paramSerializer;
        agent.responseDeserializer = responseDeserializer;
        agent.errorSerializer = self;
    }
    
    return self;
}

#pragma mark -
#pragma mark  CNNetworkErrorSerializer 返回的错误序列化
#pragma mark
- (NSError *)serializationError:(NSError *)error
{
    assert(error);
    
    switch (error.code) {
        case NSURLErrorTimedOut:
            error  = [NSError errorWithDomain:@"服务器超时" code:error.code userInfo:error.userInfo];
            break;
        case NSURLErrorCannotFindHost:
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorNetworkConnectionLost:
            error  = [NSError errorWithDomain:@"不能连接到服务器" code:error.code userInfo:error.userInfo];
            break;
        case NSURLErrorBadServerResponse:
            error  = [NSError errorWithDomain:@"不能连接到服务器" code:error.code userInfo:error.userInfo];
            break;
        case NSURLErrorNotConnectedToInternet:
            error  = [NSError errorWithDomain:@"没有网络，请检查您的网络设置！" code:error.code userInfo:error.userInfo];
            break;
        default:
            break;
    }
    
    return error;
}

#pragma mark -
#pragma mark  CUNetworkAgentDelegate
#pragma mark
- (void)networkAgent:(CNNetworkAgent *)agent willStartRequest:(CNRequest *)request
{
//    CNNetworkServerConfig *server = [[CNNetworkServer sharedInstance] serverForKey:requestApi.serverKey];
//    NSString *baseUrl = [server.host stringByAppendingString:requestApi.relativePath];
//
//    NSLog(@"发起网络请求：%@", [NSString stringWithFormat:@"%@?jsonstring=%@", baseUrl, [requestApi.parameters JSONString]]);
}

- (void)networkAgent:(CNNetworkAgent *)agent willStopRequest:(CNRequest *)request
{
}

- (void)networkAgent:(CNNetworkAgent *)agent didStopRequest:(CNRequest *)request error:(NSError *)error
{
}

@end
