//
//  BarristerLoginManager.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/26.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BarristerLoginManager.h"
#import "BaseNavigaitonController.h"
#import "BarristerLoginVC.h"
#import "LoginProxy.h"
#import "WebAuthViewController.h"

@interface BarristerLoginManager ()

@property (nonatomic,strong) LoginProxy *proxy;

@end

@implementation BarristerLoginManager


+ (BarristerLoginManager *)shareManager
{
    static BarristerLoginManager *staticManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        staticManager = [[self alloc] init];
    });
    
    return staticManager;
}

-(void)showLoginViewControllerWithController:(BaseViewController *)showController
{
    BarristerLoginVC *loginVC = [[BarristerLoginVC alloc] init];
    
    BaseNavigaitonController *navigationVC = [[BaseNavigaitonController alloc] initWithRootViewController:loginVC];
    
    [showController.navigationController presentViewController:navigationVC animated:YES completion:nil];

}


-(void)openWebAuthViewController;//打开web登录授权页面
{
    UIViewController *viewController = [self getCurrentVC];

    WebAuthViewController *authVC = [[WebAuthViewController alloc] init];
    
    BaseNavigaitonController *navigationVC = [[BaseNavigaitonController alloc] initWithRootViewController:authVC];
    
    [viewController presentViewController:navigationVC animated:YES completion:nil];

}



- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}



-(void)userAutoLogin
{
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSString *verfyCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"verifyCode"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:phone,@"phone",verfyCode,@"verifyCode", nil];
    [self.proxy loginWithParams:params Block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            if (dict && [dict respondsToSelector:@selector(objectForKey:)]) {
                NSDictionary *userDict = [dict objectForKey:@"user"];
                if ([userDict respondsToSelector:@selector(objectForKey:)]) {
                    BarristerUserModel *user = [[BarristerUserModel alloc] initWithDictionary:userDict];
                    [BaseDataSingleton shareInstance].userModel = user;
                    [[BaseDataSingleton shareInstance] setLoginStateWithValidCode:user.verifyCode Phone:user.phone];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESS object:nil];
                }
                
            }
            
        }
        else
        {
            /**
             *  登录失败 清空用户信息
             */
            
//            [[BaseDataSingleton shareInstance] clearUserInfo];
        }
    }];
}

#pragma -mark ---Getter---

-(LoginProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[LoginProxy alloc] init];
    }
    return _proxy;
}



@end
