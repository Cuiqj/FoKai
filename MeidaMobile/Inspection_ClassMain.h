//
//  ccc.h
//  FoKaiMobile
//
//  Created by admin on 2020/4/30.
//

#import "BaseManageObject.h"

@interface Inspection_ClassMain : BaseManageObject

@property (nonatomic,retain) NSString * myid;
@property (nonatomic,retain) NSString * inspectionid;
@property (nonatomic,retain) NSString * org_id;
//巡查日期    年月日
@property (nonatomic,retain) NSDate * date_inspection;
//本班次巡查里程         数字
@property (nonatomic,retain) NSString * inspection_mile;
//本班次参加巡查人次"       数字
@property (nonatomic,retain) NSString * inspection_man_num;
//fxqx       发现报送道路、交安设施缺陷"   数字
@property (nonatomic,retain) NSString * fxqx;
//fxwfxw       发现违法行为"   数字
@property (nonatomic,retain) NSString * fxwfxw;
//jzwfxw       纠正违法行为"   数字
@property (nonatomic,retain) NSString * jzwfxw;
//cllmzaw       处理路面障碍物"   数字
@property (nonatomic,retain) NSString * cllmzaw;
//bzgzc       帮助故障车"   数字
@property (nonatomic,retain) NSString * bzgzc;
//gzzfj       告知交通综合行政执法局处理案件"   数字
@property (nonatomic,retain) NSString * gzzfj;
//fcflws       发出法律文书"   数字
@property (nonatomic,retain) NSString * fcflws;
//hhzyhdlg       恢复中央活动栏杆"   数字
@property (nonatomic,retain) NSString * hhzyhdlg;

//accident_num       发生交通事故/其中涉及路产损害"   字符    FormatString="input190"  DefaultValue="0/0" />
@property (nonatomic,retain) NSString * accident_num;
//deal_accident_num       处理路产损害赔偿"   字符    FormatString="input190"  DefaultValue="0/0" />
@property (nonatomic,retain) NSString * deal_accident_num;
//deal_bxlp_num       处理路产保险理赔案件"   字符    FormatString="input190"  DefaultValue="0/0" />
@property (nonatomic,retain) NSString * deal_bxlp_num;
//jcsgd       检查施工点/纠正违反公路施工安全作业规程行为"   字符    FormatString="input190"  DefaultValue="0/0"
@property (nonatomic,retain) NSString * jcsgd;
//qlxr       劝离行人"   字符    DefaultValue="0/0" FormatString="input190"  />
@property (nonatomic,retain) NSString * qlxr;

@property (nonatomic, retain) NSNumber * isuploaded;

+(Inspection_ClassMain *)InspectionClassMainforinspectionid:(NSString *)specialID;

@end
