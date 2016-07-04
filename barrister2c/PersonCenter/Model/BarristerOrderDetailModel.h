//
//  BarristerOrderDetailModel.h
//  barrister
//
//  Created by 徐书传 on 16/6/28.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

#import "CallHistoriesModel.h"


//callHistories =     (
//                     {
//                         callId = 160703094951880900010298005400cf;
//                         duration = 0;
//                         orderId = 20;
//                         recordUrl = "<null>";
//                         startTime = "2016-07-03 09:49:51";
//                     },
//                     {
//                         callId = 1607030134462099000100570064cf9f;
//                         duration = 0;
//                         orderId = 20;
//                         recordUrl = "<null>";
//                         startTime = "2016-07-03 01:34:27";
//                     }
//                     );
//caseType = "<null>";
//customerIcon = "http://119.254.167.200:8080/upload/2016/06/28/1467105926033.jpg";
//customerId = 3;
//customerNickname = "<null>";
//customerPhone = 13671057132;
//endTime = "<null>";
//id = 20;
//lawFeedback = "<null>";
//payTime = "2016-07-03 01:34:26";
//paymentAmount = 30;
//remarks = "hello \U6d4b\U8bd5";
//startTime = "2016-07-03 01:34:26";
//status = "order.status.waiting";
//type = IM;
//userIcon = "http://119.254.167.200:8080/upload/2016/06/28/1467105926033.jpg";




@interface BarristerOrderDetailModel : BaseModel

@property (nonatomic,strong) NSMutableArray *callRecordArray;
@property (nonatomic,strong) NSString *caseType;
@property (nonatomic,strong) NSString *customerIcon;
@property (nonatomic,strong) NSString *customerNickname;
@property (nonatomic,strong) NSString *customerPhone;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *payTime;
@property (nonatomic,strong) NSString *paymentAmount;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *lawFeedback;

@property (nonatomic,strong) NSString *userIcon;
@property (nonatomic,assign) CGFloat markHeight;

@property (nonatomic,assign) CGFloat lawyerFeedBackHeight;

@end
