//
//  CaseInvestigate.m
//  FoKaiMobile
//
//  Created by admin on 2019/5/30.
//

#import "CaseInvestigate.h"

@implementation CaseInvestigate

@dynamic myid;
@dynamic investigater_name;
@dynamic course; //  案件调查经过
@dynamic obey_laws; // 依据法律
@dynamic disobey_laws; // 违反的法律
@dynamic conclusion; //  案件调查结论
@dynamic witness; //  所附证据材料
@dynamic leader_comment; // 领导意见
@dynamic leader_name; //领导名字
@dynamic leader_date;  //领导签字日期
@dynamic remark; //备注
@dynamic isuploaded;


+(CaseInvestigate *)InvestigateForCase:(NSString *)caseID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSPredicate *predicate;
    predicate=[NSPredicate predicateWithFormat:@"myid==%@",caseID];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSArray *tempArray=[context executeFetchRequest:fetchRequest error:nil];
    if (tempArray && [tempArray count]>0) {
        return [tempArray objectAtIndex:0];
    }else{
        return nil;
    }
}

@end
