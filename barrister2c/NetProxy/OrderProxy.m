//
//  OrderProxy.m
//  barrister
//
//  Created by 徐书传 on 16/5/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderProxy.h"

#define GetOrderListUrl @""

@implementation OrderProxy
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
@end
