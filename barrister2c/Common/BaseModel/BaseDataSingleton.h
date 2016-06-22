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

@property (nonatomic,assign) BOOL isAccountLogin; //是否登录

@property (nonatomic,strong) NSString *remainingBalance;//余额

@property (nonatomic,strong) NSString *cost;//总收入

@property (nonatomic,strong)BarristerUserModel *userModel; //用户


+ (instancetype)shareInstance;

@end
