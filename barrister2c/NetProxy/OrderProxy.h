//
//  OrderProxy.h
//  barrister
//
//  Created by 徐书传 on 16/5/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"

@interface OrderProxy : BaseNetProxy

/**
 *  获取订单列表
 *
 *  @param aParams
 *  @param aBlock  返回block
 */
-(void)getOrderListWithParams:(NSDictionary *)aParams Block:(ServiceCallBlock)aBlock;

/**
 *  获取订单详情
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)getOrderDetailWithParams:(NSDictionary *)aParams Block:(ServiceCallBlock)aBlock;

/**
 *  申请取消订单
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)applyToCancelOrderWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;


/**
 *  订单评分
 */
-(void)appriseOrderWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;



/**
 *  拨打电话
 */

-(void)makeCallWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;


/**
 *  打赏
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)rewardOrderWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;


-(void)downloadVoiceWithUrl:(NSString *)voiceUrl
                   savePath:(NSString *)savePath
                      Block:(ServiceCallBlock)aBlock;


//线上专项服务支付
-(void)payOnlineServiceWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock;

@end
