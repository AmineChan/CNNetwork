//
//  CNBatchRequest.h
//  CNNetwork
//
//  Created by czm on 2016/12/27.
//  Copyright © 2016年 czm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNRequest.h"

typedef void (^CNBatchRequestCompleteBlock)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface CNBatchRequest : NSObject

- (instancetype)initWithRequestArray:(NSArray<CNRequest *> *)requestArray;

- (void)startWithCompletionBlock:(nullable CNBatchRequestCompleteBlock)completionBlock;
- (void)stop;

- (NSArray *)allRequest;

@end

NS_ASSUME_NONNULL_END
