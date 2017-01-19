//
//  Document.m
//  LafGenerater
//
//  Created by czm on 13-11-14.
//  Copyright (c) 2013年 __czm__. All rights reserved.
//

#import "Document.h"
#import "SwaggerGenerator.h"

@implementation Document

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (NSString *)windowNibName {
    return @"Document";
}

- (NSString *)displayName {
    NSString *docTitle = @"Untitled";
    NSArray *windowControllers = [self windowControllers];
    
    if ([windowControllers count] > 0)
    {
        NSWindowController *controller = [windowControllers objectAtIndex: 0];
        NSWindow *window = [controller window];
        docTitle = [window title];
    }
    
    return docTitle;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
}

- (IBAction)swaggerGenApi:(id)sender {
    [[SwaggerGenerator new] genApi];
}

- (IBAction)swaggerGenDoc:(id)sender {
    [[SwaggerGenerator new] genDoc];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

@end
