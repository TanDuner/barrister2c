//
//  YingShowUserModel.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"




static  NSString * TYPE_CREDIT = @"credit";//债权人
static  NSString *TYPE_DEBT = @"debt";//债务人
//
//String id;
//String type;
//String company;//单位
//String name;//姓名(个人)
//String address;//联系地址
//String phone;//个人电话
//String companyPhone;//公司电话
//String licenseNuber;//信用代码
//String ID_number;//身份证号码


@interface YingShowUserModel : BaseModel

@property (nonatomic,strong) NSString *yingShowUserId;

@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSString *company;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *phone;

@property (nonatomic,strong) NSString *companyPhone;

@property (nonatomic,strong) NSString *liceseeNuber;

@property (nonatomic,strong) NSString *ID_number;

@property (nonatomic,assign) CGFloat companyNameHeight;

@property (nonatomic,assign) CGFloat addressHeight;

@property (nonatomic,assign) CGFloat cellHeight;


@end
