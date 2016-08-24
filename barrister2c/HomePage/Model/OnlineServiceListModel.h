//
//  OnlineServiceListModel.h
//  barrister2c
//
//  Created by 徐书传 on 16/8/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface OnlineServiceListModel : BaseModel

//String id;
//String name;//姓名
//String icon;//头像
//String qq;//qq
//String intro;//简介
//String phone;//电话

@property (nonatomic,strong) NSString *onlineId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *qq;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *phone;

@property (nonatomic,assign) CGFloat introContentHeight;

@end
