//
//  BarristerOrderModel.h
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//


/**
 *  订单model 公共Model
 */

#import "BaseModel.h"


typedef NS_ENUM(NSInteger, BarristerOrderType)
{
    BarristerOrderTypeJSZX,
    BarristerOrderTypeYYZX,
};


typedef NS_ENUM(NSInteger, BarristerOrderState)
{
    BarristerOrderStateFinished,
    BarristerOrderStateCanceled,
    BarristerOrderStateClosed,
    BarristerOrderStateWaiting,
    BarristerOrderStateRefund,
};




@interface BarristerOrderModel : BaseModel

@property (nonatomic,strong) NSString *customerName;

@property (nonatomic,strong) NSString *orderNo;//订单号

@property (nonatomic,strong) NSString *orderId;//订单id

@property (nonatomic,assign) BarristerOrderType orderType;//订单类型

@property (nonatomic,strong) NSString *caseType;//案源类型

@property (nonatomic,assign) BarristerOrderState orderState ;//订单状态

@property (nonatomic,strong) NSString *orderPrice;//订单价格

@property (nonatomic,strong ) NSString *userId;//

@property (nonatomic,strong) NSString *startTime;//开始时间

@property (nonatomic,strong) NSString *endTime;//结束时间

@property (nonatomic,strong) NSString *orderTime;//订单下单时间

@property (nonatomic,strong) NSString *userHeder;//用户头像

@property (nonatomic,strong) NSString *markStr;//医生备注的内容

@property (nonatomic,assign) CGFloat markHeight;//备注区域的高度

@property (nonatomic,strong) NSString *voiceUrl;//录音的链接

@property (nonatomic,strong) NSString *customPhone;//用户的手机号

@property (nonatomic,strong) NSString *talkTime;//通话时长

@end
