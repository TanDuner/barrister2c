//
//  XuPushManager.m
//  barrister
//
//  Created by 徐书传 on 16/7/7.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "XuPushManager.h"
#import "JPUSHService.h"

/**
 *
 * 订单状态改变 跳转到我订单详情
 */
#define Push_Type_Order_Status_Change   @"type.order.status.changed"

/**
 *
 * 收到评价 跳转到订单详情
 */
#define Push_Type_Receive_Star          @"type.receive.star"

/**
 *
 * 收到订单费用
 */
#define Push_Type_Order_Receive_Moneny  @"type.receive.order.money"

/**
 *
 * 收到打赏
 */

#define Push_Type_Order_Receive_Reward  @"type.receive.order.reward"

/**
 *
 *  系统通知
 */

#define Push_Type_System_Msg            @"type.system.msg"

/**
 *
 *  认证状态改变
 */

#define Push_Type_Auth_Status_Change    @"type.verify.msg"


@implementation XuPushManager


- (id) init
{
    self = [super init];
    
    if(self)
    {
        [self initData];
    }
    
    return self;
}

- (void) initData
{
    _delegateMap = [[NSMutableDictionary alloc] initWithCapacity:0];
}


+ (XuPushManager *) shareInstance
{
    static XuPushManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XuPushManager alloc] init];
    });
    
    return instance;
}


-(void)setJPushTags:(NSSet *)tags Alias:(NSString *)alias;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService setTags:[NSSet set] alias:@"xxxx" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSLog(@"%d---别名-------%@---",iResCode,iAlias);
            
        }];
    });
}

- (void) receivePushMsgByActive:(NSDictionary *)userInfo
{
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        _backGroundPushMsg = userInfo;
        [self dispatchPushMsgByActive];
    }else if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        
    }else{
        NSLog(@"drop active push msgs:%@",userInfo);
    }
}


/**
 *  分发后台push 消息
 */
-(void)dispatchPushMsgByActive
{
    if (!_backGroundPushMsg) {
        
        return ;
    }
    
    [self performSelector:@selector(sendPushMsg) withObject:nil afterDelay:0.1];
    
}

//发送push 消息
-(void)sendPushMsg
{
    
    [self receivePushMsg: _backGroundPushMsg withType:[_backGroundPushMsg objectForKey:@"type"]];
    _backGroundPushMsg = nil;

}



/**
 *  接受关闭情况下push
 *
 *  @param userInfo
 */
- (void) receivePushMsgByUnActive:(NSDictionary *)userInfo
{
    
    _closePushMsg = userInfo;
}


/**
 *  处理离线消息
 */
- (void)handleUnActiveMsg
{
    if (!_closePushMsg) {
        return;
    }
    [self receivePushMsg:_closePushMsg withType:[_closePushMsg objectForKey:@"type"]];
    _closePushMsg = nil;
}


/**
 *  最终消息处理点
 *
 *  @param pushdata  push 数据
 *  @param type     类型
 */
- (void)receivePushMsg:(NSDictionary *)pushdata withType:(NSString *)type
{
    
    if ([type isEqualToString:Push_Type_Auth_Status_Change]) {
        
        
    } else if ([type isEqualToString:Push_Type_Order_Receive_Moneny]) {
        
        

    } else if ([type isEqualToString:Push_Type_Order_Receive_Reward]) {
        
    }
    

}


@end
