//
//  BarristerUserModel.h
//  barrister
//
//  Created by 徐书传 on 16/5/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"


//address = "<null>";
//age = "<null>";
//area = "<null>";
//city = "<null>";
//email = "<null>";
//gender = "<null>";
//id = 5;
//introduction = "<null>";
//location = "<null>";
//name = "<null>";
//nickname = "<null>";
//phone = 13301096303;
//pushId = "<null>";
//state = "<null>";
//userIcon = "<null>";
//verifyCode = 388913;


@interface BarristerUserModel : BaseModel

@property (nonatomic,strong) NSString *userId;//userid

/**
 *  验证码 也就是密码
 */
@property (nonatomic,strong) NSString *verifyCode;
/**
 *  昵称
 */
@property (nonatomic,strong) NSString *nickName;

/**
 *  性别 0 男  1 女
 */
@property (nonatomic,strong) NSString *gender;

/**
 *  姓名
 */
@property (nonatomic,strong) NSString *name;

/**
 *  头像地址
 */
@property (nonatomic,strong) NSString *userIcon;

/**
 *  手机
 */
@property (nonatomic,strong) NSString *phone;

/**
 *  邮箱
 */
@property (nonatomic,strong) NSString *mail;

/**
 * 市
 */
@property (nonatomic,strong) NSString *city;

/**
 *  地区
 */
@property (nonatomic,strong) NSString *area;


/**
 *  邮箱
 */
@property (nonatomic,strong) NSString *email;

/**
 *  年龄
 */
@property (nonatomic,strong) NSString *age;

/**
 *  通信地址
 */

@property (nonatomic,strong) NSString *address;

/**
 *  推送id
 */
@property (nonatomic,strong) NSString *pushId;

/**
 *  简介
 */
@property (nonatomic,strong) NSString *introduction;

/**
 *  位置
 */
@property (nonatomic,strong) NSString *location;

@end
