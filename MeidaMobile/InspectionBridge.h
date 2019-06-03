//
//  InspectionBridge.h
//  FoKaiMobile
//
//  Created by admin on 2017/12/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface InspectionBridge : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(NSArray*) allInspectionBridge;
@end

NS_ASSUME_NONNULL_END

#import "InspectionBridge+CoreDataProperties.h"
