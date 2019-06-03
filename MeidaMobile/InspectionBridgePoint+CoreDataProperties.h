//
//  InspectionBridgePoint+CoreDataProperties.h
//  FoKaiMobile
//
//  Created by admin on 2017/12/18.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "InspectionBridgePoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionBridgePoint (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *myid;
@property (nullable, nonatomic, retain) NSString *xh;
@property (nullable, nonatomic, retain) NSString *station;
@property (nullable, nonatomic, retain) NSString *bridge_name;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSNumber *bridge_len;
@property (nullable, nonatomic, retain) NSDate *record_create_time;

@end

NS_ASSUME_NONNULL_END
