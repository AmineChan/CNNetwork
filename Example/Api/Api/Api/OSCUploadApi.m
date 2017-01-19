/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import "OSCUploadApi.h"

@implementation OSCApiObjUploadAvatar

- (CNRequest *)apiRequest {

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


    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";
    // request content type
    NSString *requestContentType = [CNNetworkUtils selectHeaderContentType:@[@"multipart/form-data"]];
    // Authentication setting
    NSArray *authSettings = @[@"oauth"];

    return [[CNRequest alloc] initWithTag:API_TAG_UploadAvatar
                                HTTPMethod:@"POST"
                              relativePath:@"/auth/avatar-upload"
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

