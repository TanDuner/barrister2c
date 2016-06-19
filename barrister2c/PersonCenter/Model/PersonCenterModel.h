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
    PersonCenterModelTypeZH,//账号
    PersonCenterModelTypeSC,//收藏
    PersonCenterModelTypeZHU,//账户
    PersonCenterModelTypeDD,//我的订单
    PersonCenterModelTypeXX,//消息
    PersonCenterModelTypeRZZT,//认证状态
    PersonCenterModelTypeJDSZ,//接单设置
    PersonCenterModelTypeSZ,//设置
    PersonCenterModelTypeInfoTX,//个人信息界面 头像
    PersonCenterModelTypeInfoCommon,//个人信息界面 通用 左边title 右边subtitle 箭头
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

@end
