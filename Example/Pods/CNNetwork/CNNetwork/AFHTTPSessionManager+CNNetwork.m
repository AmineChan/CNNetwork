//
//  AFHTTPSessionManager+CNNetwork.m
//  CNNetwork
//
//  Created by czm on 16/9/2.
//  Copyright © 2016年 czm. All rights reserved.
//

#import "AFHTTPSessionManager+CNNetwork.h"

@implementation AFHTTPSessionManager (CNNetwork)

- (NSURLSessionDataTask *)cn_dataTaskWithHTTPMethod:(NSString *)HTTPMethod
                                          URLString:(NSString *)URLString
                                         parameters:(id)parameters
                          constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                           progress:(void (^)(NSProgress *))progress
                                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *method = [HTTPMethod uppercaseString];
    if ([method isEqualToString:@"GET"])
    {
        return [self cn_dataTaskWithHTTPMethod:method URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:progress success:success failure:failure];
    }
    
    if ([method isEqualToString:@"POST"])
    {
        if (block)
        {
            return [self cn_POST:URLString parameters:parameters constructingBodyWithBlock:block progress:progress success:success failure:failure];
        }
        else
        {
            return [self cn_dataTaskWithHTTPMethod:method URLString:URLString parameters:parameters uploadProgress:progress downloadProgress:nil success:success failure:failure];
        }
    }
    
    if ([method isEqualToString:@"HEAD"]
        || [method isEqualToString:@"PUT"]
        || [method isEqualToString:@"DELETE"]
        || [method isEqualToString:@"PATCH"])
    {
        return [self cn_dataTaskWithHTTPMethod:method URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    }
    
    return nil;
}

- (NSURLSessionDataTask *)cn_POST:(NSString *)URLString
                       parameters:(id)parameters
        constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    //    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)cn_dataTaskWithHTTPMethod:(NSString *)method
                                          URLString:(NSString *)URLString
                                         parameters:(id)parameters
                                     uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                   downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                            success:(void (^)(NSURLSessionDataTask *, id))success
                                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               if (failure) {
                                   failure(dataTask, error);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                       }];
    
    return dataTask;
}

@end
