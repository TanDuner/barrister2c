//
//  BaseDataSingleton.m
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseDataSingleton.h"

@implementation BaseDataSingleton

+ (instancetype)shareInstance
{
    static BaseDataSingleton *dataSingleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSingleTon = [[self alloc] init];
    });
    
    return dataSingleTon;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.remainingBalance = @"300";
        self.loginState = @"0";
    }
    return self;
}


-(void )getLoginState
{
    NSString *validCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"verifyCode"];
    NSString *loginState = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginState"];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    self.userModel.verifyCode = validCode;
    self.loginState = loginState;
    self.userModel.phone = phone;
}

-(void)setLoginStateWithValidCode:(NSString *)validCode Phone:(NSString *)phone
{
    self.loginState = @"1";
    self.userModel.verifyCode = validCode;
    [[NSUserDefaults standardUserDefaults] setObject:validCode forKey:@"verifyCode"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"loginState"];
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)clearUserInfo
{
    self.loginState = @"0";
    self.userModel = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"verifyCode"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginState"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end
