//
//  CallHistoriesModel.h
//  barrister
//
//  Created by 徐书传 on 16/7/3.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface CallHistoriesModel : BaseModel


@property (nonatomic,strong) NSString *callId;
@property (nonatomic,strong) NSString *duration;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSMutableArray *recordUrl;
@property (nonatomic,strong) NSString *startTime;
@end
