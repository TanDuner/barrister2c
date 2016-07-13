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
 *  获取用户端首页所有数据
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理Block
 */
-(void)getHomePageDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;



/**
 *  获取开关数据
 *
 *  @param params
 *  @param aBlock
 */

-(void)getHidePayDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;

@end
