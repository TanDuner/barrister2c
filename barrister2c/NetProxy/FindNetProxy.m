//
//  FindNetProxy.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/16.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "FindNetProxy.h"
#define LawBookUrl @""
@implementation FindNetProxy
/**
 *  获取中国应用大全接口
 *
 *  @param params 参数
 *  @param aBlock 回调
 */
-(void)getLawBooksWithParams:(NSMutableDictionary *)params WithBlock:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:LawBookUrl params:params success:^(id response) {
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
