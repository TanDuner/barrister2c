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

@property (nonatomic,strong) NSString *userId;

@property (nonatomic,strong) NSString *userIcon;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,assign) float rating;

@property (nonatomic,assign) NSInteger recentServiceTimes;

@property (nonatomic,strong) NSString *area;

@property (nonatomic,strong) NSString *company;

@property (nonatomic,strong) NSString *workingStartYear;

@property (nonatomic,strong) NSString *goodAt;

@property (nonatomic,strong) NSString *introduceStr;

@property (nonatomic,strong) NSString *workYears;//工作年限

@property (nonatomic,assign) BOOL isShowAll;

@property (nonatomic,assign) CGFloat showAllIntroduceViewHeight; //展示全部的高度

@property (nonatomic,assign) CGFloat showIntroduceViewHeight; //展示全部的高度

@property (nonatomic,assign) CGFloat introducestrHeight;

@property (nonatomic,assign) CGFloat allIntroduceStrHeight;

@property (nonatomic,assign) NSInteger appraiseCount;//收到的评价数量

@property (nonatomic,assign) BOOL isNeedShowAll;


-(void)handleProprety;


@end
