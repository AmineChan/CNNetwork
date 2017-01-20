/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import <Foundation/Foundation.h>
#import <CNNetwork/CNNetwork.h>

/**
 * A key for deserialization ErrorDomain
 */
extern NSString *const OSCDeserializationErrorDomainKey;

/**
 * Code for deserialization type mismatch error
 */
extern NSInteger const OSCTypeMismatchErrorCode;

/**
 * Code for deserialization empty value error
 */
extern NSInteger const OSCEmptyValueOccurredErrorCode;

/**
 * Error code for unknown response
 */
extern NSInteger const OSCUnknownResponseObjectErrorCode;

@interface OSCResponseDeserializer : NSObject <CNNetworkResponseDeserializer>

/**
 *  If an null value occurs in dictionary or array if set to YES whole response will be invalid else will be ignored
 *  @default NO
 */
@property (nonatomic, assign) BOOL treatNullAsError;

@end
