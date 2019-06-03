//
//  CaseInvestigate.h
//  FoKaiMobile
//
//  Created by admin on 2019/5/30.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseManageObject.h"

@interface CaseInvestigate : BaseManageObject

@property (nonatomic,retain) NSString * myid;
@property (nonatomic,retain) NSString * investigater_name;            // 调查人名称
@property (nonatomic,retain) NSString * course; //  案件调查经过
@property (nonatomic,retain) NSString * obey_laws; // 依据法律
@property (nonatomic,retain) NSString * disobey_laws; // 违反的法律
@property (nonatomic,retain) NSString * conclusion; //  案件调查结论
@property (nonatomic,retain) NSString * witness; //  所附证据材料
@property (nonatomic,retain) NSString * leader_comment; // 领导意见
@property (nonatomic,retain) NSString * leader_name; //领导名字
@property (nonatomic,retain) NSDate * leader_date;  //领导签字日期
@property (nonatomic,retain) NSString * remark; //备注

@property (nonatomic, retain) NSNumber * isuploaded;


+(CaseInvestigate *)InvestigateForCase:(NSString *)caseID;

@end
