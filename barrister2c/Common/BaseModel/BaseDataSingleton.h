//
//  BaseDataSingleton.h
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BarristerUserModel.h"

struct PhoneSate {
    BOOL isopensound;
    BOOL isopenvibrate;
};
typedef struct PhoneSate PhoneSate;



@interface BaseDataSingleton : NSObject

@property (nonatomic,assign) PhoneSate currentPhoneState;

@property (nonatomic,assign) NSString * loginState; //是否登录 //1 登录 0 未登录

@property (nonatomic,strong) NSString *remainingBalance;//余额

@property (nonatomic,strong)BarristerUserModel *userModel; //用户

@property (nonatomic,strong) NSString *bankCardBindStatus;//绑定银行卡的状态

@property (nonatomic,strong) NSDictionary *bankCardDict;//银行卡的字典

@property (nonatomic,strong) NSString *totalConsume;//累计消费

@property (nonatomic,strong) NSMutableArray *bizAreas;//领域

@property (nonatomic,strong) NSMutableArray *bizTypes;//类型


+ (instancetype)shareInstance;

-(void)setLoginStateWithValidCode:(NSString *)validCode Phone:(NSString *)phone;

/**
 *  注销清空用户信息
 */
-(void)clearUserInfo;

@end
