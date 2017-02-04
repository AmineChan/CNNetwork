//
//  CNNetworkServer.m
//  CNNetwork
//
//  Created by czm on 16/8/31.
//  Copyright © 2016年 czm. All rights reserved.
//

#import "CNNetworkServer.h"

@interface CNNetworkServer ()
{
    NSMutableDictionary<NSString *, CNNetworkServerConfig *> *_serverConfigSet;
}
@end
@implementation CNNetworkServer

+ (CNNetworkServer *)sharedInstance
{
    static id sharedInstance = nil;
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
        _serverConfigSet = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)setServerConfig:(CNNetworkServerConfig *)serverConfig forKey:(NSString *)key;
{
    assert(serverConfig && key);
    
    _serverConfigSet[key] = serverConfig;
}

- (CNNetworkServerConfig *)serverConfigForKey:(NSString *)key
{
    assert(key);
    
    return _serverConfigSet[key];
}

@end
