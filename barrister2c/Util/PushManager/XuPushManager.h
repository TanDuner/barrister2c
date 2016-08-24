//
//  XuPushManager.h
//  barrister
//
//  Created by 徐书传 on 16/7/7.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

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

/**
 *
 * 提现结果通知
 *
 */

#define Push_TYpe_Tixian_Status         @"type.getmoney"

/**
 *  收到新的预约订单
 *
 */
#define Push_Type_New_AppointmentOrder @"type.order.new"


#define Push_Type_User_Web_Auth     @"type.web.auth"

@interface XuPushManager : NSObject

@property (nonatomic,strong) NSMutableDictionary            * delegateMap;

@property (nonatomic,strong) NSDictionary                   * closePushMsg;

@property (nonatomic,strong) NSDictionary                   * backGroundPushMsg;


/**
 *  获取推送管理实例
 *
 *  @return 推送管理对象
 */
+ (XuPushManager *) shareInstance;


/**
 *  设置极光推送的别名和 tag
 *
 *  @param tag   tag
 *  @param alias 别名
 */
-(void)setJPushTags:(NSSet *)tags Alias:(NSString *)alias;


/**
 *  接收到在线push
 *
 *  @param userInfo 在线消息
 */
- (void) receivePushMsgByActive:(NSDictionary *)userInfo;

/**
 *  接受离线消息push
 *
 *  @param userInfo 离线push
 */
- (void) receivePushMsgByUnActive:(NSDictionary *)userInfo;

/**
 *  离线消息处理
 *
 */
- (void)handleUnActiveMsg;


@end
