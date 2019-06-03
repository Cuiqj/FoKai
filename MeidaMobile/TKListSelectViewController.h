//
//  TKListSelectViewController.h
//  FoKaiMobile
//
//  Created by tiank on 2017/12/20.
//
//

#import <UIKit/UIKit.h>
#import "TKListSelectViewController.h"
typedef NSString* (^CreateCellBlock)(int);
@protocol TKListSelectDelegate;

@interface TKListSelectViewController : UITableViewController

@property (nonatomic,weak  ) UIPopoverController  *pickerPopover;
@property (nonatomic,weak  ) id<TKListSelectDelegate> delegate;
@property (nonatomic,strong) NSArray              *data;
@property (nonatomic,strong) CreateCellBlock      cellCreater;
+(instancetype)initWithCreateCell:(CreateCellBlock)cellCreater;
@end

@protocol TKListSelectDelegate <NSObject>
@optional
- (void)setSelectData:(NSString *)data;
- (void)listSelectPopover:(TKListSelectViewController *)popoverContent selectedIndexPath:(NSIndexPath *)indexPath;


@end