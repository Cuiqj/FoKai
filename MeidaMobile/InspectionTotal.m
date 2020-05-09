//
//  InspectionTotal.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import "InspectionTotal.h"

@implementation InspectionTotal

@dynamic  daily_event;
@dynamic  inspect_date;
@dynamic  myid;
@dynamic  inspectionid;
@dynamic  car_num;
@dynamic  personnel_class;
@dynamic  mileage_before_trans;
@dynamic  mileage_after_trans;
@dynamic  inspect_people_num;
@dynamic  inspect_times;
@dynamic  traffic_accident;
@dynamic  roadasset_case;

@dynamic  clear_barrier;
@dynamic  help_trouble_car;
@dynamic  check_bridge;
@dynamic  check_job_site;
@dynamic  correct_violate;
@dynamic  exhort_passerby;
@dynamic  exhort_car;
@dynamic  help_people;
@dynamic  resume_railing;
@dynamic  check_service;

@dynamic  find_illegal;
@dynamic  alter_illegal;
@dynamic  shunt;
@dynamic  clean_bridge_misc;
@dynamic  construction_note;
@dynamic  stop_note;
@dynamic  find_illegal_con;
@dynamic  remove_illegal_con;
@dynamic  find_illegal_adv;
@dynamic  remove_illegal_adv;

@dynamic  other_illegal;
@dynamic  propaganda;
@dynamic  put_facilities;
@dynamic  get_facilities;
@dynamic  isuploaded;
//@dynamic  break_case;
//@dynamic  remove_bridge_berth;
//@dynamic  alter_safety_specs;

//inspectionid
+(InspectionTotal *)InspectionTotalforinspectionid:(NSString *)specialID{
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
