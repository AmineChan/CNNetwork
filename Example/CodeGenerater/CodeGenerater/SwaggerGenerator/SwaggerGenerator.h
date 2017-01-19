//
//  SwaggerGenerator.h
//  CodeGenerater
//
//  Created by czm on 16/4/27.
//  Copyright © 2016年 czm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwaggerGenerator : NSObject

//生成接口、模型等文件
- (void)genApi;
//生成文档
- (void)genDoc;

@end
