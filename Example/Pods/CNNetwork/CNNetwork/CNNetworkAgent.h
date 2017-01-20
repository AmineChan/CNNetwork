//
//  CUNetworkAgent.h
//  CNNetwork
//
//  Created by czm on 15/11/22.
//  Copyright © 2015年 czm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "CNRequest.h"
#import "CNBatchRequest.h"
#import "CNNetworkServer.h"
#import "CNQueryParamCollection.h"

NS_ASSUME_NONNULL_BEGIN

@class CNNetworkAgent;
@protocol CNNetworkAgentDelegate, CNNetworkSessionDelegate, CNNetworkRequestParamSerializer, CNNetworkResponseDeserializer, CNNetworkErrorSerializer;

/**
 *  network agent
 */
@interface CNNetworkAgent : NSObject

@property (nonatomic, weak) id<CNNetworkAgentDelegate> delegate;
@property (nonatomic, weak) id<CNNetworkSessionDelegate> sessionDelegate;
@property (nonatomic, strong) id<CNNetworkRequestParamSerializer> requestParamSerializer;
@property (nonatomic, strong) id<CNNetworkResponseDeserializer> responseDeserializer;
@property (nonatomic, strong) id<CNNetworkErrorSerializer> errorSerializer;

@property (nonatomic, strong, readonly) NSDate *lastSessionTime;
@property (nonatomic) NSTimeInterval sesssionTimeout; //default is 20 minutes.

+ (CNNetworkAgent *)sharedInstance;

/**
 *  start request
 *
 *  @param request
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)startAsynRequest:(CNRequest *)request;

/**
 *  cancel a task
 *
 *  @param dataTask
 */
- (void)cancelDataTask:(NSURLSessionDataTask *)dataTask;

/**
 *  cancel all task
 */
- (void)cancelAll;

@end

@protocol CNNetworkAgentDelegate <NSObject>

@required
- (void)networkAgent:(CNNetworkAgent *)agent willStartRequest:(CNRequest *)request;
- (void)networkAgent:(CNNetworkAgent *)agent willStopRequest:(CNRequest *)request;
- (void)networkAgent:(CNNetworkAgent *)agent didStopRequest:(CNRequest *)request error:(nullable NSError *)error;

@end

/**
 *  session delegate，use to auto refresh session
 */
@protocol CNNetworkSessionDelegate <NSObject>

@required
- (BOOL)sessionAvailableForRequest:(CNRequest *)request;
- (CNRequest *)requestForSession;
- (BOOL)isSessionRequest:(CNRequest *)request;
- (void)sessionRequestCompleted:(CNRequest *)request data:(id)data error:(NSError *)error;

@end

/**
 *  Request Param Serializer
 */
@protocol CNNetworkRequestParamSerializer <NSObject>

@required
- (id)serializationParam:(id)object;

@end

/**
 *  Response Deserializer
 */
@protocol CNNetworkResponseDeserializer <NSObject>

@required
- (id)deserialize:(id)responseObject class:(NSString *)className error:(NSError **)error;

@end

/**
 *  error serializer
 */
@protocol CNNetworkErrorSerializer <NSObject>

@required
- (NSError *)serializationError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
