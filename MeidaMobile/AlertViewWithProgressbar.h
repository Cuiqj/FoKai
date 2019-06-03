//
//  AGAlertViewWithProgressbar.h
//  AGAlertViewWithProgressbar
//
//  Created by Artur Grigor on 19.04.2012.
//  Copyright (c) 2012 Artur Grigor. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.
//

#import <Foundation/Foundation.h>

@interface AlertViewWithProgressbar : UIAlertView

@property (nonatomic, assign) NSUInteger progress; 
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, retain) UIProgressView* progressView;
@property (nonatomic, retain) UILabel* progressLabel;

- (id)initWithTitle:(NSString *)theTitle message:(NSString *)theMessage andDelegate:(id<UIAlertViewDelegate>)theDelegate;
- (id)initWithTitle:(NSString *)theTitle message:(NSString *)theMessage delegate:(id)theDelegate cancelButtonTitle:(NSString *)titleForTheCancelButton otherButtonTitles:(NSString *)titleForTheFirstButton, ... NS_REQUIRES_NIL_TERMINATION;

//- (void)show;
//- (void)hide;

@end
