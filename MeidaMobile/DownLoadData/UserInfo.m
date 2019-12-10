//
//  UserInfo.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-11-14.
//
//

#import "UserInfo.h"
#import "OrgInfo.h"


@implementation UserInfo

@dynamic code;
@dynamic address;
@dynamic cardid;
@dynamic duty;
@dynamic exelawid;
@dynamic myid;
@dynamic organization_id;
@dynamic password;
@dynamic sex;
@dynamic telephone;
@dynamic title;
@dynamic name;

//返回执法证号
+ (NSString *)exelawidforname:(NSString *)name{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@",name]];
    NSArray *array = [context executeFetchRequest:fetchRequest error:nil] ;
    id info = nil;
    if (array != nil && array.count > 0) {
        info = [array objectAtIndex:0];
    }
    return [info exelawid]?[info exelawid]:@"";
}

+ (UserInfo *)userInfoForUserID:(NSString *)userID {
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"myid == %@",userID]];
    NSArray *temp=[context executeFetchRequest:fetchRequest error:nil];
    if (temp.count>0) {
        return [temp lastObject];
    } else {
        return nil;
    }
}

+ (NSArray *)allUserInfo{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"code != 'admin'"]];
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"not (SELF.code CONTAINS 'admin'"]];
    return [context executeFetchRequest:fetchRequest error:nil];
}

//返回名字的机构和职务
+ (NSString *)orgAndDutyForUserName:(NSString *)username{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@",username]];
    id info = [[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
    NSString *duty = [info duty]?[info duty]:@"";
    OrgInfo *org = [OrgInfo orgInfoForOrgID:[info organization_id]];
    NSString * orgName = [org orgname]?[org orgname]:@"";
    orgName = [[[orgName stringByReplacingOccurrencesOfString:@"三中队" withString:@""] stringByReplacingOccurrencesOfString:@"一中队" withString:@""] stringByReplacingOccurrencesOfString:@"二中队" withString:@""];
    return [NSString stringWithFormat:@"%@%@",orgName,duty];
}
//返回执法证号
+ (NSString *)exelawIDForUserName:(NSString *)username{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@",username]];
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];
    if (results.count == 0) {
        return @"";
    }
    id info = [[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
    NSString *exelawid = [info exelawid]?[info exelawid]:@"";
    return [NSString stringWithFormat:@"%@",exelawid];
}
@end
