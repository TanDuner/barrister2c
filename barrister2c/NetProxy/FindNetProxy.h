//
//  FindNetProxy.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/16.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"

@interface FindNetProxy : BaseNetProxy

/**
 *  获取中国法律应用大全接口
 *
 *  @param params 参数
 *  @param aBlock 回调
 */

-(void)getLawBooksWithParams:(NSMutableDictionary *)params WithBlock:(ServiceCallBlock)aBlock;

@end
