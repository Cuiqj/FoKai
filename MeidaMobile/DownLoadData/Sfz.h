//
//  Sfz.h
//  GDRMMobile
//
//  Created by xiaoxiaojia on 17/3/10.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sfz : NSManagedObject

@property (nonatomic, retain) NSString * myid;
@property (nonatomic, retain) NSString * sfz_name;
@property (nonatomic, retain) NSString * roadsegment_id;
@property (nonatomic, retain) NSString * station_start;
@property (nonatomic, retain) NSString * station_end;
@property (nonatomic, retain) NSString * remark;
+(NSArray*)allShoufzName;
+(Sfz*)aSfzForID:(NSString*)ID;

+(NSString *)station_startforShoufzName:(NSString *)name;
@end
