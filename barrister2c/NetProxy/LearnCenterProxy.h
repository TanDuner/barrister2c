//
//  LearnCenterProxy.h
//  barrister
//
//  Created by 徐书传 on 16/6/15.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"

@interface LearnCenterProxy : BaseNetProxy

/**
 *  学习中心列表接口
 *
 *  @param params 参数
 *  @param aBlock 回调
 */
-(void)getLearnCenterListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;


/**
 *  获取学习中心频道接口
 *
 *  @param params 参数
 *  @param aBlock 回调
 */
-(void)getLearnChannelWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;
@end
