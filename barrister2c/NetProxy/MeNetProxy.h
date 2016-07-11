//
//  MeNetProxy.h
//  barrister
//
//  Created by 徐书传 on 16/5/16.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"

@interface MeNetProxy : BaseNetProxy



/**
 *  上传头像
 *
 *  @param params <#params description#>
 *  @param aBlock <#aBlock description#>
 */
-(void)UploadHeadImageUrlWithImage:(UIImage *)image
                            params:(NSMutableDictionary *)params
                          fileName:(NSString *)fileName
                             Block:(ServiceCallBlock)aBlock;




/**
 *  我的消息
 */

-(void)getMyMessageWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;


/**
 *  填写反馈接口
 *
 *  @param params <#params description#>
 *  @param aBlock <#aBlock description#>
 */
-(void)feedBackWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;


/**
 *  修改个人信息接口
 *
 *  @param params 参数
 *  @param aBlock 回调
 */
-(void)updateUserInfoWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;


/**
 *  获取订单列表
 *
 *  @param params
 *  @param aBlock
 */
-(void)getOrderListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;


/**
 *  我的收藏列表
 *
 *  @param params
 *  @param aBlock 
 */
-(void)getMyLikeListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;


/**
 *  获取微信预付订单
 */

-(XuURLSessionTask *)getWeChatPrePayOrderWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;

/**
 *  获取支付宝预付订单
 */

-(XuURLSessionTask *)getAliaPaytPrePayOrderWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;

@end


