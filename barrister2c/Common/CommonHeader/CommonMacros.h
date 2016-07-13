//
//  CommonMacros.h
//  barrister
//
//  Created by 徐书传 on 16/6/27.
//  Copyright © 2016年 Xu. All rights reserved.
//

#pragma mark - SDK宏定义
//////////////////////////支付宝//////////////////////////////
#define AlipayPARTNER           @""
#define AlipaySELLER            @""
#define AlipayRSA_PRIVATE       @""
#define AlipayRSA_ALIPAY_PUBLIC @""
//获取服务器端支付数据地址（商户自定义）
#define AlipayBackURL           @""


//////////////////////////微信//////////////////////////////
#define WeChatAppID             @"wx719e35ccbca02039"
#define WeChatAppSecret         @"8aac25361765227616fed5718daa3653"
//商户号，填写商户对应参数
#define WeChatMCH_ID                  @""
//商户API密钥，填写相应参数
#define WeChatPARTNER_ID              @""
//支付结果回调页面
#define WeChatNOTIFY_URL              @""


//////////////////////////极光//////////////////////////////

#define JPushKey  @"f802f6cf4892280c2a542731"
#define JPushSecret @"95eb17fa4f1257dc04c9a455"


/**************** 消息通知 *****************/
#define NOTIFICATION_LOGIN_SUCCESS       @"LoginSuccess"
#define NOTIFICATION_LOGOUT_SUCCESS       @"logoutSuccess"

#define NOTIFICATION_PLAY_VOICE         @"playVoice"
#define NOTIFICATION_PLAY_VOICE_FINISH        @"playVoice_finish"
#define NOTIFICATION_WXPAY_RESULT              @"wechatPayResultNotification"
#define NOTIFICATION_ALIPAY_RESULT              @"aliPayResultNotification"
#define NOTIFICATION_PAYSWITCH_NOTIFICATION   @"payop"



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



#define TYPE_ORDER  @"income.type.order"// 订单
#define TYPE_GET_MONEY  @"income.type.getmoney"// 提现
#define TYPE_REWARD  @"income.type.reward"// 打赏
#define TYPE_RECHARGE  @"consume.type.recharge"// 充值
#define TYPE_BACK  @"consume.type.back"// 退钱


#define ORDER_STATUS_CAN   @"can"; //可以接单
#define ORDER_STATUS_NOT   @"can_not"; //不可以接单

