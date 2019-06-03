//
//  BridgeCheckViewController.h
//  FoKaiMobile
//
//  Created by admin on 2017/12/20.
//
//

#import <UIKit/UIKit.h>

@interface BridgeCheckViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textBridgeName;
@property (weak, nonatomic) IBOutlet UITextField *textBridgeCode;
@property (weak, nonatomic) IBOutlet UITextField *textBridgeStation;
@property (weak, nonatomic) IBOutlet UITextField *textBridgeType;
@property (weak, nonatomic) IBOutlet UITextView *textBridgeDesc;
@property (weak, nonatomic) IBOutlet UITextView *textDealDetail;
@property (weak, nonatomic) IBOutlet UITextView *textRemark;
@property (weak, nonatomic) IBOutlet UITextField *textChecker;
@property (weak, nonatomic) IBOutlet UISwitch *isIllegalSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *isSendSwitch;
@property (weak, nonatomic) IBOutlet UIView *IllegalView;
@property (weak, nonatomic) IBOutlet UITextField *textStartTime;
@property (weak, nonatomic) IBOutlet UITextField *textReportTime;
@property (weak, nonatomic) IBOutlet UITextField *textIllegalType;
@property (weak, nonatomic) IBOutlet UITextField *textEare;
@property (weak, nonatomic) IBOutlet UITextField *textIllegalPerson;
@property (weak, nonatomic) IBOutlet UITextView *textRecognizedDesc;
@property (weak, nonatomic) IBOutlet UITableView *listTable;
- (IBAction)btnNew:(id)sender;
- (IBAction)btnAdd:(id)sender;
- (IBAction)illegalChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *zhengGaiBtn;

@end
