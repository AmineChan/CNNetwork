//
//  CNNetworkServerConfig.m
//  CNNetwork
//
//  Created by czm on 16/9/1.
//  Copyright © 2016年 czm. All rights reserved.
//

#import "CNNetworkServerConfig.h"
#import <UIKit/UIKit.h>

static NSString *const kAuthTypeBasic = @"basic";
static NSString *const kAuthTypeApiKey = @"apiKey";
static NSString *const kAuthTypeOauth2 = @"oauth2";

@interface CNNetworkServerConfig ()

@property (nonatomic, strong) NSMutableDictionary *mutableDefaultHeaders;
@property (nonatomic, strong) NSMutableDictionary *mutableApiKey;
@property (nonatomic, strong) NSMutableDictionary *mutableApiKeyPrefix;
@property (nonatomic, strong) NSMutableDictionary *mutableAuthSettings;

@end

@implementation CNNetworkServerConfig

#pragma mark - Initialize Methods

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.username = nil;
        self.password = nil;
        self.accessToken= nil;
        self.verifySSL = YES;
        self.mutableApiKey = [NSMutableDictionary dictionary];
        self.mutableApiKeyPrefix = [NSMutableDictionary dictionary];
        self.mutableDefaultHeaders = [NSMutableDictionary dictionary];
        self.mutableDefaultHeaders[@"User-Agent"] = [NSString stringWithFormat:@"cnnetwork/1.0.0/objc (%@; iOS %@; Scale/%0.2f)",[[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    }
    return self;
}

#pragma mark - Instance Methods

- (NSString *)getApiKeyWithPrefix:(NSString *)key
{
    NSString *prefix = self.apiKeyPrefix[key];
    NSString *apiKey = self.apiKey[key];
    
    // both api key prefix and api key are set
    if (prefix && apiKey != (id)[NSNull null] && apiKey.length > 0)
    {
        return [NSString stringWithFormat:@"%@ %@", prefix, apiKey];
    }
    else if (apiKey != (id)[NSNull null] && apiKey.length > 0)
    {
        // only api key, no api key prefix
        return [NSString stringWithFormat:@"%@", self.apiKey[key]];
    }
    
    // return empty string if nothing is set
    return @"";
}

- (NSString *)getBasicAuthToken
{
    // return empty string if username and password are empty
    if (self.username.length == 0 && self.password.length == 0)
    {
        return  @"";
    }
    
    NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@", self.username, self.password];
    NSData *data = [basicAuthCredentials dataUsingEncoding:NSUTF8StringEncoding];
    basicAuthCredentials = [NSString stringWithFormat:@"Basic %@", [data base64EncodedStringWithOptions:0]];
    
    return basicAuthCredentials;
}

- (NSString *)getAccessToken
{
    // token not set, return empty string
    if (self.accessToken.length == 0)
    {
        return @"";
    }
    
    return [NSString stringWithFormat:@"Bearer %@", self.accessToken];
}

#pragma mark - Setter Methods

- (void)setApiKey:(NSString *)apiKey forApiKeyIdentifier:(NSString *)identifier
{
    [self.mutableApiKey setValue:apiKey forKey:identifier];
}

- (void)removeApiKey:(NSString *)identifier
{
    [self.mutableApiKey removeObjectForKey:identifier];
}

- (void)setApiKeyPrefix:(NSString *)prefix forApiKeyPrefixIdentifier:(NSString *)identifier
{
    [self.mutableApiKeyPrefix setValue:prefix forKey:identifier];
}

- (void)removeApiKeyPrefix:(NSString *)identifier
{
    [self.mutableApiKeyPrefix removeObjectForKey:identifier];
}

#pragma mark - Getter Methods

- (NSDictionary *)apiKey
{
    return [NSDictionary dictionaryWithDictionary:self.mutableApiKey];
}

- (NSDictionary *)apiKeyPrefix
{
    return [NSDictionary dictionaryWithDictionary:self.mutableApiKeyPrefix];
}

#pragma mark -
- (void)setBasicAuthWithName:(NSString *)name
{
    [self setAuthSetting:@{@"type": kAuthTypeBasic,
                           @"in": @"header",
                           @"key": @"Authorization"
                           }
                withName:name];
}

- (void)setOAuth2AuthWithName:(NSString *)name
{
    [self setAuthSetting:@{@"type": kAuthTypeOauth2,
                           @"in": @"header",
                           @"key": @"Authorization"
                           }
                withName:name];
}

- (void)setApiKeyAuthWithName:(NSString *)name keyName:(NSString *)keyName isInHeader:(BOOL)isInHeader
{
    [self setAuthSetting:@{@"type": kAuthTypeApiKey,
                           @"in": isInHeader? @"header":@"query",
                           @"key": keyName
                           }
                withName:name];
}

- (void)setAuthSetting:(NSDictionary *)authSetting withName:(NSString *)name
{
    if (!authSetting || !name)
    {
        return;
    }
    
    if (!self.mutableAuthSettings)
    {
        self.mutableAuthSettings = [NSMutableDictionary dictionary];
    }
    
    self.mutableAuthSettings[name] = authSetting;
}

- (void)setDefaultHeaderValue:(NSString *)value forKey:(NSString *)key
{
    if(!value)
    {
        [self.mutableDefaultHeaders removeObjectForKey:key];
        return;
    }
    
    self.mutableDefaultHeaders[key] = value;
}

- (void)removeDefaultHeaderForKey:(NSString*)key
{
    [self.mutableDefaultHeaders removeObjectForKey:key];
}

- (NSString *)defaultHeaderForKey:(NSString *)key
{
    return self.mutableDefaultHeaders[key];
}

- (NSDictionary *)defaultHeaders
{
    return [self.mutableDefaultHeaders copy];
}

- (void)updateHeaderParams:(NSDictionary *__autoreleasing *)headers
               queryParams:(NSDictionary *__autoreleasing *)querys
             withAuthNames:(NSArray *)authNames
{
    if (!authNames || authNames.count == 0)
    {
        return;
    }
    
    if (!self.mutableAuthSettings)
    {
        return;
    }
    
    NSMutableDictionary *headersWithAuth = [NSMutableDictionary dictionaryWithDictionary:*headers];
    NSMutableDictionary *querysWithAuth = [NSMutableDictionary dictionaryWithDictionary:*querys];
    
    for (NSString *authName in authNames)
    {
        NSDictionary *authSetting = self.mutableAuthSettings[authName];
        if(!authSetting)
        { // auth setting is set only if the key is non-empty
            continue;
        }
        
        NSString *type = authSetting[@"type"];
        NSString *location = authSetting[@"in"];
        NSString *key = authSetting[@"key"];
        NSString *value = nil;
        if ([type isEqualToString:kAuthTypeBasic])
        {
            value = [self getBasicAuthToken];
        }
        else if ([type isEqualToString:kAuthTypeOauth2])
        {
            value = [self getAccessToken];
        }
        else if ([type isEqualToString:kAuthTypeApiKey])
        {
            value = [self getApiKeyWithPrefix:key];
        }

        if ([location isEqualToString:@"header"] && [key length] > 0 )
        {
            headersWithAuth[key] = value;
        }
        else if ([location isEqualToString:@"query"] && [key length] != 0)
        {
            querysWithAuth[key] = value;
        }
    }
    
    *headers = [NSDictionary dictionaryWithDictionary:headersWithAuth];
    *querys = [NSDictionary dictionaryWithDictionary:querysWithAuth];
}

@end
