//
//  OrderProxy.m
//  barrister
//
//  Created by 徐书传 on 16/5/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderProxy.h"

#define GetOrderListUrl @"myOrderList.do"
#define RequestCancelOrderUrl @"requestCancelOrder.do"
#define OrderPraiseUrl @"addOrderStar.do"

#define OrderDetailUrl @"orderDetail.do"
#define MakeCallUrl @"makeCall.do"
#define RewardOrderUrl @"rewardOrder.do"

#define PayOnlineUrl @"payOnlineOrder.do"

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
-(void)applyToCancelOrderWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:aParams];
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

-(void)appriseOrderWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:aParams];
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

/**
 *  拨打电话
 */

-(void)makeCallWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock
{

    [self appendCommonParamsWithDict:aParams];
    [XuNetWorking postWithUrl:MakeCallUrl params:aParams success:^(id response) {
        if (aBlock) {
            if ([self isCommonCorrectResultCodeWithResponse:response]) {
                aBlock(response,YES);
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
 *  打赏
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)rewardOrderWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:aParams];
    [XuNetWorking postWithUrl:RewardOrderUrl params:aParams success:^(id response) {
        if (aBlock) {
            if ([self isCommonCorrectResultCodeWithResponse:response]) {
                aBlock(response,YES);
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
 *  下载录音文件
 *
 *  @param voiceUrl
 *  @param savePath
 *  @param aBlock
 */
-(void)downloadVoiceWithUrl:(NSString *)voiceUrl
                   savePath:(NSString *)savePath
                      Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking downloadWithUrl:voiceUrl saveToPath:savePath progress:nil success:^(id response) {
        aBlock(response,YES);
    } failure:^(NSError *error) {
        [XuNetWorking updateBaseUrl:BaseUrl];
        aBlock(CommonNetErrorTip,NO);
    }];
}

-(void)payOnlineServiceWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:aParams];
    [XuNetWorking postWithUrl:PayOnlineUrl params:aParams success:^(id response) {
        if (aBlock) {
            if ([self isCommonCorrectResultCodeWithResponse:response]) {
                aBlock(response,YES);
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

@end
