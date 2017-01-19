/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@protocol OSCUser
@end

@interface OSCUser : JSONModel

/* id [optional]
 */
@property(nonatomic) NSNumber* _id;
/* username [optional]
 */
@property(nonatomic) NSString* username;
/* name [optional]
 */
@property(nonatomic) NSString* name;
/* bio [optional]
 */
@property(nonatomic) NSString* bio;
/* weibo [optional]
 */
@property(nonatomic) NSString* weibo;
/* blog [optional]
 */
@property(nonatomic) NSString* blog;
/* theme_id [optional]
 */
@property(nonatomic) NSNumber* themeId;
/* state [optional]
 */
@property(nonatomic) NSString* state;
/* created_at [optional]
 */
@property(nonatomic) NSString* createdAt;
/* portrait [optional]
 */
@property(nonatomic) NSString* portrait;
/* email [optional]
 */
@property(nonatomic) NSString* email;
/* private_token [optional]
 */
@property(nonatomic) NSString* privateToken;
/* is_admin [optional]
 */
@property(nonatomic) NSNumber* isAdmin;
/* can_create_group [optional]
 */
@property(nonatomic) NSNumber* canCreateGroup;
/* can_create_project [optional]
 */
@property(nonatomic) NSNumber* canCreateProject;
/* can_create_team [optional]
 */
@property(nonatomic) NSNumber* canCreateTeam;
/* follow [optional]
 */
@property(nonatomic) NSObject* follow;

@end
