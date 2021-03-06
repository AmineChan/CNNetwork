/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import "OSCRequestParamSerializer.h"
#import <JSONModel/JSONModel.h>
#import <ISO8601/ISO8601.h>

@interface OSCRequestParamSerializer ()
@end

@implementation OSCRequestParamSerializer

- (id)serializationParam:(id) object
{
    if (object == nil) {
        return nil;
    }

    if ([object isKindOfClass:[NSString class]]
    || [object isKindOfClass:[NSNumber class]]
    || [object isKindOfClass:[CNQueryParamCollection class]]) {
        return object;
    }

    if ([object isKindOfClass:[NSDate class]]) {
        return [self dateParameterToString:object];
    }

    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *objectArray = object;
        NSMutableArray *sanitizedObjs = [NSMutableArray arrayWithCapacity:[objectArray count]];
        [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id sanitizedObj = [self serializationParam:obj];
            if (sanitizedObj)
            {
                [sanitizedObjs addObject:sanitizedObj];
            }
        }];

        return sanitizedObjs;
    }

    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objectDict = object;
        NSMutableDictionary *sanitizedObjs = [NSMutableDictionary dictionaryWithCapacity:[objectDict count]];
        [object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id sanitizedObj = [self serializationParam:obj];
            if (sanitizedObj) {
                sanitizedObjs[key] = sanitizedObj;
            }
        }];

        return sanitizedObjs;
    }

    if ([object isKindOfClass:[JSONModel class]]) {
        return [object toDictionary];
    }

    NSException *e = [NSException
                      exceptionWithName:@"InvalidObjectArgumentException"
                      reason:[NSString stringWithFormat:@"*** The argument object: %@ is invalid", object]
                      userInfo:nil];
    @throw e;
}

- (NSString *)dateParameterToString:(id)param
{
    return [param ISO8601String];
}

@end
