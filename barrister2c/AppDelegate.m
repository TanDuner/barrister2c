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
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import "JPUSHService.h"
#import "XuPushManager.h"

//13301096303
//700953

@interface AppDelegate ()

@property (nonatomic,strong) YKSplashView *splashView;

@property (nonatomic,strong) UIViewController *guideController;

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
    
    if (![YKSplashView getIsOpenGuideView]) {
        self.window.rootViewController = self.guideController;
        [self.window makeKeyAndVisible];
    }
    else
    {
        [self createTabbar];

    }

}

-(void)createTabbar
{
    self.window.rootViewController = self.tabBarCTL;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}


//更换rootViewController

- (void)resetRootViewController:(UIViewController *)rootViewController WithBlock:(void(^)())block
{
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:^(BOOL finished) {
                        if (finished) {
                            block();
                        }
                    }];
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

-(void)initCallAction
{
    CTCallCenter *callCenter = [[CTCallCenter alloc] init];
    callCenter.callEventHandler = ^(CTCall* call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            NSLog(@"Call has been disconnected");
        }
        else if ([call.callState isEqualToString:CTCallStateConnected])
        {
            NSLog(@"Call has just been connected");
        }
        else if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
        }
        else if ([call.callState isEqualToString:CTCallStateDialing])
        {
            NSLog(@"call is dialing");
        }
        else
        {
            NSLog(@"Nothing is done");
        }
    };
    
}

/**
 *  初始化极光的环境 push 相关
 *
 *
 */

-(void)initJPushWithLaunchOptions:(NSDictionary  *)launchOptions
{
    /**
     *  注册极光push
     */
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                      UIRemoteNotificationTypeSound |
                                                      UIRemoteNotificationTypeAlert)
                                          categories:nil];
    
    
    NSDictionary *remoteDic = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteDic) {
        NSLog(@"%@",[[remoteDic objectForKey:@"aps"] objectForKey:@"alert"]);
        
        [[XuPushManager shareInstance] receivePushMsgByUnActive:remoteDic];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey channel:@"App Store" apsForProduction:NO];
    
    [[XuPushManager shareInstance] setJPushTags:[NSSet set] Alias:@"xxxx"];
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initCallAction];
    
    [self initUMData];
    
    [self initJPushWithLaunchOptions:launchOptions];
    
    [self initControllersAndConfig];
    
    
    [self initNetWorkingData];
   
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
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


#pragma -mark ---Getter---

-(UIViewController *)guideController
{
    if (!_guideController) {
        _guideController = [[UIViewController alloc] init];
        [_guideController.view addSubview:self.splashView];
    }
    return _guideController;
}

-(YKSplashView *)splashView
{
    if (!_splashView) {
        _splashView = [[YKSplashView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    }
    return _splashView;
}


-(BaseTabbarController *)tabBarCTL
{
    if (!_tabBarCTL) {
        _tabBarCTL = [[BaseTabbarController alloc] init];
    }
    return _tabBarCTL;
}
@end
