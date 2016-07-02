//
//  LawerListProxy.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/26.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerListProxy.h"

#define LawerListUrl @"barristerList.do"
#define LawerDetailUrl @"barristerDetail.do"
#define CollectLaywerUrl @"addFavoriteBarrister.do"
#define CancelCollectLaywerUrl @"delFavoriteBarrister.do"

@implementation LawerListProxy

-(void)getLawerListWithParams:(NSDictionary *)params block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:LawerListUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else
        {
            aBlock(CommonNetErrorTip,NO);
        }

    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];

}


/**
 *  获取律师详情
 *
 *  @param aParams
 *  @param aBlock
 */

-(void)getOrderDetailWithParams:(NSDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    
    [XuNetWorking getWithUrl:LawerDetailUrl params:aParams success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(CommonNetErrorTip,NO);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
        
    }];
}


/**
 * 收藏律师
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)collectLaywerWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:aParams];
    [XuNetWorking postWithUrl:CollectLaywerUrl params:aParams success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            NSString *resultCode = [response objectForKey:@"resultCode"];
            aBlock(resultCode,NO);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
    }];

    
}

/**
 *  取消收藏律师
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)cancelCollectLaywerWithParams:(NSMutableDictionary *)aParams Block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:aParams];
    [XuNetWorking postWithUrl:CancelCollectLaywerUrl params:aParams success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(CommonNetErrorTip,NO);
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
    }];
}


@end
