//
//  InspectionBridge+CoreDataProperties.h
//  FoKaiMobile
//
//  Created by admin on 2017/12/18.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "InspectionBridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionBridge (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *myid;
@property (nullable, nonatomic, retain) NSString *xh;
@property (nullable, nonatomic, retain) NSDate *check_date;
@property (nullable, nonatomic, retain) NSNumber *isuploaded;
@property (nullable, nonatomic, retain) NSString *inspectioner;
@property (nullable, nonatomic, retain) NSString *station;
@property (nullable, nonatomic, retain) NSString *bridge_name;
@property (nullable, nonatomic, retain) NSNumber *bridge_len;
@property (nullable, nonatomic, retain) NSString *bridge_desc;
@property (nullable, nonatomic, retain) NSString *change_step;
@property (nullable, nonatomic, retain) NSString *remark;
@property (nullable, nonatomic, retain) NSDate *record_create_time;
@property (nullable, nonatomic, retain) NSDate *happen_time;
@property (nullable, nonatomic, retain) NSDate *write_time;
@property (nullable, nonatomic, retain) NSString *law_type;
@property (nullable, nonatomic, retain) NSString *party;
@property (nullable, nonatomic, retain) NSNumber *area_size;
@property (nullable, nonatomic, retain) NSString *deal_situation;
@property (nullable, nonatomic, retain) NSString *follow_situation;
@property (nullable, nonatomic, retain) NSNumber *isillegal;
@property (nullable, nonatomic, retain) NSNumber *issend;

@end

NS_ASSUME_NONNULL_END
