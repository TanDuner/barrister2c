//
//  LearnCenterProxy.m
//  barrister
//
//  Created by 徐书传 on 16/6/15.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LearnCenterProxy.h"

#define LearnCenterListUrl @"getStudyList.do"
#define LearnCenterChannelUrl @"getStudyChannelList.do"

@implementation LearnCenterProxy

/**
 *  学习中心列表接口
 *
 *  @param params 参数
 *  @param aBlock 回调
 */
-(void)getLearnCenterListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:LearnCenterListUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }

    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(CommonNetErrorTip,NO);
        }
    }];
}



/**
 *  获取学习中心频道接口
 *
 *  @param params 参数
 *  @param aBlock 回调
 */
-(void)getLearnChannelWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:LearnCenterChannelUrl params:params success:^(id response) {
        if (aBlock) {
            aBlock(response,YES);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];
}

@end
