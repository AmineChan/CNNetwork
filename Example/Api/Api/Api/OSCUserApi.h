/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import <Foundation/Foundation.h>
#import "OSCApiObj.h"
#import "OSCUser.h"

/* 获取用户列表 */
@interface OSCApiObjGetUserList: OSCApiObj
@property(nonatomic) NSNumber* pageNumber; //页码
@property(nonatomic) NSNumber* batchSize; //请求的条数
@end

/* 新建用户 */
@interface OSCApiObjCreateUser: OSCApiObj
@property(nonatomic) OSCUser* user; 
@end

/* 修改用户 */
@interface OSCApiObjUpdateUser: OSCApiObj
@property(nonatomic) OSCUser* user; 
@end

/* 获取用户联系方式 */
@interface OSCApiObjFetchReceivingInfo: OSCApiObj
@property(nonatomic) NSString* userId; 
@property(nonatomic) NSString* privateToken; 
@end

/* 修改用户联系方式 */
@interface OSCApiObjUpdateReceivingInfo: OSCApiObj
@property(nonatomic) NSString* userId; 
@property(nonatomic) NSString* privateToken; 
@property(nonatomic) NSString* name; 
@property(nonatomic) NSString* tel; 
@property(nonatomic) NSString* address; 
@property(nonatomic) NSString* comment; 
@end

/* 删除用户 */
@interface OSCApiObjDeleteUser: OSCApiObj
@property(nonatomic) NSString* userId; 
@end

/* 获取用户 */
@interface OSCApiObjGetUser: OSCApiObj
@property(nonatomic) NSString* userId; 
@end

