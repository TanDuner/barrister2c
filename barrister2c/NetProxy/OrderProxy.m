//
//  OrderProxy.m
//  barrister
//
//  Created by 徐书传 on 16/5/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderProxy.h"

#define GetOrderListUrl @"myOrderList.do"
#define RequestCancelOrderUrl @"requestCancelOrder"
#define OrderPraiseUrl @"addOrderStar"

#define OrderDetailUrl @"orderDetail.do"

@implementation OrderProxy


/**
 *  订单详情
 *
 *  @param aParams <#aParams description#>
 *  @param aBlock  <#aBlock description#>
 */
-(void)getOrderDetailWithParams:(NSDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:OrderDetailUrl params:aParams success:^(id response) {
        if (aBlock) {
            if ([self isCommonCorrectResultCodeWithResponse:response]) {
                NSDictionary *dict = (NSDictionary *)response;
                NSDictionary *orderDetail = [dict objectForKey:@"orderDetail"];
                aBlock(orderDetail,YES);
            }
            else
            {
                aBlock(CommonNetErrorTip,NO);
            }
            
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(CommonNetErrorTip,NO);
        }
    }];

}

/**
 *  订单列表
 *
 *  @param aParams <#aParams description#>
 *  @param aBlock  <#aBlock description#>
 */
-(void)getOrderListWithParams:(NSDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:GetOrderListUrl params:aParams success:^(id response) {
        if (aBlock) {
            if ([self isCommonCorrectResultCodeWithResponse:response]) {
                aBlock([response objectForKey:@"List"],YES);
            }

        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
    }];
}


/**
 *  申请取消订单
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)applyToCancelOrderWithParams:(NSDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:RequestCancelOrderUrl params:aParams success:^(id response) {
        if (aBlock) {
            if ([self isCommonCorrectResultCodeWithResponse:response]) {
                aBlock(response,YES);
            }
            
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
    }];
}

/**
 *  订单评分
 */

//  参数:userId,verifyCode,orderId,star,comment

-(void)appriseOrderWithParams:(NSDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:OrderPraiseUrl params:aParams success:^(id response) {
        if (aBlock) {
            if ([self isCommonCorrectResultCodeWithResponse:response]) {
                aBlock(response,YES);
            }
            
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
    }];
}

@end
