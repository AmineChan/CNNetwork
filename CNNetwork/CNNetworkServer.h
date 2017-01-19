//
//  CNNetworkServer.h
//  CNNetwork
//
//  Created by czm on 16/8/31.
//  Copyright © 2016年 czm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNNetworkServerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNNetworkServer : NSObject

+ (CNNetworkServer *)sharedInstance;

- (void)setServerConfig:(CNNetworkServerConfig *)serverConfig forKey:(NSString *)key;
- (CNNetworkServerConfig *)serverConfigForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END


