//
//  HomePageProxy.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "HomePageProxy.h"

#define HomePageBannerUrl @"lunboAds"
#define HomePageAccountUrl @"userHome"

@implementation HomePageProxy

/**
 *  获取banner
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理Block
 */

-(void)getHomePageBannerWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:HomePageBannerUrl params:params success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
}


/**
 *  获取首页账户信息接口
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理Block
 */

-(void)getHomePageAccountDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:HomePageAccountUrl params:params success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
}

@end
