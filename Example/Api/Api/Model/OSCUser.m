/* AUTO-GENERATED FILE.  DO NOT MODIFY.
*
* 该文件自动生成，请不要修改！
*/

#import "OSCUser.h"

@implementation OSCUser

- (instancetype)init {
  self = [super init];
  if (self) {
    // initialize property's default value, if any
    
  }
  return self;
}


/**
 * Maps json key to property name.
 * This method is used by `JSONModel`.
 */
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"id": @"_id", @"username": @"username", @"name": @"name", @"bio": @"bio", @"weibo": @"weibo", @"blog": @"blog", @"theme_id": @"themeId", @"state": @"state", @"created_at": @"createdAt", @"portrait": @"portrait", @"email": @"email", @"private_token": @"privateToken", @"is_admin": @"isAdmin", @"can_create_group": @"canCreateGroup", @"can_create_project": @"canCreateProject", @"can_create_team": @"canCreateTeam", @"follow": @"follow" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {

  NSArray *optionalProperties = @[@"_id", @"username", @"name", @"bio", @"weibo", @"blog", @"themeId", @"state", @"createdAt", @"portrait", @"email", @"privateToken", @"isAdmin", @"canCreateGroup", @"canCreateProject", @"canCreateTeam", @"follow"];
  return [optionalProperties containsObject:propertyName];
}

@end
