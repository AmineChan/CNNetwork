//
//  CNNetworkUtils.h
//  CNNetwork
//
//  Created by czm on 15/11/22.
//  Copyright © 2015年 czm. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

extern NSString * CNPercentEscapedStringFromString(NSString *string);

@interface CNNetworkUtils : NSObject

+ (NSString *)getDNSServers;
+ (NSString *)hostname;
+ (BOOL)canReachNetwork;
+ (BOOL)validateUrl:(NSString *)urlStr;

/*
 * Detect `Accept` from accepts
 */
+ (NSString *)selectHeaderAccept:(NSArray *)accepts;

/*
 * Detect `Content-Type` from contentTypes
 */
+ (NSString *)selectHeaderContentType:(NSArray *)contentTypes;

@end

NS_ASSUME_NONNULL_END
