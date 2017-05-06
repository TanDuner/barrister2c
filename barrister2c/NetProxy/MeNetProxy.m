//
//  MeNetProxy.m
//  barrister
//
//  Created by 徐书传 on 16/5/16.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MeNetProxy.h"

#define UploadHeadImageUrl @"uploadUserIcon.do"
#define MyMessageUrl @"getMyMsgs.do"
#define FeedBackUrl @"feedback.do"
#define UpdateUserInfo @"updateUserInfo.do"
#define OrderListUrl @"myOrderList.do"
#define MyLikeListUrl @"myFavoriteList.do"
#define WeChatPayUrl @"wxPrepayInfo.do"
#define AliaPayUrl @"aliPrepayInfo.do"

#define PublishCaseSource @"uploadCase.do"
#define ShareCosumeListUrl  @"com"

@implementation MeNetProxy
/**
 *  上传头像
 *
 *  @param params 参数
 *  @param aBlock 回调
 */

-(void)UploadHeadImageUrlWithImage:(UIImage *)image
                            params:(NSMutableDictionary *)params
                          fileName:(NSString *)fileName
                             Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking uploadWithImage:image url:UploadHeadImageUrl filename:@"userIcon" name:@"userIcon" mimeType:@"image/jpeg" parameters:params progress:nil success:^(id response) {
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
 *  我的消息列表
 *
 *  @param params 参数
 *  @param aBlock 回调block
 */
-(void)getMyMessageWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking postWithUrl:MyMessageUrl params:params success:^(id response) {
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
 *  填写反馈接口
 *
 *  @param params <#params description#>
 *  @param aBlock <#aBlock description#>
 */
-(void)feedBackWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking postWithUrl:FeedBackUrl params:params success:^(id response) {
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
 *  修改个人信息接口
 *
 *  @param params 参数
 *  @param aBlock 回调
 */
-(void)updateUserInfoWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:UpdateUserInfo params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else{
            aBlock(CommonNetErrorTip,NO);
        }

    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
        
    }];
    
}


/**
 *  获取订单列表
 *
 *  @param params
 *  @param aBlock
 */
-(void )getOrderListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking postWithUrl:OrderListUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else{
            aBlock(CommonNetErrorTip,NO);
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
        
    }];
    
}


/**
 *  我的收藏列表
 *
 *  @param params
 *  @param aBlock
 */
-(void)getMyLikeListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking postWithUrl:MyLikeListUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else{
            aBlock(CommonNetErrorTip,NO);
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
        
    }];

}

/**
 *  获取微信预付订单
 */

-(XuURLSessionTask *)getWeChatPrePayOrderWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    XuURLSessionTask *task = [XuNetWorking postWithUrl:WeChatPayUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(response,NO);
        }
    } fail:^(NSError *error) {
        aBlock(CommonNetErrorTip,NO);
    }];
    
    return task;
}


/**
 *  获取支付宝预付订单
 */

-(XuURLSessionTask *)getAliaPaytPrePayOrderWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    XuURLSessionTask *task = [XuNetWorking postWithUrl:AliaPayUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(response,NO);
        }
    } fail:^(NSError *error) {
        aBlock(CommonNetErrorTip,NO);
    }];
    
    return task;
}

/**
 *  发布案源接口
 *
 *  @param params
 *  @param aBlock
 */
-(void)publishCaseSourceWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    
    [XuNetWorking postWithUrl:PublishCaseSource params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else{
            aBlock(CommonNetErrorTip,NO);
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
        
    }];

}


/**
 *  分享消费记录
 *
 *  @param params
 *  @param aBlock
 */

-(void)getShareCosumeListDataWithParmas:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    
    [XuNetWorking postWithUrl:ShareCosumeListUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else{
            aBlock(CommonNetErrorTip,NO);
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
        
    }];
    
}


@end
