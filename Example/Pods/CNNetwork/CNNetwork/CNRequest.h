//
//  CNRequest.h
//  CNNetwork
//
//  Created by czm on 2017/1/11.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNRequest : NSObject

@property (nonatomic) NSInteger tag;
@property (nonatomic) NSString *HTTPMethod;
@property (nonatomic) NSString *relativePath;//relative path
@property (nonatomic) NSString *serverKey;//server key，use to get server config.
@property (nonatomic, nullable) NSString *requestContentType;
@property (nonatomic, nullable) NSString *responseContentType;
@property (nonatomic, nullable) NSString *responseType;
@property (nonatomic, nullable) NSArray *authSettings;//security

@property (nonatomic, nullable) NSDictionary *headerParams;
@property (nonatomic, nullable) NSDictionary *pathParams;
@property (nonatomic, nullable) NSDictionary *queryParams;
@property (nonatomic, nullable) NSDictionary *formParams;
@property (nonatomic, nullable) id bodyParam;

@property (nonatomic, copy) void (^completionBlockForBatch)(CNRequest *request, id data, NSError *error);//批量处理时使用的block
@property (nonatomic, copy) void (^completionBlock)(CNRequest *request, id data, NSError *error);
@property (nonatomic, copy) void (^progressBlock)(NSProgress *progress);
@property (nonatomic, copy) void (^constructingBodyBlock)(id <AFMultipartFormData> formData);
@property (nonatomic, strong, readonly, nullable) NSURLSessionDataTask *dataTask;

- (instancetype)initWithTag:(NSInteger)tag
                 HTTPMethod:(NSString *)HTTPMethod
               relativePath:(NSString *)relativePath
                  serverKey:(NSString *)serverKey
               headerParams:(nullable NSDictionary *)headerParams
                 pathParams:(nullable NSDictionary *)pathParams
                queryParams:(nullable NSDictionary *)queryParams
                 formParams:(nullable NSDictionary *)formParams
                  bodyParam:(nullable id)bodyParam
         requestContentType:(nullable NSString *)requestContentType
        responseContentType:(nullable NSString *)responseContentType
               responseType:(nullable NSString *)responseType
               authSettings:(nullable NSArray *)authSettings;

- (void)startWithCompletionBlock:(nullable void (^)(CNRequest *request, id data, NSError *error))completionBlock;

- (void)startWithCompletionBlock:(nullable void (^)(CNRequest *request, id data, NSError *error))completionBlock
                   progressBlock:(nullable void (^)(NSProgress *))progressBlock
       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))constructingBodyBlock;

- (void)start;
- (void)stop;
- (BOOL)isExecuting;

@end

@interface CNURLRequest : CNRequest

@property (nonatomic, nullable) NSURLRequest *urlRequest;

@end

NS_ASSUME_NONNULL_END
