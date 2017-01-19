//
//  SwaggerGenerator.m
//  CodeGenerater
//
//  Created by czm on 16/4/27.
//  Copyright © 2016年 czm. All rights reserved.
//

#import "SwaggerGenerator.h"

@interface NSString (Addtion)
- (NSString *)trim;
@end

@implementation NSString (Addtion)

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

@interface SwaggerGenerator()
@property (nonatomic) NSString *shellDir;
@property (nonatomic) NSString *specFileUrl;

@end

@implementation SwaggerGenerator
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.shellDir = [PROJECT_DIR stringByAppendingPathComponent:@"/shell"];
//    self.specFileUrl = @"https://raw.githubusercontent.com/czm/xiangweiapi/master/xw_api_user.yaml";
    self.specFileUrl = [self.shellDir stringByAppendingPathComponent:@"spec.yaml"];
}

- (void)genApi {
    NSString *codegenShellPath = [self.shellDir stringByAppendingPathComponent:@"codegen4Api.sh"];
    [self runShell:codegenShellPath arguments:@[self.shellDir, self.specFileUrl]];
}

- (void)genDoc {
    NSString *codegenShellPath = [self.shellDir stringByAppendingPathComponent:@"codegen4Doc.sh"];
    [self runShell:codegenShellPath arguments:@[self.shellDir, self.specFileUrl]];
}

- (void)runShell:(NSString *)path arguments:(NSArray<NSString *> *)arguments {
    NSTask *task = [[NSTask alloc] init];
    [task setCurrentDirectoryPath:PROJECT_DIR];
    [task setLaunchPath:path];
    [task setArguments:arguments];
    
    [task launch];
    [task waitUntilExit];
}

@end
