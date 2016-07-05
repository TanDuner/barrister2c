//
//  AppDelegate.m
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "AppDelegate.h"
#import "XuNetWorking.h"
#import "OpenUDID.h"
#import "YKSplashView.h"
#import "UMMobClick/MobClick.h"

//13301096303
//700953

@interface AppDelegate ()

@property (nonatomic,strong) YKSplashView *splashView;

@end

@implementation AppDelegate
/**
 *  选择tab 的Index
 *
 *  @param index 序号
 */

-(void)selectTabWithIndex:(NSInteger)index
{
    _tabBarCTL.selectedIndex = index;
}

-(void)initControllersAndConfig
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    if (![YKSplashView getIsOpenGuideView]) {
//        UIViewController *vc = [[UIViewController alloc] init];
//        self.window.rootViewController = vc;
//        YKSplashView *gudeView = [[YKSplashView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,SCREENHEIGHT)];
//        self.splashView = gudeView;
//        [self.window addSubview:self.splashView];
//        [self.window makeKeyAndVisible];
//    }
//    else
//    {
        [self createTabbar];

//    }
    
}

-(void)createTabbar
{
    _tabBarCTL = [[BaseTabbarController alloc] init];
    self.window.rootViewController = _tabBarCTL;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

-(void)initNetWorkingData
{
    [XuNetWorking updateBaseUrl:BaseUrl];
    
    NSMutableDictionary *headerDict = [NSMutableDictionary dictionary];
    [headerDict setObject:[OpenUDID value] forKey:@"X-DEVICE-NUM"];
    [headerDict setObject:[NSString stringWithFormat:@"ios-%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]] forKey:@"X-VERSION"];
    [headerDict setObject:[[UIDevice currentDevice] model] forKey:@"X-TYPE"];
    [headerDict setObject: @"ios" forKey:@"X-SYSTEM"];
    [headerDict setObject:[XuUtlity getIOSVersion] forKey:@"X-SYSTEM-VERSION"];
    [headerDict setObject:[NSString stringWithFormat:@"%f*%f",SCREENWIDTH ,SCREENHEIGHT] forKey:@"X-SCREEN"];
    [headerDict setObject:@"appleStore" forKey:@"X-MARKET"];
    if ([BaseDataSingleton shareInstance].userModel != nil) {
        [headerDict setObject:[BaseDataSingleton shareInstance].userModel.userId forKey:@"X-UID"];
    }
    
    
    [XuNetWorking configCommonHttpHeaders:headerDict];
    
    //打开debug开关
    [XuNetWorking enableInterfaceDebug:YES];
}



-(void)initUMData
{
    UMConfigInstance.appKey = @"577b216967e58e8175000689";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.appKey = @"577b216967e58e8175000689";
    [MobClick startWithConfigure:UMConfigInstance];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    [self initUMData];
    
    [self initControllersAndConfig];
    
    
    [self initNetWorkingData];
   
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
