//
//  CNQueryParamCollection.h
//  CNNetwork
//
//  Created by czm on 16/9/2.
//  Copyright © 2016年 czm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNQueryParamCollection : NSObject

@property (nonatomic, readonly) NSArray *values;
@property (nonatomic, readonly) NSString *format;

- (instancetype)initWithValuesAndFormat:(NSArray *)values format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
