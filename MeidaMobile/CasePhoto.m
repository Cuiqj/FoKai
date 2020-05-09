//
//  CasePhoto.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-8-27.
//
//

#import "CasePhoto.h"
#import "NSString+Base64.h"

@implementation CasePhoto

@dynamic photo_name;
@dynamic project_id;
@dynamic proveinfo_id;
@dynamic myid;
@dynamic type;
@dynamic remark;
@dynamic isuploaded;
@dynamic photopath;

+(NSArray *)casePhotosForCase:(NSString *)caseID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CasePhoto" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    fetchRequest.entity    = entity;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"project_id == %@",caseID];
    fetchRequest.predicate = predicate;
    return [context executeFetchRequest:fetchRequest error:nil];
}

+ (void)deletePhotoForCase:(NSString *)caseID photoName:(NSString *)photoName{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CasePhoto" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    fetchRequest.entity    = entity;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"project_id == %@ && photo_name == %@",caseID,photoName];
    fetchRequest.predicate = predicate;
    NSArray *temp          = [context executeFetchRequest:fetchRequest error:nil];
    for (NSManagedObject *obj in temp) {
        [context deleteObject:obj];
    }
    [[AppDelegate App] saveContext];
}


//拼接图片上传的内容    服务区管理的图片
-(NSString *)dataXMLStringForCasePhotoServiceManage_jpg{
    NSString *casePhotoStr = @"<id>%@</id>"
    "<parent_id>%@</parent_id>"
    "<photo_name>%@</photo_name>"
    "<imagetype>JPG</imagetype>"
    "<data>%@</data>"
    "<remark>%@</remark>";
//    CasePhoto *photo = (CasePhoto*)self;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[pathArray objectAtIndex:0];
    NSString *photoPath=[NSString stringWithFormat:@"CasePhoto/%@",self.proveinfo_id];
    photoPath=[documentPath stringByAppendingPathComponent:photoPath];
    //    UIImage *image        = [UIImage imageWithContentsOfFile:[photoPath stringByAppendingPathComponent:photo.photo_name]];
    //    image=[UIImage imageWithContentsOfFile:photo.photopath];
    UIImage * image = [[UIImage alloc] initWithContentsOfFile:photoPath];
    if(image){
        
    }else{
        image= [UIImage imageWithContentsOfFile:self.photopath];
    }
    NSData *data          = UIImageJPEGRepresentation(image, 0.5);// UIImageJPGRepresentation(image);
    NSString *stringImage = [NSString base64forData:data];
    casePhotoStr          = [NSString stringWithFormat:casePhotoStr,self.myid?self.myid:@"",self.proveinfo_id?self.proveinfo_id:self.project_id,self.photo_name?self.photo_name:@"",stringImage?stringImage:@"",self.remark?self.remark:@""];
    return casePhotoStr;
}


//拼接图片上传的内容
-(NSString *)dataXMLStringForCasePhoto{
    NSString *casePhotoStr = @"<id>%@</id>"
    "<parent_id>%@</parent_id>"
    "<photo_name>%@</photo_name>"
    "<imagetype>JPG</imagetype>"
    "<type>%@</type>"
    "<data>%@</data>"
    "<remark>%@</remark>";
    CasePhoto *photo = (CasePhoto*)self;
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[pathArray objectAtIndex:0];
    NSString *photoPath;
    if(photo.proveinfo_id){
        photoPath = [NSString stringWithFormat:@"CasePhoto/%@",photo.proveinfo_id];
    }else{
        photoPath = [NSString stringWithFormat:@"CasePhoto/%@",photo.project_id];
    }
    photoPath=[documentPath stringByAppendingPathComponent:photoPath];
    
    //    /var/mobile/Containers/Data/Application/ADD6AE2D-3112-4028-9608-390E6E6482B9/Documents/CasePhoto/190709130516087/1.jpg
    
    UIImage * image        = [UIImage imageWithContentsOfFile:[photoPath stringByAppendingPathComponent:photo.photo_name]];
    if(image){
        
    }else{
        //        photoPath = [photoPath stringByReplacingOccurrencesOfString:@"CasePhoto/" withString:@"InspectionConstruction/"];
        image= [UIImage imageWithContentsOfFile:[[photoPath stringByReplacingOccurrencesOfString:@"CasePhoto/" withString:@"InspectionConstruction/"] stringByAppendingPathComponent:photo.photo_name]];
    }
    if(image){
        
    }else{
        image= [UIImage imageWithContentsOfFile:photo.photopath];
    }
    NSData *data          = UIImageJPEGRepresentation(image, 0.5);// UIImageJPGRepresentation(image);
    NSString *stringImage = [NSString base64forData:data];
    casePhotoStr          = [NSString stringWithFormat:casePhotoStr,photo.myid?photo.myid:@"",photo.proveinfo_id?photo.proveinfo_id:photo.project_id,photo.photo_name?photo.photo_name:@"",photo.type?photo.type:@"",stringImage?stringImage:@"",photo.remark?photo.remark:@""];
    return casePhotoStr;
}

@end
