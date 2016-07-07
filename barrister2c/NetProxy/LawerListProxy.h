//
//  LawerListProxy.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/26.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"

@interface LawerListProxy : BaseNetProxy

/**
 *  律师列表接口
 *
 *  @param params 入参
 *  @param aBlock 返回block
 */

-(void)getLawerListWithParams:(NSDictionary *)params block:(ServiceCallBlock)aBlock;

/**
 *  律师详情
 */

-(void)getOrderDetailWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;


/**
 * 收藏律师
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)collectLaywerWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;

/**
 *  取消收藏律师
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)cancelCollectLaywerWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;


/**
 *  获取律师预约信息接口
 *
 *  @param aParams
 *  @param aBlock
 */

-(void)getLawerAppointmentDataWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;


/**
 *  下单接口
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)placeOrderOrderWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;

@end
