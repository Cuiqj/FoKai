//
//  CaseInvestigatePrintViewController.h
//  FoKaiMobile
//
//  Created by admin on 2019/5/30.
//

#import "CasePrintViewController.h"
#import "CaseInvestigate.h"
#import "UserPickerViewController.h"

@interface CaseInvestigatePrintViewController : CasePrintViewController<UserPickerDelegate>

//案号
@property (weak, nonatomic) IBOutlet UILabel *labelanhao;
//案由
@property (weak, nonatomic) IBOutlet UITextField *textcasedesc;

//调查人1 2 3    tag 从 6 到 8
@property (weak, nonatomic) IBOutlet UITextField *textnameone;
@property (weak, nonatomic) IBOutlet UITextField *textnametwo;
@property (weak, nonatomic) IBOutlet UITextField *textnamethree;


//所附证据材料    tag 从 11 到20
@property (weak, nonatomic) IBOutlet UIButton *textwitnessone;
@property (weak, nonatomic) IBOutlet UIButton *textwitnesstwo;
@property (weak, nonatomic) IBOutlet UIButton *textwitnessthree;
@property (weak, nonatomic) IBOutlet UIButton *textwitnessfour;
@property (weak, nonatomic) IBOutlet UIButton *textwitnessfive;
@property (weak, nonatomic) IBOutlet UIButton *textwitnesssix;
@property (weak, nonatomic) IBOutlet UIButton *textwitnessseven;
@property (weak, nonatomic) IBOutlet UIButton *textwitnesseight;
@property (weak, nonatomic) IBOutlet UIButton *textwitnessnine;
@property (weak, nonatomic) IBOutlet UIButton *textwitnessten;
//点击所附证据材料     tag 11到20
- (IBAction)textWitnessClick:(id)sender;





//案件调查经过及结论
@property (weak, nonatomic) IBOutlet UITextView *textviewcourse;
//领导意见
@property (weak, nonatomic) IBOutlet UITextView *textviewleader_comment;
//备注
@property (weak, nonatomic) IBOutlet UITextView *textviewremark;

//人员选择
- (IBAction)userSelect:(id)sender;


@end
