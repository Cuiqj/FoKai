//
//  NSMutableArray+TKProcess.m
//  FoKaiMobile
//
//  Created by admin on 2017/12/20.
//
//

#import "NSMutableArray+TKProcess.h"

@implementation NSMutableArray (TKProcess)
-(NSMutableArray*) withOutNull{
    for(int i = 0;i<self.count;i++){
        if([[self objectAtIndex:i] isEqualToString:@""]||[[self objectAtIndex:i] isEqual:nil]){
            [self removeObjectAtIndex:i];
        }else{
            i++;
        }
    }
    return self;
}
@end
