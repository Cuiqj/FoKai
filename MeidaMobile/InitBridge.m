//
//  InitBridge.m
//  FoKaiMobile
//
//  Created by admin on 2017/12/18.
//
//

#import "InitBridge.h"

@implementation InitBridge
-(void)downloadBridge{
    
    WebServiceInit;
    [service downloadDataSet:@"select * from InspectionBridgePoint"];
}

- (void)xmlParser:(NSString *)webString{
    [self autoParserForDataModel:@"InspectionBridgePoint" andInXMLString:webString];
}
@end
