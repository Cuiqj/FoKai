//
//  InspectionBridge.m
//  FoKaiMobile
//
//  Created by admin on 2017/12/18.
//
//

#import "InspectionBridge.h"

@implementation InspectionBridge

// Insert code here to add functionality to your managed object subclass
+(NSArray*) allInspectionBridge{
    NSManagedObjectContext * context=[[AppDelegate App] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:@"InspectionBridge" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
    //[fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"myid"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error          = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}
@end
