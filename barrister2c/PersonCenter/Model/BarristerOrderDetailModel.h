//
//  BarristerOrderDetailModel.h
//  barrister
//
//  Created by 徐书传 on 16/6/28.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

#import "CallHistoriesModel.h"


//barristerIcon = "http://119.254.167.200:8080/upload/2016/06/26/1466942987875userIcon";
//barristerId = 5;
//barristerNickname = "\U53d9\U8ff0\U7a7f";
//barristerPhone = 13301096303;
//callHistories = "<null>";
//caseType = "<null>";
//customerIcon = "<null>";
//customerId = "<null>";
//customerNickname = "<null>";
//customerPhone = "<null>";
//endTime = "2016-07-03 09:30:00";
//id = 25;
//isStart = "isStart.no";
//lawFeedback = "<null>";
//orderNo = "<null>";
//payTime = "2016-07-03 15:36:29";
//paymentAmount = 50;
//remarks = 1;
//startTime = "2016-07-03 09:00:00";
//status = "order.status.waiting";
//type = APPOINTMENT;



@interface BarristerOrderDetailModel : BaseModel

@property (nonatomic,strong) NSString *barristerIcon;
@property (nonatomic,strong) NSString *barristerId;
@property (nonatomic,strong) NSString *barristerNickname;
@property (nonatomic,strong) NSString *barristerPhone;
@property (nonatomic,strong) NSString *caseType;
@property (nonatomic,strong) NSString *customerIcon;
@property (nonatomic,strong) NSString *customerId;
@property (nonatomic,strong) NSString *customerNickname;
@property (nonatomic,strong) NSString *customerPhone;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *isStart;
@property (nonatomic,strong) NSString *lawFeedback;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,strong) NSString *payTime;
@property (nonatomic,strong) NSString *paymentAmount;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSMutableArray *callRecordArray;


@property (nonatomic,strong) NSString *userIcon;
@property (nonatomic,assign) CGFloat markHeight;

@property (nonatomic,assign) CGFloat lawyerFeedBackHeight;

@property (nonatomic,strong) NSString *comment;//用户评论

@property (nonatomic,assign) CGFloat customCommonHeight;


@end
