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
 *  获取预约设置的数据
 *
 *  @param params 请求参数
 *  @param aBlock 处理block
 */
-(void)getAppointDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;


/**
 *  设置预约的数据
 *
 *  @param params nil
 *  @param aBlock nil
 */
-(void)setAppintDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock;



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

@end


