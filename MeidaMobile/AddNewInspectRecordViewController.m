//
//  AddNewInspectRecordViewController.m
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddNewInspectRecordViewController.h"
#import "Global.h"
#import "RoadInspectViewController.h"

#import "Sfz.h"

@interface AddNewInspectRecordViewController ()
@property (nonatomic,retain) NSString *roadSegmentID;

- (void)keyboardWillHide:(NSNotification *)aNotification;

- (void)keyboardWillShow:(NSNotification *)aNotification;

@property (nonatomic, assign) BOOL isStartTime;
@property (nonatomic, assign) BOOL isEndTime;
@property (nonatomic) NSUInteger selectsfztag;

@end

@implementation AddNewInspectRecordViewController
@synthesize contentView;
@synthesize textCheckType;
@synthesize textCheckReason;
@synthesize textCheckHandle;
@synthesize textCheckStatus;
@synthesize textSide;
//@synthesize textWeather;
@synthesize textDate;
@synthesize textSegement;
//@synthesize textSide;
@synthesize textPlace;
@synthesize textStationStartKM;
@synthesize textStationStartM;
@synthesize viewNormalDesc;
@synthesize textTimeStart;
//@synthesize textTimeEnd;
@synthesize textRoad;
@synthesize textPlaceNormal;
@synthesize textDescNormal;
@synthesize textViewNormalDesc;
@synthesize descState;
@synthesize isStartTime;
@synthesize isEndTime;
//@synthesize textStationEndKM;
//@synthesize textStationEndM;

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.contentView setDelaysContentTouches:NO];
    self.descState = kAddNewRecord;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//软键盘隐藏，恢复左下scrollview位置
- (void)keyboardWillHide:(NSNotification *)aNotification{
    if (self.descState == kAddNewRecord) {
        [self.contentView setContentSize:self.contentView.frame.size];
    }
}

//软键盘出现，上移scrollview至左上，防止编辑界面被阻挡
- (void)keyboardWillShow:(NSNotification *)aNotification{
    if (self.descState == kAddNewRecord) {
        [self.contentView setContentSize:CGSizeMake(self.contentView.frame.size.width,self.contentView.frame.size.height+200)];
    }
}


- (void)viewDidUnload
{
    [self setTextCheckType:nil];
    [self setTextCheckReason:nil];
    [self setTextCheckHandle:nil];
    [self setTextCheckStatus:nil];
    [self setPickerPopover:nil];
    [self setCheckTypeID:nil];
    //    [self setTextWeather:nil];
    [self setTextDate:nil];
    [self setTextSegement:nil];
    [self setTextPlace:nil];
    [self setTextStationStartKM:nil];
    [self setTextStationStartM:nil];
    //    [self setTextStationEndKM:nil];
    //    [self setTextStationEndM:nil];
    [self setRoadSegmentID:nil];
    [self setContentView:nil];
    [self setViewNormalDesc:nil];
    [self setTextTimeStart:nil];
//    [self setTextTimeEnd:nil];
    [self setTextRoad:nil];
    [self setTextPlaceNormal:nil];
    [self setTextDescNormal:nil];
    [self setTextViewNormalDesc:nil];
    [self setTextSide:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)btnSwitch:(UIButton *)sender {
    if (self.descState == kAddNewRecord) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.uibuttonSwitch setTitle:@"返回" forState:UIControlStateNormal];
                             [self.uibuttonSwitch setTitle:@"返回" forState:UIControlStateHighlighted];
                             [self.viewNormalDesc setHidden:NO];
                             [self.view bringSubviewToFront:self.viewNormalDesc];
                             [self.contentView setHidden:YES];
                         }
                         completion:nil];
        self.descState = kNormalDesc;
    } else {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.uibuttonSwitch setTitle:@"无异常情况" forState:UIControlStateNormal];
                             [self.uibuttonSwitch setTitle:@"无异常情况" forState:UIControlStateHighlighted];
                             [self.contentView setHidden:NO];
                             [self.view bringSubviewToFront:self.contentView];
                             [self.viewNormalDesc setHidden:YES];
                         }
                         completion:nil];
        self.isStartTime = YES;
        self.descState = kAddNewRecord;
    }
}

- (IBAction)btnDismiss:(id)sender {
    [self.delegate addObserverToKeyBoard];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnSave:(id)sender {
    if (self.descState == kAddNewRecord) {
        BOOL isBlank =NO;
//        for (id obj in self.contentView.subviews) {
//            if ([obj isKindOfClass:[UITextField class]]) {
//                if ([[(UITextField *)obj text] isEmpty]) {
//                    
//                    if ([obj tag] < 111 ) {
//                        isBlank=YES;
//                    }
//                }
//            }
//        }
        if ([self.textDate.text isEmpty]) {
            isBlank=YES;
        }
        if (!isBlank) {
            InspectionRecord *inspectionRecord=[InspectionRecord newDataObjectWithEntityName:@"InspectionRecord"];
            inspectionRecord.roadsegment_id=[NSString stringWithFormat:@"%d", [self.roadSegmentID intValue]];
            inspectionRecord.fix=self.textSide.text;
            inspectionRecord.inspection_type=self.textCheckType.text;
            inspectionRecord.inspection_item=self.textCheckReason.text;
            inspectionRecord.location=self.textPlace.text;
            inspectionRecord.measure=self.textCheckHandle.text;
            inspectionRecord.status=self.textCheckStatus.text;
            inspectionRecord.inspection_id=self.inspectionID;
            inspectionRecord.relationid = @"0";
            
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setLocale:[NSLocale currentLocale]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            inspectionRecord.start_time=[dateFormatter dateFromString:self.textDate.text];
            inspectionRecord.end_time = [dateFormatter dateFromString:self.textendDate.text];
            
            [dateFormatter setDateFormat:DATE_FORMAT_HH_MM_COLON];
            NSString *timeString= [dateFormatter stringFromDate:inspectionRecord.start_time];
            if (inspectionRecord.end_time) {
                timeString = [NSString stringWithFormat:@"%@-%@",timeString,[dateFormatter stringFromDate:inspectionRecord.end_time]];
            }
            NSString *remark=[[NSString alloc] initWithFormat:@"%@巡至%@%@K%d+%03dm处时，在公路%@%@，巡逻班组%@。",timeString,self.textSegement.text,self.textSide.text,self.textStationStartKM.text.integerValue,self.textStationStartM.text.integerValue,self.textPlace.text,self.textCheckReason.text,self.textCheckStatus.text];
            if (self.textStationEndKM.text.length>0) {
                NSString * endstation = [NSString stringWithFormat:@"至k%d+%03dm之间时，",self.textStationEndKM.text.integerValue,self.textStationEndM.text.integerValue];
                remark = [remark stringByReplacingOccurrencesOfString:@"处时，" withString:endstation];
            }
            self.textCheckHandle.text=[self.textCheckHandle.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (![self.textCheckHandle.text isEmpty]) {
                remark=[remark stringByAppendingFormat:@"%@。",self.textCheckHandle.text];
            }
            inspectionRecord.station=@(self.textStationStartKM.text.integerValue*1000+self.textStationStartM.text.integerValue);
            inspectionRecord.remark=remark;
            [[AppDelegate App] saveContext];
            [self.delegate reloadRecordData];
            [self.delegate addObserverToKeyBoard];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        BOOL isBlank =NO;
        for (id obj in self.viewNormalDesc.subviews) {
            if ([obj isKindOfClass:[UITextField class]]) {
                if ([[(UITextField *)obj text] isEmpty]) {
                    isBlank=YES;
                }
            }
        }
        if(self.textTimeEnd.text.length>0){
            isBlank = NO;
        }
        if (!isBlank) {
            if ([self.textViewNormalDesc.text isEmpty]) {
                [self btnFormNormalDesc:nil];
                //生成    无异常情况  巡查记录
//                self.textViewNormalDesc.text = [NSString stringWithFormat:@"%@-%@，巡查%@%@，%@",self.textTimeStart.text,self.textTimeEnd.text,self.textRoad.text,self.textPlaceNormal.text,self.textDescNormal.text];
            }
            InspectionRecord *inspectionRecord=[InspectionRecord newDataObjectWithEntityName:@"InspectionRecord"];
            inspectionRecord.roadsegment_id=[NSString stringWithFormat:@"%d", [self.roadSegmentID intValue]];
            inspectionRecord.fix=self.textPlaceNormal.text;
            inspectionRecord.inspection_type=@"日常巡查";
            inspectionRecord.inspection_item= @"无异常";
            inspectionRecord.location=self.textPlaceNormal.text;
            inspectionRecord.measure=@"";
            inspectionRecord.status=@"";
            inspectionRecord.station = [NSNumber numberWithInteger:(self.zhuanghaostart.text.integerValue*1000+self.zhuanghaoend.text.integerValue)];
            inspectionRecord.inspection_id=self.inspectionID;
            inspectionRecord.relationid = @"0";
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString * datetemstring = [dateFormatter stringFromDate:[NSDate date]];
            NSString * subtemstr = [datetemstring substringToIndex:10];
            inspectionRecord.start_time = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",subtemstr,self.textTimeStart.text]];
            inspectionRecord.remark=self.textViewNormalDesc.text;
            [[AppDelegate App] saveContext];
            [self.delegate reloadRecordData];
            [self.delegate addObserverToKeyBoard];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

//弹窗
- (void)pickerPresentPickerState:(InspectionCheckState)state fromRect:(CGRect)rect{
    if ((state==self.pickerState) && ([self.pickerPopover isPopoverVisible])) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        self.pickerState=state;
        InspectionCheckPickerViewController *icPicker=[self.storyboard instantiateViewControllerWithIdentifier:@"InspectionCheckPicker"];
        icPicker.pickerState=state;
        icPicker.checkTypeID=self.checkTypeID;
        icPicker.delegate=self;
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:icPicker];
        if (self.descState == kAddNewRecord) {
            rect = [self.view convertRect:rect fromView:self.contentView];
        } else {
            rect = [self.view convertRect:rect fromView:self.viewNormalDesc];
        }
        if (state == kDescription) {
            icPicker.preferredContentSize = CGSizeMake(600, 500);
        }
        [self.pickerPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        icPicker.pickerPopover=self.pickerPopover;
    }
}

//路段选择弹窗
- (void)roadSegmentPickerPresentPickerState:(RoadSegmentPickerState)state fromRect:(CGRect)rect{
    if ((state==self.roadSegmentPickerState) && ([self.pickerPopover isPopoverVisible])) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        self.roadSegmentPickerState=state;
        RoadSegmentPickerViewController *icPicker=[[RoadSegmentPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        icPicker.tableView.frame=CGRectMake(0, 0, 150, 243);
        icPicker.pickerState=state;
        icPicker.delegate=self;
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:icPicker];
        [self.pickerPopover setPopoverContentSize:CGSizeMake(150, 243)];
        if (self.descState == kAddNewRecord) {
            rect = [self.view convertRect:rect fromView:self.contentView];
        } else {
            rect = [self.view convertRect:rect fromView:self.viewNormalDesc];
        }
        [self.pickerPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        icPicker.pickerPopover=self.pickerPopover;
    }
}

- (IBAction)textTouch:(UITextField *)sender {
    switch (sender.tag) {
        case 100:
        case 221:
        {
            //时间选择
            if ([self.pickerPopover isPopoverVisible]) {
                [self.pickerPopover dismissPopoverAnimated:YES];
            } else {
                self.selectsfztag = sender.tag;
                DateSelectController *datePicker=[self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
                datePicker.delegate=self;
                datePicker.pickerType=1;
                [datePicker showdate:self.textDate.text];
                if (sender.tag == 221) {
                    [datePicker showdate:self.textendDate.text];
                }
                self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:datePicker];
                CGRect rect;
                if (self.descState == kAddNewRecord) {
                    rect = [self.view convertRect:sender.frame fromView:self.contentView];
                } else {
                    rect = [self.view convertRect:sender.frame fromView:self.viewNormalDesc];
                }
                [self.pickerPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
                datePicker.dateselectPopover=self.pickerPopover;
            }
        }
            break;
        case 102:
            [self roadSegmentPickerPresentPickerState:kRoadSegment fromRect:sender.frame];
            break;
        case 103:
            [self roadSegmentPickerPresentPickerState:kRoadSide fromRect:sender.frame];
            break;
        case 104:
            [self roadSegmentPickerPresentPickerState:kRoadPlace fromRect:sender.frame];
            break;
        case 109:
            [self pickerPresentPickerState:kCheckType fromRect:sender.frame];
            break;
        case 110:
            [self pickerPresentPickerState:kCheckReason fromRect:sender.frame];
            break;
        case 111:
            [self pickerPresentPickerState:kCheckStatus fromRect:sender.frame];
            break;
        case 112:
            [self pickerPresentPickerState:kCheckHandle fromRect:sender.frame];
            break;
        default:
            break;
    }
}

- (IBAction)toCaseView:(id)sender {
    //UIViewController *caseView = [self.storyboard instantiateViewControllerWithIdentifier:@"CaseView"];
    [self.delegate addObserverToKeyBoard];
    [self dismissViewControllerAnimated:YES completion:nil];
    [((RoadInspectViewController*)self.delegate) performSegueWithIdentifier:@"inspectToCaseView" sender:self];
}

#pragma mark - Delegate Implement

- (void)setCheckType:(NSString *)typeName typeID:(NSString *)typeID{
    self.checkTypeID=typeID;
    self.textCheckType.text=typeName;
}

- (void)setCheckText:(NSString *)checkText{
    switch (self.pickerState) {
        case kCheckStatus:
            self.textCheckStatus.text=checkText;
            break;
        case kCheckHandle:
            self.textCheckHandle.text=checkText;
            break;
        case kCheckReason:
            self.textCheckReason.text=checkText;
            break;
        case kDescription:
            self.textDescNormal.text = checkText;
            break;
        case kStation:
            if(self.selectsfztag == 2051){
                self.textsfzend.text = checkText;
                self.selectsfztag = 0;
                NSString * station = [Sfz station_startforShoufzName:checkText];
                self.gozhuanghaostart.text = [station substringToIndex:station.length-3];
                self.gozhuanghaoend.text = [station substringFromIndex:station.length -3];
                //                获取桩号 然后给赋值      根据名字来获取桩号
            }else{
                self.textsfz.text = checkText;
                //                第一个收费站
                NSString * station = [Sfz station_startforShoufzName:checkText];
                self.zhuanghaostart.text = [station substringToIndex:station.length-3];
                self.zhuanghaoend.text = [station substringFromIndex:station.length -3];
            }
            break;
        default:
            break;
    }
}

- (void)setDate:(NSString *)date{
    if (self.descState == kAddNewRecord) {
        if (self.selectsfztag == 100) {
            self.textDate.text=date;
            self.selectsfztag = 0;
        }else if (self.selectsfztag == 221) {
            self.textendDate.text=date;
            self.selectsfztag = 0;
        }
    } else {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *temp=[dateFormatter dateFromString:date];
        [dateFormatter setDateFormat:DATE_FORMAT_HH_MM_COLON];
        NSString *dateString=[dateFormatter stringFromDate:temp];
        if (self.isStartTime) {
            if (self.isEndTime) {
                self.textTimeEnd.text = dateString;
                self.isEndTime = NO;
            }else{
                self.textTimeStart.text = dateString;
            }
        }
        //else { self.textTimeEnd.text = dateString;}
    }
}

- (void)setRoadSegment:(NSString *)aRoadSegmentID roadName:(NSString *)roadName{
    if (self.descState == kAddNewRecord) {
        self.roadSegmentID=aRoadSegmentID;
        self.textSegement.text=roadName;
    } else {
        self.roadSegmentID = aRoadSegmentID;
        self.textRoad.text = roadName;
    }
}

- (void)setRoad:(NSString *)aRoadID roadName:(NSString *)roadName{
    if (self.descState == kAddNewRecord) {
        self.roadSegmentID=aRoadID;
        self.textSegement.text=roadName;
    } else {
        self.roadSegmentID = aRoadID;
        self.textRoad.text = roadName;
    }
}

- (void)setRoadPlace:(NSString *)place{
    if (self.descState == kAddNewRecord) {
        self.textPlace.text=place;
    }
}

- (void)setRoadSide:(NSString *)side{
    if (self.descState == kAddNewRecord) {
        self.textSide.text = side;
    } else {
        self.textPlaceNormal.text = side;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag==100 || textField.tag == 1001 || textField.tag == 1002 || textField.tag == 2049) {
        return NO;
    } else
        return YES;
}

//   生成 无异常情况  巡查记录
- (IBAction)btnFormNormalDesc:(id)sender {
    NSString * normaldesc;
    NSString * time;
    if (self.textTimeEnd.text.length>0 && self.textTimeStart.text.length>0) {
        time = [NSString stringWithFormat:@"%@-%@",self.textTimeStart.text,self.textTimeEnd.text];
    }else if(self.textTimeStart.text.length>0){
        time = self.textTimeStart.text;
    }else{
        time = self.textTimeEnd.text;
    }
    NSString * sfzname;
    if (self.textsfzend.text.length >0 && self.textsfz.text.length >0 ) {
        sfzname = [NSString stringWithFormat:@"%@至%@",self.textsfz.text,self.textsfzend.text];
    }else if (self.textsfz.text.length>0){
        sfzname = self.textsfz.text;
    }else{
        sfzname = self.textsfzend.text;
    }
    NSString * kstationstartandend;
    if (self.zhuanghaoend.text.intValue == self.gozhuanghaoend.text.intValue && self.zhuanghaostart.text.intValue == self.gozhuanghaostart.text.intValue && (self.zhuanghaostart.text.intValue!=0 || self.zhuanghaoend.text.intValue !=0)) {
        kstationstartandend = [NSString stringWithFormat:@"K%d+%03dm",self.zhuanghaostart.text.intValue,self.zhuanghaoend.text.intValue];
    }else if((self.zhuanghaoend.text.intValue !=0 || self.zhuanghaostart.text.intValue !=0) && (self.gozhuanghaoend.text.intValue !=0 || self.gozhuanghaostart.text.intValue !=0)){
        kstationstartandend = [NSString stringWithFormat:@"K%d+%03dm至K%d+%03dm",self.zhuanghaostart.text.intValue,self.zhuanghaoend.text.intValue,self.gozhuanghaostart.text.intValue,self.gozhuanghaoend.text.intValue];
    }else if(self.zhuanghaoend.text.intValue ==0 && self.gozhuanghaoend.text.intValue ==0 && self.zhuanghaostart.text.intValue ==0 && self.gozhuanghaostart.text.intValue ==0){
        kstationstartandend = @"";
    }else{
        kstationstartandend = [NSString stringWithFormat:@"K%d+%03dm",self.zhuanghaostart.text.intValue,self.zhuanghaoend.text.intValue];
    }
    NSString * remark = [self.textDescNormal.text stringByReplacingOccurrencesOfString:@"[时1]-[时2]" withString:time];
    remark = [remark stringByReplacingOccurrencesOfString:@"[时1]" withString:self.textTimeStart.text];
    remark = [remark stringByReplacingOccurrencesOfString:@"[时2]" withString:self.textTimeEnd.text];
    remark = [remark stringByReplacingOccurrencesOfString:@"[站1]-[站2]" withString:sfzname];
    remark = [remark stringByReplacingOccurrencesOfString:@"[站1]" withString:self.textsfz.text];
    remark = [remark stringByReplacingOccurrencesOfString:@"[站2]" withString:self.textsfzend.text];
    remark = [remark stringByReplacingOccurrencesOfString:@"[桩]" withString:kstationstartandend];
    remark = [remark stringByReplacingOccurrencesOfString:@"K0+000m" withString:@""];
    self.textViewNormalDesc.text = remark;
//    self.textViewNormalDesc.text = [NSString stringWithFormat:@"%@在%@%@路段巡查%@%@，%@",time,sfzname,kstationstartandend,self.textRoad.text,self.textPlaceNormal.text,self.textDescNormal.text];
}

- (IBAction)viewNormalTextTouch:(UITextField *)sender {
    if (sender.tag == 1001 ||sender.tag ==2049) {
        self.isStartTime = YES;
        if (sender.tag == 2049) {
            self.isEndTime = YES;
        }
    }
    if (sender.tag == 1002) {
        self.isStartTime = NO;
    }
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        DateSelectController *datePicker=[self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
        datePicker.delegate=self;
        datePicker.pickerType=1;
        if (self.isStartTime) {
            if (self.isEndTime) {
                [datePicker showdate:self.textTimeEnd.text];
            }
            [datePicker showdate:self.textTimeStart.text];
        } else {
            //[datePicker showdate:self.textTimeEnd.text];
        }
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:datePicker];
        CGRect rect;
        if (self.descState == kAddNewRecord) {
            rect = [self.view convertRect:sender.frame fromView:self.contentView];
        } else {
            rect = [self.view convertRect:sender.frame fromView:self.viewNormalDesc];
        }
        [self.pickerPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        datePicker.dateselectPopover=self.pickerPopover;
    }
}
//收费站选择
- (IBAction)viewNormalSFZtextTouch:(id)sender {
//    2050
    UITextField * textfield = sender;
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        InspectionCheckPickerViewController *icPicker=[self.storyboard instantiateViewControllerWithIdentifier:@"InspectionCheckPicker"];
        icPicker.pickerState=kStation;
        self.pickerState = kStation;
        if(textfield.tag == 2051){
            self.selectsfztag = 2051;
        }
        icPicker.delegate=self;
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:icPicker];
        [self.pickerPopover presentPopoverFromRect:[textfield frame] inView:self.viewNormalDesc permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        icPicker.pickerPopover=self.pickerPopover;
    }
}

- (IBAction)viewNormalRoadTouch:(id)sender {
    if ([sender tag] == 1003) {
        [self roadSegmentPickerPresentPickerState:kRoadSegment fromRect:[(UITextField *)sender frame]];
    }
    if ([sender tag] == 1004) {
        [self roadSegmentPickerPresentPickerState:kRoadSide fromRect:[(UITextField *)sender frame]];
    }
}

- (IBAction)pickerNormalDesc:(id)sender {
    [self pickerPresentPickerState:kDescription fromRect:[(UITextField *)sender frame]];    
}

- (IBAction)addCounstructionChangeBack:(id)sender {
    [self.delegate addObserverToKeyBoard];
    [self dismissViewControllerAnimated:YES completion:^{
        [((RoadInspectViewController*)self.delegate) performSegueWithIdentifier:@"toCounstructionChangeBack" sender:self];
    }];
}

- (IBAction)addTrafficRecord:(id)sender {
    [self.delegate addObserverToKeyBoard];
    [self dismissViewControllerAnimated:YES completion:^{
        [((RoadInspectViewController*)self.delegate) performSegueWithIdentifier:@"toTrafficRecord" sender:self];
    }];
}

@end
