//
//  ShareCosumeModel.h
//  barrister2c
//
//  Created by 徐书传 on 17/5/6.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "BaseModel.h"


//{"items":[{"consumeTime":"2016-12-01 10:08:03","consumerId":202,"consumerName":null,"consumerPhone":"17301249544","money":25.0,"registerTime":"2016-11-08 15:43:47"}],"page":1,"pageSize":20,"resultCode":200,"resultMsg":"成功","total":1,"totalMoney":25.0,"userId":3,"verifyCode":"273698"}

@interface ShareCosumeModel : BaseModel

@property (strong, nonatomic) NSString *consumeTime;
@property (strong, nonatomic) NSString *consumerId;
@property (strong, nonatomic) NSString *consumerName;
@property (strong, nonatomic) NSString *consumerPhone;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *registerTime;
@end
