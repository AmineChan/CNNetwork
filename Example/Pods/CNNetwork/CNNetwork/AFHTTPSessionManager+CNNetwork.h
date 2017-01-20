//
//  AFHTTPSessionManager+CNNetwork.h
//  CNNetwork
//
//  Created by czm on 16/9/2.
//  Copyright © 2016年 czm. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (CNNetwork)

- (NSURLSessionDataTask *)cn_dataTaskWithHTTPMethod:(NSString *)HTTPMethod
                                          URLString:(NSString *)URLString
                                         parameters:(nullable id)parameters
                          constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                           progress:(nullable void (^)(NSProgress *))progress
                                            success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
