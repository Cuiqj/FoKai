//
//  CasePhoto.h
//  GDRMMobile
//
//  Created by yu hongwu on 12-8-27.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CasePhoto : NSManagedObject

@property (nonatomic, retain) NSString * myid;
@property (nonatomic, retain) NSString * proveinfo_id;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * photo_name;
@property (nonatomic, retain) NSString * project_id;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSNumber * isuploaded;
@property (nonatomic,retain ) NSString *photopath;

//@property (nonatomic, retain) NSString * caseinfo_id;
//@property (nonatomic, retain) NSString * photo_name;
+(NSArray *)casePhotosForCase:(NSString *)caseID;
+ (void)deletePhotoForCase:(NSString *)caseID photoName:(NSString *)photoName;



//拼接图片上传的内容
-(NSString *)dataXMLStringForCasePhotoServiceManage_jpg;
-(NSString *)dataXMLStringForCasePhoto;
@end
