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
#import "WXApi.h"
#import "WXApiManager.h"
#import "IMVersionManager.h"

#import "BaseViewController.h"
#import "BaseNavigaitonController.h"
#import "OrderDetailViewController.h"
#import "MyAccountViewController.h"
#import "MyMessageViewController.h"
#import <AlipaySDK/AlipaySDK.h>

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
        //初始化版本控制
        [IMVersionManager shareInstance];
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
        [headerDict setObject:[NSString stringWithFormat:@"%@",[BaseDataSingleton shareInstance].userModel.userId] forKey:@"X-UID"];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerJPushFInish) name:kJPFNetworkDidLoginNotification object:nil];
    
}

-(void)registerJPushFInish
{
    [self initNetWorkingData];
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initCallAction];
    
    [self initUMData];
    
    [self initJPushWithLaunchOptions:launchOptions];
    
    [self initControllersAndConfig];
    
    [WXApi registerApp:WeChatAppID withDescription:@"barrister"];
    
    [self initNetWorkingData];
   
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSString *message = @"";
            switch([[resultDic objectForKey:@"resultStatus"] integerValue])
            {
                case 9000:message = @"订单支付成功";break;
                case 8000:message = @"正在处理中";break;
                case 4000:message = @"订单支付失败";break;
                case 6001:message = @"用户中途取消";break;
                case 6002:message = @"网络连接错误";break;
                default:message = @"未知错误";
            }
            
            UIAlertController *aalert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
            [aalert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
            UIViewController *root = self.window.rootViewController;
            [root presentViewController:aalert animated:YES completion:nil];
            
            NSLog(@"result = %@",resultDic);
        }];
    }
    else
    {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}


-(void)jumpToViewControllerwithType:(NSString *)type Params:(NSDictionary *)params;
{
    
    BaseTabbarController *mainTabVC = self.tabBarCTL;
    BaseNavigaitonController * navigationController = [mainTabVC.viewControllers objectAtIndex:mainTabVC.selectedIndex];
    
    
    if ([type isEqualToString:Push_Type_Order_Status_Change]||[type isEqualToString:Push_Type_Receive_Star]||[type isEqualToString:Push_Type_New_AppointmentOrder]) {
        NSString *contentId = [params objectForKey:@"contentId"];
        
        OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] initWithOrderId:contentId];
        [navigationController pushViewController:detailVC animated:YES];
    }
    else if ([type isEqualToString:Push_Type_Order_Receive_Reward]||[type isEqualToString:Push_Type_Order_Receive_Moneny]||[type isEqualToString:Push_TYpe_Tixian_Status])
    {
        //去我的账户
        MyAccountViewController *account = [[MyAccountViewController alloc] init];
        [navigationController pushViewController:account animated:YES];
        
    }
    else if ([type isEqualToString:Push_Type_System_Msg])
    {
        //去系统消息
        MyMessageViewController *myMessage = [[MyMessageViewController alloc] init];
        [navigationController pushViewController:myMessage animated:YES];
        
    }
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [[XuPushManager shareInstance] receivePushMsgByActive:userInfo];

    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    [[XuPushManager shareInstance] receivePushMsgByActive:userInfo];
//    // IOS 7 Support Required
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}

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
