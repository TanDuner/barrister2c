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
#import "BarristerLoginManager.h"
#import "CaseOrderDetailViewController.h"
#import <UMSocialCore/UMSocialManager.h>

//13301096303
//700953

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//在这里写针对iOS10的代码或者引用新的API
#import <UserNotifications/UserNotifications.h>

#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

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

    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"577b216967e58e8175000689"];

    //weixin
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx719e35ccbca02039" appSecret:@"8aac25361765227616fed5718daa3653" redirectURL:@"http://mobile.umeng.com/social"];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105336139" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2086685069"  appSecret:@"f38cba7eb06b85187d79ac6a09fef0a7" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    
    
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
    
    NSDictionary *remoteDic = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteDic) {
        NSLog(@"%@",[[remoteDic objectForKey:@"aps"] objectForKey:@"alert"]);
        
        [[XuPushManager shareInstance] receivePushMsgByUnActive:remoteDic];
    }
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerJPushFInish) name:kJPFNetworkDidLoginNotification object:nil];
    
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //Required
    // init Push(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil  )
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey channel:@"App Store" apsForProduction:YES];

    
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
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return result;

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        //    如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
        }
        else
        {
            return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        }
    }
    
    return result;

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
    
    else if ([type isEqualToString:Push_Type_TYPE_ONLINE_ORDER])
    {
        //线上专项服务订单
        NSString *contentId = [params objectForKey:@"contentId"];

        CaseOrderDetailViewController *orderDetailVC = [[CaseOrderDetailViewController alloc] init];
        orderDetailVC.orderId = contentId;
        
        [navigationController pushViewController:orderDetailVC animated:YES];

    }
    
    else if ([type isEqualToString:Push_Type_Order_Receive_Reward]||[type isEqualToString:Push_Type_Order_Receive_Moneny]||[type isEqualToString:Push_TYpe_Tixian_Status]||[type isEqualToString:@"type.recharge"])
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
    }//网页授权
    else if ([type isEqualToString:Push_Type_User_Web_Auth])
    {
        [[BarristerLoginManager shareManager] openWebAuthViewController];
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


#pragma mark- JPUSHRegisterDelegate

#ifdef NSFoundationVersionNumber_iOS_9_x_Max

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [[XuPushManager shareInstance] receivePushMsgByActive:userInfo];
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [[XuPushManager shareInstance] receivePushMsgByActive:userInfo];
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

#endif


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [[XuPushManager shareInstance] receivePushMsgByActive:userInfo];

    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
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
