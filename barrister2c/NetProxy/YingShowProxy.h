//
//  YingShowProxy.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"

@interface YingShowProxy : BaseNetProxy


/**
 *  搜索查询接口
 *
 *  @param params 入参
 *  @param aBlock 返回block
 */

-(void)getYingShowSearchResultWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;


/**
 应收账款查询详情接口

 @param params
 @param aBlock
 */
-(void)getYingShowInfoDetailWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;



/**
 下单接口

 @param params
 @param aBlock
 */
-(void)buyYingShowInfoWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;



/**
 发布应收账款

 @param params    参数
 @param imageData 图片文件
 @param aBlock   回调block
 */
-(void)publishYingShowWithParams:(NSMutableDictionary *)params imageData:(NSData *)proofImageData  panjueshuImageData:(NSData *)panjueshuData Block:(ServiceCallBlock)aBlock;




/**
 获取我的购买应收账款列表

 @param params 参数
 @param aBlock 回调block
 */
-(void)getYingShowMyBuyListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;



/**
 获取我的购买应收账款列表
 
 @param params 参数
 @param aBlock 回调block
 */
-(void)getYingShowMyUploadListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;



/**
 删除相应的我发布的应收账款信息

 @param params 参数
 @param aBlock 回调block
 */
-(void)deleteMyUploadYingShowInfoWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock;

@end
