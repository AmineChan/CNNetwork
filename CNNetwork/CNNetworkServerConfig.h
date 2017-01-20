//
//  CNNetworkServerConfig.h
//  CNNetwork
//
//  Created by czm on 16/9/1.
//  Copyright © 2016年 czm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNNetworkServerConfig : NSObject

/**
 * Default base url
 */
@property (nonatomic) NSString *host;

/**
 * Api key values for Api Key type Authentication
 *
 * To add or remove api key, use `setApiKey:forApiKeyIdentifier:`.
 */
@property (readonly, nonatomic, strong) NSDictionary *apiKey;

/**
 * Api key prefix values to be prepend to the respective api key
 *
 * To add or remove prefix, use `setApiKeyPrefix:forApiKeyPrefixIdentifier:`.
 */
@property (readonly, nonatomic, strong) NSDictionary *apiKeyPrefix;

/**
 *  Authentication Settings
 */
@property (nonatomic, strong) NSDictionary *authSettings;

/**
 * Username for HTTP Basic Authentication
 */
@property (nonatomic, nullable) NSString *username;

/**
 * Password for HTTP Basic Authentication
 */
@property (nonatomic, nullable) NSString *password;

/**
 * Access token for OAuth
 */
@property (nonatomic, nullable) NSString *accessToken;

/**
 * Temp folder for file download
 */
@property (nonatomic, nullable) NSString *tempFolderPath;

/**
 * SSL/TLS verification
 * Set this to NO to skip verifying SSL certificate when calling API from https server
 */
@property (nonatomic) BOOL verifySSL;

/**
 * SSL/TLS verification
 * Set this to customize the certificate file to verify the peer
 */
@property (nonatomic, nullable) NSString *sslCaCert;

/**
 * Sets API key
 *
 * To remove a apiKey for an identifier, just set the apiKey to nil.
 *
 * @param apiKey     API key or token.
 * @param identifier API key identifier (authentication schema).
 *
 */
- (void)setApiKey:(NSString *)apiKey forApiKeyIdentifier:(NSString*)identifier;

/**
 * Removes api key
 *
 * @param identifier API key identifier.
 */
- (void)removeApiKey:(NSString *)identifier;

/**
 * Sets the prefix for API key
 *
 * @param prefix API key prefix.
 * @param identifier   API key identifier.
 */
- (void)setApiKeyPrefix:(NSString *)prefix forApiKeyPrefixIdentifier:(NSString *)identifier;

/**
 * Removes api key prefix
 *
 * @param identifier API key identifier.
 */
- (void)removeApiKeyPrefix:(NSString *)identifier;

/**
 * Gets API key (with prefix if set)
 */
- (NSString *)getApiKeyWithPrefix:(NSString *)key;

/**
 * Gets Basic Auth token
 */
- (NSString *)getBasicAuthToken;

/**
 * Gets OAuth access token
 */
- (NSString *)getAccessToken;

/**
 * Default headers for all services
 */
@property (readonly, nonatomic, strong) NSDictionary *defaultHeaders;

/**
 * Removes header from defaultHeaders
 *
 * @param key Header name.
 */
- (void)removeDefaultHeaderForKey:(NSString *)key;

/**
 * Sets the header for key
 *
 * @param value         Value for header name
 * @param key           Header name
 */
- (void)setDefaultHeaderValue:(NSString *)value forKey:(NSString *)key;

/**
 * @param key Header key name.
 */
- (nullable NSString *)defaultHeaderForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

