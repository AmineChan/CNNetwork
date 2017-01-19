/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import "OSCUserApi.h"

@implementation OSCApiObjGetUserList

- (CNRequest *)apiRequest {
    NSParameterAssert(self.pageNumber);
    NSParameterAssert(self.batchSize);

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    id bodyParam = nil;

    // HTTP header `Accept`
    NSString *acceptHeader = [CNNetworkUtils selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    if (self.pageNumber) {
        formParams[@"pageNumber"] = self.pageNumber;
    }
    if (self.batchSize) {
        formParams[@"batchSize"] = self.batchSize;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"application/json", @"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_GetUserList
                                HTTPMethod:@"GET"
                              relativePath:@"/users"
                                 serverKey:@"WEB_HOST"
                              headerParams:headerParams
                                pathParams:pathParams
                               queryParams:queryParams
                                formParams:formParams
                                 bodyParam:bodyParam
                        requestContentType:requestContentType
                       responseContentType:responseContentType
                              responseType:@"NSArray<OSCUser>*"
                              authSettings:authSettings];
}

@end

@implementation OSCApiObjCreateUser

- (CNRequest *)apiRequest {
    NSParameterAssert(self.user);

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    id bodyParam = nil;

    // HTTP header `Accept`
    NSString *acceptHeader = [CNNetworkUtils selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    bodyParam = self.user;

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"application/json", @"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_CreateUser
                                HTTPMethod:@"POST"
                              relativePath:@"/users"
                                 serverKey:@"WEB_HOST"
                              headerParams:headerParams
                                pathParams:pathParams
                               queryParams:queryParams
                                formParams:formParams
                                 bodyParam:bodyParam
                        requestContentType:requestContentType
                       responseContentType:responseContentType
                              responseType:@"NSArray<OSCUser>*"
                              authSettings:authSettings];
}

@end

@implementation OSCApiObjUpdateUser

- (CNRequest *)apiRequest {
    NSParameterAssert(self.user);

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    id bodyParam = nil;

    // HTTP header `Accept`
    NSString *acceptHeader = [CNNetworkUtils selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    bodyParam = self.user;

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"application/json", @"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_UpdateUser
                                HTTPMethod:@"PUT"
                              relativePath:@"/users"
                                 serverKey:@"WEB_HOST"
                              headerParams:headerParams
                                pathParams:pathParams
                               queryParams:queryParams
                                formParams:formParams
                                 bodyParam:bodyParam
                        requestContentType:requestContentType
                       responseContentType:responseContentType
                              responseType:@"NSArray<OSCUser>*"
                              authSettings:authSettings];
}

@end

@implementation OSCApiObjFetchReceivingInfo

- (CNRequest *)apiRequest {
    NSParameterAssert(self.userId);
    NSParameterAssert(self.privateToken);

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    id bodyParam = nil;

    if (self.userId != nil) {
        pathParams[@"user_id"] = self.userId;
    }
    // HTTP header `Accept`
    NSString *acceptHeader = [CNNetworkUtils selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    if (self.privateToken) {
        formParams[@"private_token"] = self.privateToken;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"application/json", @"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_FetchReceivingInfo
                                HTTPMethod:@"GET"
                              relativePath:@"/users/{user_id}/address"
                                 serverKey:@"WEB_HOST"
                              headerParams:headerParams
                                pathParams:pathParams
                               queryParams:queryParams
                                formParams:formParams
                                 bodyParam:bodyParam
                        requestContentType:requestContentType
                       responseContentType:responseContentType
                              responseType:@"NSObject*"
                              authSettings:authSettings];
}

@end

@implementation OSCApiObjUpdateReceivingInfo

- (CNRequest *)apiRequest {
    NSParameterAssert(self.userId);
    NSParameterAssert(self.privateToken);

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    id bodyParam = nil;

    if (self.userId != nil) {
        pathParams[@"user_id"] = self.userId;
    }
    // HTTP header `Accept`
    NSString *acceptHeader = [CNNetworkUtils selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    if (self.privateToken) {
        formParams[@"private_token"] = self.privateToken;
    }
    if (self.name) {
        formParams[@"name"] = self.name;
    }
    if (self.tel) {
        formParams[@"tel"] = self.tel;
    }
    if (self.address) {
        formParams[@"address"] = self.address;
    }
    if (self.comment) {
        formParams[@"comment"] = self.comment;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"application/json", @"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_UpdateReceivingInfo
                                HTTPMethod:@"POST"
                              relativePath:@"/users/{user_id}/address"
                                 serverKey:@"WEB_HOST"
                              headerParams:headerParams
                                pathParams:pathParams
                               queryParams:queryParams
                                formParams:formParams
                                 bodyParam:bodyParam
                        requestContentType:requestContentType
                       responseContentType:responseContentType
                              responseType:nil
                              authSettings:authSettings];
}

@end

@implementation OSCApiObjDeleteUser

- (CNRequest *)apiRequest {
    NSParameterAssert(self.userId);

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    id bodyParam = nil;

    if (self.userId != nil) {
        pathParams[@"user_id"] = self.userId;
    }
    // HTTP header `Accept`
    NSString *acceptHeader = [CNNetworkUtils selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }


    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"application/json", @"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_DeleteUser
                                HTTPMethod:@"DELETE"
                              relativePath:@"/users/{user_id}"
                                 serverKey:@"WEB_HOST"
                              headerParams:headerParams
                                pathParams:pathParams
                               queryParams:queryParams
                                formParams:formParams
                                 bodyParam:bodyParam
                        requestContentType:requestContentType
                       responseContentType:responseContentType
                              responseType:nil
                              authSettings:authSettings];
}

@end

@implementation OSCApiObjGetUser

- (CNRequest *)apiRequest {
    NSParameterAssert(self.userId);

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    id bodyParam = nil;

    if (self.userId != nil) {
        pathParams[@"user_id"] = self.userId;
    }
    // HTTP header `Accept`
    NSString *acceptHeader = [CNNetworkUtils selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }


    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"application/json", @"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_GetUser
                                HTTPMethod:@"GET"
                              relativePath:@"/users/{user_id}"
                                 serverKey:@"WEB_HOST"
                              headerParams:headerParams
                                pathParams:pathParams
                               queryParams:queryParams
                                formParams:formParams
                                 bodyParam:bodyParam
                        requestContentType:requestContentType
                       responseContentType:responseContentType
                              responseType:@"NSArray<OSCUser>*"
                              authSettings:authSettings];
}

@end

