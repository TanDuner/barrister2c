//
//  LoginProxy.h
//  barrister
//
//  Created by 徐书传 on 16/5/16.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"

@interface LoginProxy : BaseNetProxy

/**
 *  登录/注册接口
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理block
 */
-(void)loginWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;

/**
 *  获取验证码接口
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理block
 */
-(void)getValidCodeWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;

/**
 *  注销
 */

-(void)loginOutWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;
@end
