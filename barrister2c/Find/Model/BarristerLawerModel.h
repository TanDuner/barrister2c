//
//  BarristerLawerModel.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"


//String id;
//String userIcon;//头像
//String name;//姓名
//float rating;//评分
//int recentServiceTimes;//最近服务次数
//String area;
//String company;//律所
//String workingStartYear;//工作开始时间（yyyy-MM-dd），根据这个时间计算工作年限
//String goodAt;//擅长领域

@interface BarristerLawerModel : BaseModel

@property (nonatomic,strong) NSString *laywerId;

@property (nonatomic,strong) NSString *userIcon;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *rating;

@property (nonatomic,assign) NSInteger recentServiceTimes;

@property (nonatomic,strong) NSString *area;

@property (nonatomic,strong) NSString *company;

@property (nonatomic,strong) NSString *workingStartYear;

@property (nonatomic,strong) NSString *intro;

@property (nonatomic,strong) NSString *workYears;//工作年限

@property (nonatomic,assign) BOOL isShowAll;

@property (nonatomic,assign) CGFloat showAllIntroduceViewHeight; //展示全部的高度

@property (nonatomic,assign) CGFloat showIntroduceViewHeight; //展示全部的高度

@property (nonatomic,assign) CGFloat introducestrHeight;

@property (nonatomic,assign) CGFloat allIntroduceStrHeight;

@property (nonatomic,assign) NSInteger appraiseCount;//收到的评价数量

@property (nonatomic,assign) BOOL isNeedShowAll;

@property (nonatomic,strong) NSString *priceAppointment;//预约的每个时间段的价格

@property (nonatomic,strong) NSString *priceIM;//即时咨询价格


@property (nonatomic,strong) NSString * isCollect;//是否收藏

@property (nonatomic,strong) NSString *goodAtStr; //擅长的字符串


@property (nonatomic,strong) NSString *orderStatus; //可接单状态  can  can_not

/**
 *  擅长领域
 */

@property (nonatomic,strong) NSMutableArray *bizAreaList;

/**
 *  擅长类型
 */
@property (nonatomic,strong) NSMutableArray *bizTypeList;


//是否是专家  0不是 1 是
@property (nonatomic,strong) NSString *isExpert;

//扣扣
@property (nonatomic,strong) NSString *secretaryQQ;

//电话
@property (nonatomic,strong) NSString *secretaryPhone;

@end
