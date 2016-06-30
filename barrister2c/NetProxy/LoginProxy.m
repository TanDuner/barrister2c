//
//  LoginProxy.m
//  barrister
//
//  Created by 徐书传 on 16/5/16.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LoginProxy.h"



#define GetValidCodeUrl @"getVerifyCode.do"
#define LoginUrl  @"login.do"
#define LogoutUrl @"logout.do"


@implementation LoginProxy

-(void)loginWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:LoginUrl params:params success:^(id response) {
        NSString  *resultCode = [response objectForKey:@"resultCode"];
        NSString *resultMsg = [response objectForKey:@"resultMsg"];
        if (aBlock) {
            if (resultCode.intValue == 200) {
                aBlock(response,YES);
            }
            else
            {
                aBlock(resultMsg,NO);
            }
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(@"网络有问题，稍后重试",NO);
        }
    }];
}


-(void)loginOutWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:LogoutUrl params:params success:^(id response) {
        if (aBlock) {
            aBlock(response,YES);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
    }];
}

-(void)getValidCodeWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:GetValidCodeUrl params:params success:^(id response) {
        if (aBlock) {
            aBlock(response,YES);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];
}


@end
