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

@end
