/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import "OSCAuthApi.h"

@implementation OSCApiObjSignIn

- (CNRequest *)apiRequest {
    NSParameterAssert(self.email);
    NSParameterAssert(self.password);

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

    if (self.email) {
        formParams[@"email"] = self.email;
    }
    if (self.password) {
        formParams[@"password"] = self.password;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"application/json", @"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_SignIn
                               HTTPMethod:@"POST"
                             relativePath:@"/session"
                                serverKey:@"WEB_HOST"
                             headerParams:headerParams
                               pathParams:pathParams
                              queryParams:queryParams
                               formParams:formParams
                                bodyParam:bodyParam
                       requestContentType:requestContentType
                      responseContentType:responseContentType
                             responseType:@"OSCUser*"
                                authNames:authSettings];
}

@end

