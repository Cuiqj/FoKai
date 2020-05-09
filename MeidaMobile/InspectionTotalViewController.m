//
//  InspectionTotalViewController.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/8.
//

#import "InspectionTotalViewController.h"
#import "InspectionTotal.h"
#import "Inspection.h"
#import "ListSelectViewController.h"

@interface InspectionTotalViewController ()
@property (nonatomic,retain) Inspection_ClassMain * inspection_class;
@property (nonatomic,retain) Inspection * inspection;

@property (nonatomic,retain) UIPopoverController * pickerPopover;
@end

@implementation InspectionTotalViewController
- (void)btnShowDataforNSString:(NSString *)showname{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    self.textdate_inspection.text = showname ? [formatter stringFromDate:self.inspection_class.date_inspection] : [formatter stringFromDate:self.inspection.date_inspection];
    
    NSInteger inspectionnum = [[self.inspection.inspectionor_name componentsSeparatedByString:@","] count];
    if (![self.inspection.inspectionor_name containsString:self.inspection.recorder_name]) {
        ++ inspectionnum;
    }
    //    巡查人次默认    巡查日期默认
    self.textinspection_man_num.text = showname ? self.inspection_class.inspection_man_num : [NSString stringWithFormat:@"%ld/0",(long)inspectionnum];
    self.textinspection_mile.text = showname ? self.inspection_class.inspection_mile : @"0";
    self.textaccident_num.text = showname ? self.inspection_class.accident_num : @"0/0";
    self.textdeal_accident_num.text = showname ? self.inspection_class.deal_accident_num : @"0/0";
    self.textdeal_bxlp_num.text = showname ? self.inspection_class.deal_bxlp_num : @"0/0";
    self.textfxqx.text = showname ? self.inspection_class.fxqx : @"0";
    self.textfxwfxw.text = showname ? self.inspection_class.fxwfxw : @"0";
    self.jzwfxw.text = showname ? self.inspection_class.jzwfxw : @"0";
    self.textcllmzaw.text = showname ? self.inspection_class.cllmzaw : @"0";
    self.textbzgzc.text = showname ? self.inspection_class.bzgzc : @"0";
    self.textjcsgd.text = showname ? self.inspection_class.jcsgd : @"0/0";
    self.textgzzfj.text = showname ? self.inspection_class.gzzfj : @"0";
    self.textfcflws.text = showname ? self.inspection_class.fcflws : @"0";
    self.textqlxr.text = showname ? self.inspection_class.qlxr : @"0/0";
    self.texthhzyhdlg.text = showname ? self.inspection_class.hhzyhdlg : @"0";
}
- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"本班次巡查汇总信息";
    self.scrollview.frame = CGRectMake(0, 0, 1024, 520);
    self.scrollview.contentSize = CGSizeMake(1024, 525);
    self.inspection_class = [Inspection_ClassMain InspectionClassMainforinspectionid:self.inspectionID];
    self.inspection = [Inspection Inspectionforinspectionid:self.inspectionID];
    if (self.inspection_class) {
        [self btnShowDataforNSString:@"展示"];
    }else{
        [self btnShowDataforNSString:nil];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)KeyboardDidShow:(NSNotification *)notification{
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat navigationheight = self.navigationController.navigationBar.frame.size.height;
    CGFloat height = frame.size.height;
    self.scrollview.frame = CGRectMake(0, 0, self.view.frame.size.width, 520-height+248-navigationheight);
}
- (void)KeyboardDidHide:(NSNotification *)notification{
    self.scrollview.frame = CGRectMake(0, 0, self.view.frame.size.width,520);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BtnSaveClick:(id)sender {
    self.inspection_class = [Inspection_ClassMain InspectionClassMainforinspectionid:self.inspectionID];
    if (self.inspection_class == nil) {
//        self.inspection_class = [Inspection_ClassMain newDataObjectWithEntityName:NSStringFromClass([self class])];
        self.inspection_class = [Inspection_ClassMain newDataObjectWithEntityName:@"Inspection_ClassMain"];
        self.inspection_class.inspectionid = self.inspectionID;
//        if(self.inspection_class.inspectionid.length <= 0){
//            self.inspection_class.inspectionid = [[NSUserDefaults standardUserDefaults] valueForKey:INSPECTIONKEY];
//        }
        self.inspection_class.date_inspection = self.inspection.date_inspection;
        self.inspection_class.org_id = self.inspection.organization_id;
    }
//    self.inspection_class.org_id = self.inspection.organization_id;
    self.inspection_class.inspection_mile = self.textinspection_mile.text;
    self.inspection_class.inspection_man_num = self.textinspection_man_num.text;
    self.inspection_class.accident_num = self.textaccident_num.text;
    self.inspection_class.deal_accident_num = self.textdeal_accident_num.text;
    self.inspection_class.deal_bxlp_num = self.textdeal_bxlp_num.text;
    self.inspection_class.fxqx = self.textfxqx.text;
    self.inspection_class.fxwfxw = self.textfxwfxw.text;
    self.inspection_class.jzwfxw = self.jzwfxw.text;
    self.inspection_class.cllmzaw = self.textcllmzaw.text;
    self.inspection_class.bzgzc = self.textbzgzc.text;
    self.inspection_class.jcsgd = self.textjcsgd.text;
    self.inspection_class.gzzfj = self.textgzzfj.text;
    self.inspection_class.fcflws = self.textfcflws.text;
    self.inspection_class.qlxr = self.textqlxr.text;
    self.inspection_class.hhzyhdlg = self.texthhzyhdlg.text;
    [[AppDelegate App] saveContext];
}
- (void)isuploadFinished{
    __weak typeof(self)weakself = self;
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"已上传数据，不能更改"  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:cancelAction];
    [weakself.navigationController presentViewController:ac animated:YES completion:nil];
}

- (IBAction)BtnEmptyClick:(id)sender {
    if (self.inspection_class) {
        NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
        [context deleteObject:self.inspection_class];
    }
    [[AppDelegate App] saveContext];
    [self btnShowDataforNSString:nil];
}

//-(void)showListSelect:(UITextField *)sender WithData:(NSArray *)data{
////    __weak typeof(self)weakself = self;
//    ListSelectViewController *listPicker=[self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectPoPover"];
//    listPicker.delegate = self;
//    listPicker.data     = data;
//    self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:listPicker];
//    CGRect rect         = sender.frame;
//    [self.pickerPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//    listPicker.pickerPopover = self.pickerPopover;
//}

@end
