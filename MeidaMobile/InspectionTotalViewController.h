//
//  InspectionTotalViewController.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/8.
//

#import <UIKit/UIKit.h>
#import "Inspection_ClassMain.h"
#import "InspectionTotal.h"

@interface InspectionTotalViewController : UIViewController

@property (nonatomic, retain) NSString * inspectionID;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;


//巡查日期    年月日
@property (weak, nonatomic) IBOutlet UITextField *textdate_inspection;
//本班次巡查里程
@property (weak, nonatomic) IBOutlet UITextField *textinspection_mile;
//本班次参加巡查人次
@property (weak, nonatomic) IBOutlet UITextField *textinspection_man_num;
//发生交通事故/其中涉及路产损害
@property (weak, nonatomic) IBOutlet UITextField *textaccident_num;
//处理路产损害赔偿
@property (weak, nonatomic) IBOutlet UITextField *textdeal_accident_num;
//处理路产保险理赔案件
@property (weak, nonatomic) IBOutlet UITextField *textdeal_bxlp_num;
// 发现报送道路、交安设施缺陷
@property (weak, nonatomic) IBOutlet UITextField *textfxqx;
//发现违法行为
@property (weak, nonatomic) IBOutlet UITextField *textfxwfxw;
//纠正违法行为
@property (weak, nonatomic) IBOutlet UITextField *jzwfxw;
// 处理路面障碍物
@property (weak, nonatomic) IBOutlet UITextField *textcllmzaw;
//帮助故障车
@property (weak, nonatomic) IBOutlet UITextField *textbzgzc;
//检查施工点/纠正违反公路施工安全作业规程行为
@property (weak, nonatomic) IBOutlet UITextField *textjcsgd;
//告知交通综合行政执法局处理案件
@property (weak, nonatomic) IBOutlet UITextField *textgzzfj;
//   发出法律文书
@property (weak, nonatomic) IBOutlet UITextField *textfcflws;
//劝离行人
@property (weak, nonatomic) IBOutlet UITextField *textqlxr;
// 恢复中央活动栏杆
@property (weak, nonatomic) IBOutlet UITextField *texthhzyhdlg;

- (IBAction)BtnSaveClick:(id)sender;
- (IBAction)BtnEmptyClick:(id)sender;


@end
