//
//  CNQueryParamCollection.m
//  CNNetwork
//
//  Created by czm on 16/9/2.
//  Copyright © 2016年 czm. All rights reserved.
//

#import "CNQueryParamCollection.h"

@implementation CNQueryParamCollection

- (instancetype)initWithValuesAndFormat:(NSArray *)values format:(NSString *)format
{
    self = [super init];
    if (self)
    {
        _values = values;
        _format = format;
    }
    
    return self;
}

@end
