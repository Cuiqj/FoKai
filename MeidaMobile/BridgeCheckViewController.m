//
//  BridgeCheckViewController.m
//  FoKaiMobile
//
//  Created by admin on 2017/12/20.
//
//

#import "BridgeCheckViewController.h"
#import "InspectionBridgePoint.h"
#import "InspectionBridge.h"
#import "ListSelectViewController.h"
#import "NSMutableArray+TKProcess.h"
#import "UserInfo.h"
@interface BridgeCheckViewController ()<ListSelectPopoverDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray      *datas;
@property (nonatomic,strong) NSString            *currtID;
@property (nonatomic,strong) InspectionBridge    *currentInspectionBridge;
@property (nonatomic,strong) UIPopoverController *popVC;

@end

@implementation BridgeCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.IllegalView setAlpha:0];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setup{
    [self.textBridgeCode addTarget:self action:@selector(selectBridge:) forControlEvents:UIControlEventTouchDown];
    [self.textChecker addTarget:self action:@selector(selectChecker:) forControlEvents:UIControlEventTouchDown];
    
    self.datas=[[InspectionBridge allInspectionBridge] mutableCopy];
}
-(void)keyboardWillShow:(NSNotification*)notifaction{
    for (UIView *cell in self.IllegalView.subviews) {
        if([cell isFirstResponder]){
            CGRect originFrame = self.view.frame;
            CGRect newFrame    = CGRectMake(originFrame.origin.x, originFrame.origin.y-250, originFrame.size.width, originFrame.size.height);
            self.view.frame    = newFrame;
            // self.IllegalView.backgroundColor=[UIColor lightGrayColor];
            [self.view bringSubviewToFront:self.IllegalView];
            break;
        }
    }
    
    
}
-(void)keyboardWillHide:(NSNotification*)notifacation{
    for (UIView *cell in self.IllegalView.subviews) {
        if([cell isFirstResponder]){
            CGRect originFrame = self.view.frame;
            CGRect newFrame    = CGRectMake(originFrame.origin.x, originFrame.origin.y+250, originFrame.size.width, originFrame.size.height);
            self.view.frame    = newFrame;
            //self.IllegalView.backgroundColor=[UIColor whiteColor];
            break;
        }}
    
    
}
#pragma UITableView 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datas.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InspectionBridge *inspect=[self.datas objectAtIndex:indexPath.row];
    static NSString *reuseid=@"BridgeInspect";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid];
    if(!cell){
        cell=[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseid];
    }
    cell.textLabel.text = inspect.bridge_name;
    NSDateFormatter * formator=[[NSDateFormatter alloc]init];
    [formator setLocale:[NSLocale currentLocale]];
    [formator setDateFormat: @"yyyy-MM-dd hh:mm" ];
    cell.detailTextLabel.text = [formator stringFromDate: inspect.record_create_time];
    return  cell;
}
//选桥梁
-(void)selectBridge:(UITextField*) sender{
    if([self.popVC isPopoverVisible]){
        [self.popVC dismissPopoverAnimated:YES];
        self.popVC = nil;
    }else{
        /*
         ListSelectViewController *listVC=[[ListSelectViewController alloc]init];
         listVC.data=[[[InspectionBridgePoint allBridges] valueForKeyPath:@"bridge_name"] mutableCopy];
         listVC.delegate = self;
         self.popVC=[[UIPopoverController alloc]initWithContentViewController:listVC];
         [self.popVC presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
         */
        ListSelectViewController *listPicker=[self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectPoPover"];
        listPicker.delegate = self;
        listPicker.data     = [[[[InspectionBridgePoint allBridges] valueForKeyPath:@"xh"]   mutableCopy] withOutNull];;
        self.popVC=[[UIPopoverController alloc] initWithContentViewController:listPicker];
        CGRect rect         = sender.frame;
        [self.popVC presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        listPicker.pickerPopover    = self.popVC;
        listPicker.selectedIndexPathBlock=^(NSIndexPath *indexPath){
            InspectionBridgePoint * bridge=[[InspectionBridgePoint allBridges] objectAtIndex:indexPath.row];
            self.textBridgeName.text    = bridge.bridge_name;
            self.textBridgeCode.text    = bridge.xh;
            self.textBridgeType.text    = bridge.type;
            self.textBridgeStation.text = bridge.station;
        };
    }
}
//选巡查人
-(void)selectChecker:(UITextField*) sender{
    if([self.popVC isPopoverVisible]){
        [self.popVC dismissPopoverAnimated:YES];
        self.popVC = nil;
    }else{
        /*
         ListSelectViewController *listVC=[[ListSelectViewController alloc]init];
         listVC.data=[[[InspectionBridgePoint allBridges] valueForKeyPath:@"bridge_name"] mutableCopy];
         listVC.delegate = self;
         self.popVC=[[UIPopoverController alloc]initWithContentViewController:listVC];
         [self.popVC presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
         */
        ListSelectViewController *listPicker=[self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectPoPover"];
        listPicker.delegate = self;
        listPicker.data     = [[[[UserInfo allUserInfo] valueForKeyPath:@"name"]   mutableCopy] withOutNull];;
        self.popVC=[[UIPopoverController alloc] initWithContentViewController:listPicker];
        CGRect rect         = sender.frame;
        [self.popVC presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        listPicker.pickerPopover = self.popVC;
        listPicker.selectedIndexPathBlock=^(NSIndexPath *indexPath){
            NSString*names=[listPicker.data objectAtIndex:indexPath.row];
            if(![self.textChecker.text isEmpty]){
                self.textChecker.text=[NSString stringWithFormat:@"%@、%@",self.textChecker.text,names];
            }else{
                self.textChecker.text = names;
            }
        };
    }
}
- (IBAction)btnNew:(id)sender {
}

- (IBAction)btnAdd:(id)sender {
}

- (IBAction)illegalChanged:(id)sender {
    if(self.isIllegalSwitch.isOn){
        [self.IllegalView setAlpha:1];
    }else{
        [self.IllegalView setAlpha:0];
    }
}
@end
