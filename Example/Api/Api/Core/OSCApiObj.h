/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import <Foundation/Foundation.h>
#import <CNNetwork/CNNetwork.h>

//api tag
typedef enum
{
    API_TAG_NONE,
    API_TAG_SignIn,//登录
    API_TAG_UploadAvatar,//上传头像
    API_TAG_GetUserList,//获取用户列表
    API_TAG_CreateUser,//新建用户
    API_TAG_UpdateUser,//修改用户
    API_TAG_FetchReceivingInfo,//获取用户联系方式
    API_TAG_UpdateReceivingInfo,//修改用户联系方式
    API_TAG_DeleteUser,//删除用户
    API_TAG_GetUser,//获取用户

}ENUM_API_TAG;

@protocol OSCApi <NSObject>

- (CNRequest *)apiRequest;

@end

@interface OSCApiObj: NSObject <OSCApi>

- (void)startWithCompletionBlock:(void (^)(CNRequest *request, id data, NSError *error))completionBlock;

@end
