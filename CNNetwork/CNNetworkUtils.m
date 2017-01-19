//
//  CNNetworkUtils.m
//  CNNetwork
//
//  Created by czm on 15/11/22.
//  Copyright © 2015年 czm. All rights reserved.
//

#import "CNNetworkUtils.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#include <dns.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <resolv.h>
#import <SystemConfiguration/SystemConfiguration.h>

#define REGULAREXPRESSION_OPTION(regularExpression,regex,option) \
\
static inline NSRegularExpression * k##regularExpression() { \
static NSRegularExpression *_##regularExpression = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_##regularExpression = [[NSRegularExpression alloc] initWithPattern:(regex) options:(option) error:nil];\
});\
\
return _##regularExpression;\
}\

#define REGULAREXPRESSION(regularExpression, regex) REGULAREXPRESSION_OPTION(regularExpression,regex,NSRegularExpressionCaseInsensitive)

REGULAREXPRESSION(CNJsonHeaderTypeExpression, @"(.*)application(.*)json(.*)")
static NSString * kCNApplicationJSONType = @"application/json";

NSString *CNPercentEscapedStringFromString(NSString *string)
{
    static NSString * const kCNCharactersGeneralDelimitersToEncode = @":#[]@";
    static NSString * const kCNCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kCNCharactersGeneralDelimitersToEncode stringByAppendingString:kCNCharactersSubDelimitersToEncode]];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < string.length)
    {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
        NSUInteger length = MIN(string.length - index, batchSize);
#pragma GCC diagnostic pop
        NSRange range = NSMakeRange(index, length);
        
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}

@implementation CNNetworkUtils

+ (NSString *)getDNSServers
{
    NSMutableString *address = [[NSMutableString alloc] init];
    res_state res = malloc(sizeof(struct __res_state));
    int result = res_ninit(res);
    if (result == 0)
    {
        for (int i=0; i < res->nscount;  i++)
        {
            NSString *s = [NSString stringWithUTF8String:inet_ntoa(res->nsaddr_list[i].sin_addr)];
            [address appendFormat:@"%@\n", s];
        }
    }
    else
    {
        [address appendString:@"res_init result !=0"];
    }
    
    return address;
}


+ (NSString *)hostname
{
    char basehostname[255];
    int success = gethostname(basehostname, 255);
    if (success != 0)
    {
        return nil;
    }
    
    basehostname[254]='\0';
    
#if !TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s.local", basehostname];
#else
    return [NSString stringWithFormat:@"%s", basehostname];
#endif
}

+ (BOOL)canReachNetwork
{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    //根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    return (isReachable && !needsConnection) ? YES : NO;
}

//url类型检查
+ (BOOL)validateUrl:(NSString *)urlStr
{
    if (nil == urlStr)
    {
        return NO;
    }
    
    NSString *regrexUrl = @"\\b((?:[\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|(?:[^\\p{Punct}\\s]|/)))";
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regrexUrl];
    
    return [urlPredicate evaluateWithObject:urlStr];
}

/*
 * Detect `Accept` from accepts
 */
+ (NSString *)selectHeaderAccept:(NSArray *)accepts
{
    if (accepts.count == 0)
    {
        return @"";
    }
    
    NSMutableArray *lowerAccepts = [[NSMutableArray alloc] initWithCapacity:[accepts count]];
    for (NSString *string in accepts)
    {
        if ([kCNJsonHeaderTypeExpression() matchesInString:string options:0 range:NSMakeRange(0, [string length])].count > 0)
        {
            return kCNApplicationJSONType;
        }
        
        [lowerAccepts addObject:[string lowercaseString]];
    }
    
    return [lowerAccepts componentsJoinedByString:@", "];
}

/*
 * Detect `Content-Type` from contentTypes
 */
+ (NSString *)selectHeaderContentType:(NSArray *)contentTypes
{
    if (contentTypes.count == 0)
    {
        return kCNApplicationJSONType;
    }
    
    NSMutableArray *lowerContentTypes = [[NSMutableArray alloc] initWithCapacity:[contentTypes count]];
    for (NSString *string in contentTypes)
    {
        if([kCNJsonHeaderTypeExpression() matchesInString:string options:0 range:NSMakeRange(0, [string length])].count > 0)
        {
            return kCNApplicationJSONType;
        }
        
        [lowerContentTypes addObject:[string lowercaseString]];
    }
    
    return [lowerContentTypes firstObject];
}

@end
