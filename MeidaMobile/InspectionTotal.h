//
//  InspectionTotal.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import <CoreData/CoreData.h>

@interface InspectionTotal : NSManagedObject


//关联了Inspection的日期
@property (nonatomic,retain) NSDate * inspect_date;

//记录编号
@property (nonatomic,retain) NSString * myid;
//巡查编号
@property (nonatomic,retain) NSString * inspectionid;

//每日事件
@property (nonatomic,retain) NSNumber * daily_event;
//车牌号
@property (nonatomic,retain) NSString * car_num;
//班别
@property (nonatomic,retain) NSString * personnel_class;
//"接班公里数"
@property (nonatomic,retain) NSNumber * mileage_before_trans;
//"交班公里数"
@property (nonatomic,retain) NSNumber * mileage_after_trans;
//"巡查人"
@property (nonatomic,retain) NSNumber * inspect_people_num;
//"巡查次"
@property (nonatomic,retain) NSNumber * inspect_times;
//"事故"
@property (nonatomic,retain) NSNumber * traffic_accident;
//"有路产"
@property (nonatomic,retain) NSNumber * roadasset_case;
//清障
@property (nonatomic,retain) NSNumber * clear_barrier;
//帮助故障车
@property (nonatomic,retain) NSNumber * help_trouble_car;
//检查桥涵
@property (nonatomic,retain) NSNumber * check_bridge;
//检查施工现场
@property (nonatomic,retain) NSNumber * check_job_site;
//纠正违反公路施工安全作业规程行为
@property (nonatomic,retain) NSNumber * correct_violate;
//劝离行人(次)
@property (nonatomic,retain) NSNumber * exhort_passerby;
//劝离路肩停放车辆
@property (nonatomic,retain) NSNumber * exhort_car;
//便民
@property (nonatomic,retain) NSNumber * help_people;
//恢复中央活动栏杆
@property (nonatomic,retain) NSNumber * resume_railing;
//检查服务区
@property (nonatomic,retain) NSNumber * check_service;
//发现违法行为
@property (nonatomic,retain) NSNumber * find_illegal;
//纠正违法行为
@property (nonatomic,retain) NSNumber * alter_illegal;
//分流
@property (nonatomic,retain) NSNumber * shunt;
//清理桥下杂物
@property (nonatomic,retain) NSNumber * clean_bridge_misc;
//开施工整改通知书
@property (nonatomic,retain) NSNumber * construction_note;
//开停工整改通知书
@property (nonatomic,retain) NSNumber * stop_note;
//查处违章建筑
@property (nonatomic,retain) NSNumber * find_illegal_con;
//拆除违章建筑
@property (nonatomic,retain) NSNumber * remove_illegal_con;
//查处违章设广告
@property (nonatomic,retain) NSNumber * find_illegal_adv;
//拆除违章广告
@property (nonatomic,retain) NSNumber * remove_illegal_adv;
//其它违章行为
@property (nonatomic,retain) NSNumber * other_illegal;
//组织宣传
@property (nonatomic,retain) NSNumber * propaganda;
////抓获损坏路产案件
//@property (nonatomic,retain) NSNumber * break_case;
////拆除桥下铺（处/平方米）
//@property (nonatomic,retain) NSNumber * remove_bridge_berth;
////纠正违反安全作业规程
//@property (nonatomic,retain) NSNumber * alter_safety_specs;
////为故障车摆放交通设施(次)
@property (nonatomic,retain) NSNumber * put_facilities;
//回收交通设施
@property (nonatomic,retain) NSNumber * get_facilities;

@property (nonatomic,retain) NSNumber * isuploaded;


+(InspectionTotal *)InspectionTotalforinspectionid:(NSString *)specialID;

@end
