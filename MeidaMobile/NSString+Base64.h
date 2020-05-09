//
//  NSString+Base64.h
//  FoKaiMobile
//
//  Created by admin on 2019/12/20.
//

#import <Foundation/Foundation.h>



@interface NSString (Base64)

+ (NSString*)base64forData:(NSData*)theData;
@end
