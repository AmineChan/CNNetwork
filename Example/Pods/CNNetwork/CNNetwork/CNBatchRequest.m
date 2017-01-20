//
//  CNBatchRequest.m
//  CNNetwork
//
//  Created by czm on 2016/12/27.
//  Copyright © 2016年 czm. All rights reserved.
//

#import "CNBatchRequest.h"

@interface CNBatchRequestAgent : NSObject
@property (strong, nonatomic) NSMutableArray<CNBatchRequest *> *requestArray;

+ (CNBatchRequestAgent *)sharedInstance;

- (void)addRequest:(CNBatchRequest *)request;
- (void)removeRequest:(CNBatchRequest *)request;

@end

@implementation CNBatchRequestAgent

+ (CNBatchRequestAgent *)sharedInstance
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
        _requestArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)addRequest:(CNBatchRequest *)request
{
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeRequest:(CNBatchRequest *)request
{
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end

@interface CNBatchRequest()

@property (nonatomic, strong) NSArray<CNRequest *> *requestArrray;
@property (nonatomic, copy) CNBatchRequestCompleteBlock completionBlock;
@property (nonatomic) NSInteger finishedCount;

@end

@implementation CNBatchRequest
- (void)dealloc
{
    self.requestArrray = nil;
    self.completionBlock = nil;
}

- (instancetype)initWithRequestArray:(NSArray<CNRequest *> *)requestArray
{
    self = [super init];
    if (self)
    {
        self.requestArrray = requestArray;
        _finishedCount = 0;
    }
    
    return self;
}

- (NSArray *)allRequest
{
    return _requestArrray;
}

- (void)startWithCompletionBlock:(CNBatchRequestCompleteBlock)completionBlock
{
    self.completionBlock = completionBlock;
    [self start];
}

- (void)start
{
    __weak CNBatchRequest *ws = self;
    if (_finishedCount > 0)
    {
        [self stop];
    }
    
    _finishedCount = 0;
    [[CNBatchRequestAgent sharedInstance] addRequest:self];

    for (CNRequest *request in _requestArrray)
    {
        [request setCompletionBlockForBatch:^(CNRequest * _Nonnull theRequest, id _Nonnull data, NSError * _Nonnull error) {
            [ws onRequestCompleted:theRequest data:data error:error];
        }];
        [request start];
    }
}

- (void)stop
{
    for (CNRequest *request in _requestArrray)
    {
        [request stop];
    }
    
    [[CNBatchRequestAgent sharedInstance] removeRequest:self];
}

- (void)onRequestCompleted:(CNRequest *)request data:(id)data error:(NSError *)error
{
    _finishedCount ++;
    if (error)
    {
        [self stop];
        if (_completionBlock)
        {
            _completionBlock(error);
        }
        return;
    }
    
    if (_finishedCount == _requestArrray.count)
    {
        if (_completionBlock)
        {
            _completionBlock(error);
        }
        [[CNBatchRequestAgent sharedInstance] removeRequest:self];
    }
}

@end
