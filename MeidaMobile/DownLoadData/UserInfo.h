//
//  UserInfo.h
//  GDRMMobile
//
//  Created by yu hongwu on 12-11-14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * cardid;
@property (nonatomic, retain) NSString * duty;
@property (nonatomic, retain) NSString * exelawid;
@property (nonatomic, retain) NSString * myid;
@property (nonatomic, retain) NSString * organization_id;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * name;

+ (UserInfo *)userInfoForUserID:(NSString *)userID;

+ (NSArray *)allUserInfo;

+ (NSString *)exelawidforname:(NSString *)name;

+ (NSString *)orgAndDutyForUserName:(NSString *)username;
@end
