//
//  CaseInvestigatePrintViewController.m
//  FoKaiMobile
//
//  Created by admin on 2019/5/30.
//

#import "CaseInvestigatePrintViewController.h"

#import "CaseProveInfo.h"
#import "UserInfo.h"
#import "Citizen.h"
#import "CaseInfo.h"


static NSString * const xmlName = @"InvestigateTable";
@interface CaseInvestigatePrintViewController ()
@property (nonatomic, retain) CaseInvestigate * caseInvestigate;
@property (nonatomic, retain) Citizen * citizen;
@property (nonatomic) NSUInteger  selecttag;
@property (nonatomic,strong) UIPopoverController * pickerPopover;

@end
@implementation CaseInvestigatePrintViewController
@synthesize caseID = _caseID;


- (void)viewDidLoad {
    [super setCaseID:self.caseID];
    CGRect viewFrame = CGRectMake(0.0, 0.0, 900, 920);
    self.view.frame = viewFrame;
    if (![self.caseID isEmpty]) {
        self.caseInvestigate = [CaseInvestigate InvestigateForCase:self.caseID];
        if(!self.caseInvestigate){
            self.caseInvestigate = [CaseInvestigate newDataObjectWithEntityName:@"CaseInvestigate"];
            self.caseInvestigate.myid = self.caseID;
            [self generateDefaultInfo:self.caseInvestigate];
        }
        [self pageLoadInfo];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)pageLoadInfo{
    CaseInfo *caseInfo=[CaseInfo caseInfoForID:self.caseID];
    // 当事人
    CaseProveInfo * proveInfo = [CaseProveInfo proveInfoForCase:self.caseID];
    self.citizen = [Citizen citizenForCitizenName:proveInfo.citizen_name nexus:@"当事人" case:self.caseID];
    if (caseInfo) {
        self.labelanhao.text = [NSString stringWithFormat:@"案件（%@）年佛开交赔字第（%@）号",caseInfo.case_mark2,caseInfo.full_case_mark3];
    }
    if(proveInfo){
//        self.textcasedesc.text = [NSString stringWithFormat:@"%@%@因交通事故%@", self.citizen.automobile_number, self.citizen.automobile_pattern, proveInfo.case_short_desc];
        self.textcasedesc.text = [NSString stringWithFormat:@"交通事故%@",proveInfo.case_short_desc];
    }
    if (self.caseInvestigate) {
        //    调查人员
        NSArray * namearray = [self.caseInvestigate.investigater_name componentsSeparatedByString:@","];
        if ([namearray count]>=1) {
            self.textnameone.text = [namearray objectAtIndex:0];
        }
        if ([namearray count]>=2) {
            self.textnametwo.text = [namearray objectAtIndex:1];
        }
        if ([namearray count]>=3) {
            self.textnamethree.text = [namearray objectAtIndex:2];
        }
//        [self pageLoadInfoforWitness];

        self.textviewWitness.text = self.caseInvestigate.witness;
    
        //   案件调查经过及结论
        self.textviewcourse.text = self.caseInvestigate.course;
        //   领导意见
        self.textviewleader_comment.text = self.caseInvestigate.leader_comment;
        //备注
        self.textviewremark.text = self.caseInvestigate.remark;
    }
}

-(void)pageLoadInfoforWitness{
    //所附证据材料
    if([self.caseInvestigate.witness containsString:@"书证"]){
        self.textwitnessone.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"物证"]){
        self.textwitnesstwo.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"视听材料"]){
        self.textwitnessthree.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"证人证言"]){
        self.textwitnessfour.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"现场照片"]){
        self.textwitnessfive.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"当事人陈述"]){
        self.textwitnesssix.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"鉴定结论"]){
        self.textwitnessseven.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"勘验检查笔录"]){
        self.textwitnesseight.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"询问笔录"]){
        self.textwitnessnine.selected = YES;
    }
    if([self.caseInvestigate.witness containsString:@"现场勘验草图"]){
        self.textwitnessten.selected = YES;
    }
}

//根据案件记录，完整 调查报告
- (void)generateDefaultInfo:(CaseInvestigate *)caseInvestigate{
    NSString *currentUserID=[[NSUserDefaults standardUserDefaults] stringForKey:USERKEY];
    NSString *currentUserName=[[UserInfo userInfoForUserID:currentUserID] valueForKey:@"name"];
    NSArray *inspectorArray = [[NSUserDefaults standardUserDefaults] objectForKey:INSPECTORARRAYKEY];
    if ([inspectorArray count] == 0) {
        self.caseInvestigate.investigater_name = currentUserName;
    }else if (inspectorArray.count >= 1) {
        caseInvestigate.investigater_name = currentUserName;
        for (int i = 0; i<[inspectorArray count]; i++) {
            if (![[inspectorArray objectAtIndex:i] isEqualToString:currentUserName]) {
                self.caseInvestigate.investigater_name = [NSString stringWithFormat:@"%@,%@", self.caseInvestigate.investigater_name,[inspectorArray objectAtIndex:i]];
            }
        }
    }
    self.caseInvestigate.course = [self CourseandConclusionofthecase];
    self.caseInvestigate.witness = @"勘验检查笔录1份；\n询问笔录1份；\n现场勘验图1份；\n现场拍摄照片1张。";
    [[AppDelegate App] saveContext];
}
- (NSString *)CourseandConclusionofthecase{
    CaseInfo *caseInfo=[CaseInfo caseInfoForID:self.caseID];
    CaseProveInfo * proveInfo = [CaseProveInfo proveInfoForCase:self.caseID];
    NSString * remark;
    if (caseInfo) {
        NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
        [dateformatter setLocale:[NSLocale currentLocale]];
        NSString * datestring = [dateformatter stringFromDate:caseInfo.happen_date];
        self.citizen = [Citizen citizenForCitizenName:proveInfo.citizen_name nexus:@"当事人" case:self.caseID];
        NSString * cartype = self.citizen.automobile_pattern;
        NSString * carnumber = self.citizen.automobile_number;
        NSString * caseproveplace = proveInfo.remark;
//        经路政人员现场勘查认定，闵彬勇于2012年6月3日22时00分驾驶桂P11617大巴车行驶至沈海高速（佛开段）开平方向K3128+700m处，因车辆失控与粤GJZ992大货车和粤J22369小车发生交通事故，造成高速公路路产损坏，事实清楚，证据充分确凿。
        remark = [NSString stringWithFormat:@"经路政人员现场勘查认定，%@于%@驾驶%@%@行驶至%@处，因%@发生交通事故，造成高速公路路产损坏，事实清楚，证据充分确凿。",self.citizen.party,datestring,cartype,carnumber,caseproveplace,caseInfo.case_reason];
        
    }
    return remark;
}

#pragma mark - CasePrintProtocol
- (NSString *)templateNameKey{
    return DocNameKeyPei_PeiBuChangDiaoChaBaoGao;
}

- (IBAction)userSelect:(id)sender {
    UITextField * field = sender;
    self.selecttag = field.tag;
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        UserPickerViewController *acPicker=[[UserPickerViewController alloc] init];
        acPicker.delegate=self;
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:acPicker];
        [self.pickerPopover setPopoverContentSize:CGSizeMake(140, 200)];
        [self.pickerPopover presentPopoverFromRect:field.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        acPicker.pickerPopover=self.pickerPopover;
    }
}
- (void)setUser:(NSString *)name andUserID:(NSString *)userID{
    NSString * secondname = self.textnametwo.text.length>0 ? [NSString stringWithFormat:@",%@",self.textnametwo.text]:@"";
    NSString * thirdname = self.textnamethree.text.length>0 ? [NSString stringWithFormat:@",%@",self.textnamethree.text]:@"";
    if (self.selecttag == 6) {
        self.textnameone.text = name;
        self.caseInvestigate.investigater_name = [NSString stringWithFormat:@"%@%@%@",self.textnameone.text,secondname,thirdname];
    }else if (self.selecttag == 7){
        self.textnametwo.text = name;
        self.caseInvestigate.investigater_name = [NSString stringWithFormat:@"%@%@%@",self.textnameone.text,[NSString stringWithFormat:@",%@",self.textnametwo.text],thirdname];
    }else if (self.selecttag == 8){
        self.textnamethree.text = name;
        self.caseInvestigate.investigater_name = [NSString stringWithFormat:@"%@%@%@",self.textnameone.text,secondname,[NSString stringWithFormat:@",%@",self.textnamethree.text]];
    }
}

- (IBAction)textWitnessClick:(id)sender {
    UIButton * button = sender;
    [self pagesaveWitnessClickwithtag:button.tag andselcted:button.selected];
    if (button.selected) {
        [button setSelected:NO];
    }else{
        [button setSelected:YES];
    }
}
-  (void)pagesaveWitnessClickwithtag:(NSUInteger)tag andselcted:(BOOL)select{
    NSArray * array = @[@"书证",@"物证",@"视听材料",@"证人证言",@"现场照片",@"当事人陈述",@"鉴定结论",@"勘验检查笔录",@"询问笔录",@"现场勘验草图"];
    for (int i = 0; i<10; i++) {
        if(select){
            if (tag == i+11) {
                NSString * deletestring = array[i];
                if ([self.caseInvestigate.witness containsString:[NSString stringWithFormat:@"、%@",deletestring]]) {
                    deletestring = [NSString stringWithFormat:@"、%@",deletestring];
                }else if ([self.caseInvestigate.witness containsString:[NSString stringWithFormat:@"%@、",deletestring]]) {
                    deletestring = [NSString stringWithFormat:@"%@、",deletestring];
                }
                self.caseInvestigate.witness = [self.caseInvestigate.witness stringByReplacingOccurrencesOfString:deletestring withString:@""];
             }
        }else{
            if (tag == i+11) {
                NSString * addstring = array[i];
                if (self.caseInvestigate.witness.length !=0) {
                    addstring = [NSString stringWithFormat:@"、%@",addstring];
                    self.caseInvestigate.witness = [NSString stringWithFormat:@"%@%@",self.caseInvestigate.witness,addstring];
                }else{
                    self.caseInvestigate.witness = addstring;
                }
                
            }
        }
    }
    [[AppDelegate App] saveContext];
}
- (BOOL)savePageInfo{
    self.caseInvestigate.remark = self.textviewremark.text;
    self.caseInvestigate.leader_comment = self.textviewleader_comment.text;
    self.caseInvestigate.course = self.textviewcourse.text;
    self.caseInvestigate.witness = self.textviewWitness.text;
    [[AppDelegate App] saveContext];
    return TRUE;
}

-(NSURL *)toFullPDFWithTable:(NSString *)filePath{
    [self savePageInfo];
    if (![filePath isEmpty]) {
        CGRect pdfRect=CGRectMake(0.0, 0.0, paperWidth, paperHeight);
        UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
        UIGraphicsBeginPDFPageWithInfo(pdfRect, nil);
        [self drawStaticTable:@"InvestigateTable"];
        [self drawDateTable:@"InvestigateTable" withDataModel:self.caseInvestigate];
        
        //add by lxm 2013.05.08
        CaseInfo *caseInfo = [CaseInfo caseInfoForID:self.caseID];
        self.labelanhao.text = [[NSString alloc] initWithFormat:@"(%@)年%@交赔字第0%@号",caseInfo.case_mark2, [[AppDelegate App].projectDictionary objectForKey:@"cityname"], caseInfo.full_case_mark3];
        [self drawDateTable:xmlName withDataModel:self.citizen];
        CaseProveInfo *proveInfo = [CaseProveInfo proveInfoForCase:self.caseID];
        [self drawDateTable:xmlName withDataModel:proveInfo];
        
        
        UIGraphicsEndPDFContext();
        return [NSURL fileURLWithPath:filePath];
    } else {
        return nil;
    }
}

-(NSURL *)toFullPDFWithPath_deprecated:(NSString *)filePath{
    [self savePageInfo];
    if (![filePath isEmpty]) {
        CGRect pdfRect=CGRectMake(0.0, 0.0, paperWidth, paperHeight);
        UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
        UIGraphicsBeginPDFPageWithInfo(pdfRect, nil);
        [self drawStaticTable1:xmlName];
        [self drawDateTable:xmlName withDataModel:self.caseInvestigate];
        
        //add by lxm 2013.05.08
        CaseInfo *caseInfo = [CaseInfo caseInfoForID:self.caseID];
        [self drawDateTable:xmlName withDataModel:caseInfo];
        
        [self drawDateTable:xmlName withDataModel:self.citizen];
        
        CaseProveInfo *proveInfo = [CaseProveInfo proveInfoForCase:self.caseID];
        [self drawDateTable:xmlName withDataModel:proveInfo];
        
        UIGraphicsEndPDFContext();
        return [NSURL fileURLWithPath:filePath];
    } else {
        return nil;
    }
}

-(NSURL *)toFormedPDFWithPath_deprecated:(NSString *)filePath{
    [self savePageInfo];
    if (![filePath isEmpty]) {
        CGRect pdfRect=CGRectMake(0.0, 0.0, paperWidth, paperHeight);
        NSString *formatFilePath = [NSString stringWithFormat:@"%@.format.pdf", filePath];
        UIGraphicsBeginPDFContextToFile(formatFilePath, CGRectZero, nil);
        UIGraphicsBeginPDFPageWithInfo(pdfRect, nil);
        [self drawDateTable:xmlName withDataModel:self.caseInvestigate];
        
        //add by lxm 2013.05.08
        CaseInfo *caseInfo = [CaseInfo caseInfoForID:self.caseID];
        [self drawDateTable:xmlName withDataModel:caseInfo];
        [self drawDateTable:xmlName withDataModel:self.citizen];
        
        CaseProveInfo *proveInfo = [CaseProveInfo proveInfoForCase:self.caseID];
        [self drawDateTable:xmlName withDataModel:proveInfo];
        
        UIGraphicsEndPDFContext();
        return [NSURL fileURLWithPath:formatFilePath];
    } else {
        return nil;
    }
}
- (id)dataForPDFTemplate{
    [self savePageInfo];
    id citizenData = @{};
    CaseInfo *caseInfo = [CaseInfo caseInfoForID:self.caseID];
    if (caseInfo) {
        NSString * anhao = self.labelanhao.text >0 ? self.labelanhao.text :@"";
        NSString * mark2 = caseInfo.case_mark2;
        NSString * mark3 = [NSString stringWithFormat:@"佛开交赔字第%@",caseInfo.full_case_mark3];
        NSString * anyou = self.textcasedesc.text.length >0 ? self.textcasedesc.text :@"无";
        NSString * userone = self.textnameone.text.length>0 ? [NSString stringWithFormat:@"%@ %@",self.textnameone.text,[UserInfo exelawidforname:self.textnameone.text]] :@"";
        NSString * usertwo = self.textnametwo.text.length >0 ? [NSString stringWithFormat:@"%@ %@",self.textnametwo.text,[UserInfo exelawidforname:self.textnametwo.text]] :@"";
        NSString * userthree = self.textnamethree.text.length >0 ? [NSString stringWithFormat:@"%@ %@",self.textnamethree.text,[UserInfo exelawidforname:self.textnamethree.text]] :@"";
        //案件经过
        NSString * course = self.textviewcourse.text;
        //领导意见
        NSString * leadercomment = self.textviewleader_comment.text;
        //备注
        NSString * remark = self.textviewremark.text;
        //所附证据材料
        NSString * witness = self.caseInvestigate.witness;
        NSString * partyname = @"";
        NSString * adress = @"";
        NSString * citizenorgname = @"";
        NSString * citizenorgprincipal = @"";
        NSString * automobileaddress = @"";
        NSString * cartypeandnumber = @"";
        id caseData = @{
                        @"anhao":anhao,
                        @"mark2":mark2,
                        @"mark3":mark3,
                        @"anyou":anyou,
                        @"userone":userone,
                        @"usertwo":usertwo,
                        @"userthree":userthree,
                        @"course":course,
                        @"witness":witness,
                        @"leadercomment":leadercomment,
                        @"remark":remark,
                        };
        if (self.citizen) {
            partyname = self.citizen.party.length >0 ? self.citizen.party:@"无";
            adress = self.citizen.address.length >0 ? self.citizen.address :@"无" ;
            citizenorgname = self.citizen.org_name.length >0 ? self.citizen.org_name :@"无";
            citizenorgprincipal = self.citizen.org_principal.length >0 ? self.citizen.org_principal :@"无";
            automobileaddress = self.citizen.automobile_address.length >0 ? self.citizen.automobile_address :@"无";
            cartypeandnumber = [NSString stringWithFormat:@"%@ %@",self.citizen.automobile_pattern,self.citizen.automobile_number] ? [NSString stringWithFormat:@"%@ %@",self.citizen.automobile_pattern,self.citizen.automobile_number]  :@"无";
            citizenData = @{
                            @"citizenname":partyname,
                            @"adress":adress,
                            @"orgname":citizenorgname,
                            @"orgnameone":citizenorgprincipal,
                            @"caradress":automobileaddress,
                            @"cartypeandnumber":cartypeandnumber,
                            };
        }
        id data = @{
                    @"case": caseData,
                    @"citizen": citizenData,
                    };
        return data;
    }
    return nil;
}
- (void)deleteCurrentDoc{
    if (![self.caseID isEmpty] && self.caseInvestigate){
        [[[AppDelegate App] managedObjectContext] deleteObject:self.caseInvestigate];
        [[AppDelegate App] saveContext];
        self.caseInvestigate = nil;
    }
}

@end
