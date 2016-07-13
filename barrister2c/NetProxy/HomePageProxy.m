//
//  HomePageProxy.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "HomePageProxy.h"

#define HomePageDataUrl @"appHome.do"
#define GetSwitchUrl @"getLatestVersion.do"
@implementation HomePageProxy

/**
 *  获取首页全部数据接口
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理Block
 */

-(void)getHomePageDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:HomePageDataUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(CommonNetErrorTip,NO);
        }
    } fail:^(NSError *error) {
        aBlock(CommonNetErrorTip,NO);
    }];
}




/**
 *  获取开关数据
 *
 *  @param params
 *  @param aBlock
 */

-(void)getHidePayDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:GetSwitchUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(CommonNetErrorTip,NO);
        }
    } fail:^(NSError *error) {
        aBlock(CommonNetErrorTip,NO);
    }];

    
}


@end
