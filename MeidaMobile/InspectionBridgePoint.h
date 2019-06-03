//
//  InspectionBridgePoint.h
//  FoKaiMobile
//
//  Created by admin on 2017/12/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface InspectionBridgePoint : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(NSArray*)allBridges;
@end

NS_ASSUME_NONNULL_END

#import "InspectionBridgePoint+CoreDataProperties.h"
