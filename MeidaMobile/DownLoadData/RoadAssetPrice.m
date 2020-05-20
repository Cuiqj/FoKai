//
//  RoadAssetPrice.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-11-14.
//
//

#import "RoadAssetPrice.h"


@implementation RoadAssetPrice

@dynamic document_name;
@dynamic is_unvarying;
@dynamic label;
@dynamic name;
@dynamic price;
@dynamic remark;
@dynamic myid;
@dynamic roadasset_type;
@dynamic spec;
@dynamic unit_name;

+(NSString *)document_namewithRoadAssetPriceforname:(NSString * )name andspec:(NSString *)spec{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name == %@ && spec == %@",name,spec];
    fetchRequest.predicate = predicate;
    fetchRequest.entity    = entity;
    NSArray *fetchResult=[context executeFetchRequest:fetchRequest error:nil];
    if (fetchResult.count>0) {
        return [[fetchResult objectAtIndex:0] valueForKey:@"document_name"];
    } else {
        return nil;
    }
    
    return nil;
}

@end
