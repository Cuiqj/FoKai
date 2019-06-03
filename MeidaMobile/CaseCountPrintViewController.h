//
//  CaseCountPrintViewController.h
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 13-1-4.
//
//

#import "CasePrintViewController.h"
#import "CaseCountDetailCell.h"
#import "CaseCountDetailEditorViewController.h"
#import "DateSelectController.h"

@interface CaseCountPrintViewController : CasePrintViewController<DatetimePickerHandler,UITableViewDataSource,UITableViewDelegate,CaseCountDetailEditorDelegate,UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UILabel *labelHappenTime;
 
//时间    损坏公路设施索赔清单  时间    不是案发时间
@property (weak, nonatomic) IBOutlet UITextField *textfieldHappenTime;
- (IBAction)casecounttimeClick:(id)sender;
//    赔偿标准
@property (weak, nonatomic) IBOutlet UITextField *casecountstandard;
- (IBAction)casecountstandardClick:(id)sender;


//@property (weak, nonatomic) IBOutlet UILabel *labelCaseAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelParty;
//@property (weak, nonatomic) IBOutlet UILabel *labelTele;
@property (weak, nonatomic) IBOutlet UILabel *labelAutoPattern;
@property (weak, nonatomic) IBOutlet UILabel *labelAutoNumber;
@property (weak, nonatomic) IBOutlet UITextField *textfieldCaseAddress;
@property (weak, nonatomic) IBOutlet UITableView *tableCaseCountDetail;
@property (weak, nonatomic) IBOutlet UITextField *textBigNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelPayReal;
@property (weak, nonatomic) IBOutlet UITextView *textRemark;
@end
