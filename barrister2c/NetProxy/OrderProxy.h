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

@end
