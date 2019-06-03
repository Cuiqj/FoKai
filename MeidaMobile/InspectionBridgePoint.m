//
//  InspectionBridgePoint.m
//  FoKaiMobile
//
//  Created by admin on 2017/12/18.
//
//

#import "InspectionBridgePoint.h"

@implementation InspectionBridgePoint

// Insert code here to add functionality to your managed object subclass
+(NSArray*)allBridges{
    NSManagedObjectContext*context=[[AppDelegate App] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:@"InspectionBridgePoint" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
    //[fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"xh"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error          = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}
@end
