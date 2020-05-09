//
//  ccc.m
//  FoKaiMobile
//
//  Created by admin on 2020/4/30.
//

#import "Inspection_ClassMain.h"

@implementation Inspection_ClassMain

@dynamic myid;
@dynamic inspectionid;
@dynamic org_id;
@dynamic date_inspection;
@dynamic inspection_mile;
@dynamic inspection_man_num;
@dynamic fxqx;
@dynamic fxwfxw;
@dynamic jzwfxw;
@dynamic cllmzaw;
@dynamic bzgzc;
@dynamic gzzfj;
@dynamic fcflws;
@dynamic hhzyhdlg;
@dynamic accident_num;
@dynamic deal_accident_num;
@dynamic deal_bxlp_num;
@dynamic jcsgd;
@dynamic qlxr;
@dynamic isuploaded;

+(Inspection_ClassMain *)InspectionClassMainforinspectionid:(NSString *)specialID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"inspectionid==%@",specialID];
    fetchRequest.predicate=predicate;
    fetchRequest.entity=entity;
    NSArray *fetchResult=[context executeFetchRequest:fetchRequest error:nil];
    if (fetchResult.count>0) {
        return [fetchResult objectAtIndex:0];
    } else {
        return nil;
    }
}

@end
