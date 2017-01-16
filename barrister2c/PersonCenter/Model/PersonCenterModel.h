//
//  PersonCenterModel.h
//  barrister
//
//  Created by 徐书传 on 16/3/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, PersonCenterModelType)
{
    PersonCenterModelTypeZH = 0,//账号
    PersonCenterModelTypeSC = 1,//收藏
    PersonCenterModelTypeZHU = 2,//账户
    PersonCenterModelTypeDD = 3,//我的订单
    PersonCenterModelTypeXX = 4,//消息
    PersonCenterModelTypeSZ = 5,//设置
    PersonCenterModelTypeInfoTX = 6,//个人信息界面 头像
    PersonCenterModelTypeInfoNickName = 7,//姓名
    PersonCenterModelTypeInfoPhone = 8,//手机
    PersonCenterModelTypeInfoGender = 9,//性别
    PersonCenterModelTypeInfoArea = 10,//地区
    
    PersonCenterModelTypeQiuZhu = 11,//我要求助
    
    PersonCenterModelTypeYSSC = 12,//应收账款上传
    PersonCenterModelTypeYSGM = 13,//应收账款购买
    PersonCenterModelTypeTJHY = 14 //分享给好友
    
};

typedef void (^ModelActionBlock)(NSInteger PersonCenterModelType);

@interface PersonCenterModel : BaseModel

@property (nonatomic,strong) NSString *iconNameStr;
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *subtitleStr;
@property (nonatomic,assign) BOOL isShowArrow;
@property (nonatomic,assign) BOOL isAccountLogin;
@property (nonatomic,strong) ModelActionBlock actionBlock;
@property (nonatomic,assign) PersonCenterModelType cellType;
@property (nonatomic,strong) UIImage *headImage;
@property (nonatomic,strong) NSString *headImageUrl;


/**
 *  for 个人资料页面 头像回显
 */

@property (nonatomic,strong) NSString *userIcon;


@end
