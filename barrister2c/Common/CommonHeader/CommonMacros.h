//
//  CommonMacros.h
//  barrister
//
//  Created by 徐书传 on 16/6/27.
//  Copyright © 2016年 Xu. All rights reserved.
//

/**************** 消息通知 *****************/
#define NOTIFICATION_LOGIN_SUCCESS       @"LoginSuccess"

#define APPOINTMENT @"APPOINTMENT" //预约
#define IM @"IM"//即时

//    a.待处理
#define  STATUS_WAITING  @"order.status.waiting"

//    b.进行中
#define STATUS_DOING  @"order.status.doing"
//    c.已完成
#define STATUS_DONE  @"order.status.done"
//    d.已取消
#define STATUS_CANCELED  @"order.status.canceled"
//    e.退款中
#define STATUS_REFUND  @"order.status.refund"

//    f 请求取消
#define STATUS_REQUESTCANCEL @"order.status.request.cancel"



#define ISSTAR_YES 	@"isStart.yes"
#define ISSTAR_NO   @"isStart.no"


#define AUTH_STATUS_UNAUTHERIZED @"verify.status.unautherized"
#define AUTH_STATUS_SUCCESS @"verify.status.success"
#define AUTH_STATUS_FAILED @"verify.status.failed"
#define AUTH_STATUS_VERIFYING @"verify.status.verifying"

#define CARD_STATUS_NOT_BOUND  @"0";//未绑定
#define CARD_STATUS_BOUND  @"1";//已绑定




#define ORDER_STATUS_CAN   @"can"; //可以接单
#define ORDER_STATUS_NOT   @"can_not"; //不可以接单

