//
//  ListSelectViewController.h
//  GDRMMobile
//
//  Created by 高 峰 on 13-7-13.
//
//

#import <UIKit/UIKit.h>
#import "ListSelectViewController.h"
typedef void(^SelectedIndexPathBlock) (NSIndexPath*);
@protocol ListSelectPopoverDelegate;

@interface ListSelectViewController : UITableViewController

@property (nonatomic,weak                           ) UIPopoverController       *pickerPopover;
@property (nonatomic,weak                           ) id<                        ListSelectPopoverDelegate> delegate;
@property (nonatomic,strong                         ) NSArray                   *data;
@property (nonatomic,strong                         ) SelectedIndexPathBlock     selectedIndexPathBlock          ;
@end

@protocol ListSelectPopoverDelegate <NSObject>
@optional
//设置检查类型
- (void)setSelectData:(NSString *)data;

- (void)setSelectData:(NSString *)data withtag:(NSInteger)tag;
// added by xushiwen
- (void)listSelectPopover:(ListSelectViewController *)popoverContent selectedIndexPath:(NSIndexPath *)indexPath;


@end
