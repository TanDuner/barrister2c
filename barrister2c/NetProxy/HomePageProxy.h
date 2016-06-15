//
//  HomePageProxy.h
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"

@interface HomePageProxy : BaseNetProxy

/**
 *  获取banner
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理Block
 */
-(void)getHomePageBannerWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;

/**
 *  获取首页账户信息接口
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理Block
 */

-(void)getHomePageAccountDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;

@end
