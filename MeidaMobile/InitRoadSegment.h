//
//  InitRoadSegment.h
//  GDRMMobile
//
//  Created by Sniper X on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InitData.h"

@interface InitRoadSegment : InitData;
- (void)downloadRoadSegment:(NSString *)orgID;
@end
