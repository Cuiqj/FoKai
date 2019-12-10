//
//  DataDownLoad.m
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-10-22.
//
//

#import "DataDownLoad.h"
//#import "AGAlertViewWithProgressbar.h"
#import "AlertViewWithProgressbar.h"


@interface DataDownLoad()
//@property (nonatomic,retain) AGAlertViewWithProgressbar *progressView;
@property (nonatomic,retain) AlertViewWithProgressbar *progressView;
@property (nonatomic,assign) NSInteger                parserCount;
@property (nonatomic,assign) NSInteger                currentParserCount;
@property (nonatomic,assign) BOOL                     stillParsing;

- (void)parserFinished:(NSNotification *)noti;
@end

@implementation DataDownLoad
@synthesize progressView       = _progressView;
@synthesize parserCount        = _parserCount;
@synthesize currentParserCount = _currentParserCount;
@synthesize stillParsing       = _stillParsing;

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parserFinished:) name:@"ParserFinished" object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setProgressView:nil];
}

- (void)startDownLoad:(NSString *)orgID{
    if ([WebServiceHandler isServerReachable]) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        self.progressView=[[AlertViewWithProgressbar alloc] initWithTitle:@"同步基础数据" message:@"正在下载，请稍候……" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        MAINDISPATCH(^(void){
            [self.progressView show];
        });
        self.parserCount        = DOWNLOADCOUNT;
        self.currentParserCount = self.parserCount;
        @autoreleasepool {
            InitUser *initUser = [[InitUser alloc] init];
            [initUser downLoadUserInfo:orgID];
            WAITFORPARSER
            InitIconModel *initIcon = [[InitIconModel alloc] init];
            [initIcon downLoadIconModels:orgID];
            WAITFORPARSER
            InitProvince *initProvice = [[InitProvince alloc] init];
            [initProvice downloadProvince:orgID];
            WAITFORPARSER
            InitCities *initCities = [[InitCities alloc] init];
            [initCities downloadCityCode];
            WAITFORPARSER
            InitRoadSegment *initRoad = [[InitRoadSegment alloc] init];
            [initRoad downloadRoadSegment:orgID];
            
            WAITFORPARSER
            InitRoadAssetPrice *initRoadAssetPrice = [[InitRoadAssetPrice alloc] init];
            [initRoadAssetPrice downloadRoadAssetPrice];
            WAITFORPARSER
            InitInquireAnswerSentence *iias = [[InitInquireAnswerSentence alloc] init];
            [iias downloadInquireAnswerSentence];
            WAITFORPARSER
            InitInquireAskSentence *iiask = [[InitInquireAskSentence alloc] init];
            [iiask downloadInquireAskSentence];
            WAITFORPARSER
            InitCheckItemDetails *icid = [[InitCheckItemDetails alloc] init];
            [icid downloadCheckItemDetails];
            WAITFORPARSER
            InitCheckItems *icheckItems = [[InitCheckItems alloc] init];
            [icheckItems downloadCheckItems:orgID];
            WAITFORPARSER
            InitCheckType *iCheckType = [[InitCheckType alloc] init];
            [iCheckType downLoadCheckType:orgID];
            WAITFORPARSER
            InitCheckHandle *iCheckHandle = [[InitCheckHandle alloc] init];
            [iCheckHandle downLoadCheckHandle];
            WAITFORPARSER
            InitCheckReason *iCheckReason = [[InitCheckReason alloc] init];
            [iCheckReason downLoadCheckReason];
            WAITFORPARSER
            InitCheckStatus *iCheckStatus = [[InitCheckStatus alloc] init];
            [iCheckStatus downLoadCheckStatus:orgID];
            WAITFORPARSER
            InitSystype *iSystype = [[InitSystype alloc] init];
            [iSystype downloadSysType:orgID];
            WAITFORPARSER
            InitLaws *iLaws = [[InitLaws alloc] init];
            [iLaws downLoadLaws:orgID];
            WAITFORPARSER
            InitLawItems *iLawItems = [[InitLawItems alloc] init];
            [iLawItems downloadLawItems:orgID];
            WAITFORPARSER
            InitMatchLaw *iMatchLaw = [[InitMatchLaw alloc] init];
            [iMatchLaw downloadMatchLaw:orgID];
            WAITFORPARSER
            InitMatchLawDetails *iMatchLawDetails = [[InitMatchLawDetails alloc] init];
            [iMatchLawDetails downloadMatchLawDetails:orgID];
            WAITFORPARSER
            InitLawBreakingAction *iLawBreakingAction = [[InitLawBreakingAction alloc] init];
            [iLawBreakingAction downloadLawBreakingAction:orgID];
            WAITFORPARSER
            InitOrgInfo *iOrgInfo = [[InitOrgInfo alloc] init];
            [iOrgInfo downLoadOrgInfo:orgID];
            WAITFORPARSER
            InitFileCode *iFileCode = [[InitFileCode alloc] init];
            [iFileCode downLoadFileCode:orgID];
//            WAITFORPARSER
//            InitBridge *iBridge = [[InitBridge alloc] init];
//            [iBridge downloadBridge ];
        }
    }
}

- (void)parserFinished:(NSNotification *)noti{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.progressView isVisible]) {
            self.currentParserCount = self.currentParserCount-1;
            [self.progressView setProgress:(int)(((float)(-self.currentParserCount+self.parserCount)/(float)self.parserCount)*100.0)];
            
            self.stillParsing = NO;
            if (self.currentParserCount==0) {
                [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                double delayInSeconds   = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    //[self.progressView hide];
                    [ self.progressView dismissWithClickedButtonIndex:-1 animated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOADFINISHNOTI object:nil];
                    UIAlertView *finishAlert = [[UIAlertView alloc] initWithTitle:@"消息" message:@"下载完毕" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [finishAlert show];
                });
            }
        }
    });
}

@end
