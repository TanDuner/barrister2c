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



//caseType = "<null>";
//date = "2016-07-03 00:47:02";
//endTime = "2016-07-03 09:00:00";
//id = 19;
//name = "\U53d9\U8ff0\U7a7f";
//phone = 13301096303;
//startTime = "2016-07-03 08:30:00";
//status = "order.status.waiting";
//type = APPOINTMENT;
//userIcon = "http://119.254.167.200:8080/upload/2016/06/26/1466942987875userIcon";


@interface BarristerOrderModel : BaseModel

@property (nonatomic,strong) NSString *caseType;//案源类型
@property (nonatomic,strong) NSString *date;//日期
@property (nonatomic,strong) NSString *startTime;//开始时间
@property (nonatomic,strong) NSString *endTime;//结束时间
@property (nonatomic,strong) NSString *orderId;//订单id
@property (nonatomic,strong) NSString *name;//律师姓名
@property (nonatomic,strong) NSString *phone;//律师手机号
@property (nonatomic,strong) NSString * status;//订单状态
@property (nonatomic,strong) NSString * type;//订单类型
@property (nonatomic,strong) NSString *userIcon;//律师头像


@property (nonatomic,strong) NSString *payStatus;//支付状态 专门为线上专项服务
@property (nonatomic,strong) NSString *qq;
@property (nonatomic,strong) NSString *paymentAmount;


@property (nonatomic,strong) NSString *customerName;

@property (nonatomic,strong) NSString *orderNo;//订单号
@property (nonatomic,strong) NSString *orderPrice;//订单价格
@property (nonatomic,strong ) NSString *userId;//

@property (nonatomic,strong) NSString *userHeder;//用户头像

@property (nonatomic,strong) NSString *markStr;//律师备注的内容

@property (nonatomic,assign) CGFloat markHeight;//备注区域的高度

@property (nonatomic,strong) NSString *voiceUrl;//录音的链接

@property (nonatomic,strong) NSString *customPhone;//用户的手机号

@property (nonatomic,strong) NSString *talkTime;//通话时长


@property (nonatomic,strong) NSString *payCount;//支付金额;

@end
