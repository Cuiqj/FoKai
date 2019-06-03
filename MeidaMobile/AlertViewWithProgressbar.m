//
//  AGAlertViewWithProgressbar.m
//  AGAlertViewWithProgressbar
//
//  Created by Artur Grigor on 19.04.2012.
//  Copyright (c) 2012 Artur Grigor. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.
//

#import "AlertViewWithProgressbar.h"


@implementation AlertViewWithProgressbar

#pragma mark - Properties


- (void)setVisible:(BOOL)visible{
        self.visible=visible;
        self.progressView.hidden=self.progressLabel.hidden=visible;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setProgress:(NSUInteger)theProgress
{
    if (_progress != theProgress)
    {
        if (theProgress > 100)
        {
            return;
        }
        
        _progress = theProgress;
        
        self.progressView.progress = (float)(_progress / 100.f);
        self.progressLabel.text = [NSString stringWithFormat:@"%d%%", _progress];
    }
}


#pragma mark - Object Lifecycle

- (void)dealloc
{
    self.progress=0;
    self.progressView = nil;
    self.progressLabel = nil;
}

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    if(cancelButtonTitle || otherButtonTitles)//有button
        message = message ? [message stringByAppendingString:@"\n\n"] : @"\n";
    
    //super init。将固定参数和可变参数传递给父类
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
 /*
    va_list args_list;
    va_start(args_list, otherButtonTitles);
    
    NSString* anArg;
    while((anArg = va_arg(args_list, NSString*)))
    {
        [self addButtonWithTitle:anArg];
    }
    
    va_end(args_list);
    
    */
    // add progress view
    //self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault] ;
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, 280, 10)];
    [self.progressView setProgressViewStyle:UIProgressViewStyleDefault];
    //self.progressView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFletxibleRightMargin;
    //self.progressView.tintColor=[UIColor darkTextColor];
    //self.progressView.frame=  CGRectMake(0, 0, self.frame.size.width, 10);
    [self addSubview:self.progressView];
    
    // add progress label
    self.progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)] ;
    //self.progressLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.progressLabel.backgroundColor = [UIColor clearColor];//comment it to look label's position
    //self.progressLabel.textColor = [UIColor whiteColor];
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.progressLabel];
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [v addSubview:self.progressView];
    [v addSubview:self.progressLabel];
    [self setValue:v forKey:@"accessoryView"];
    //v.backgroundColor = [UIColor yellowColor];
    return self;
}

@end