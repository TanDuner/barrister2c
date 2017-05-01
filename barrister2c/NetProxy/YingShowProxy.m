//
//  YingShowProxy.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowProxy.h"

#define searchCreditDebtListUrl @"searchCreditDebtList.do"
#define PublishYingShowUrl @"uploadCreditDebt.do"
#define MyBuyYingShowUrl   @"myPurchasedCreditDebtList.do"
#define MyUploadYingShowUrl @"myUploadCreditDebtList.do"
#define DeleteYingShowInfoUrl @"delCreditDebtInfo.do"
#define YingshowDetailUrl       @"creditDebtInfoDetail.do"
#define BuyYingShowUrl          @"buyCreditDebtDetail.do"

@implementation YingShowProxy


/**
 *  搜索查询接口
 *
 *  @param params 入参
 *  @param aBlock 返回block
 */

-(void)getYingShowSearchResultWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking getWithUrl:searchCreditDebtListUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else
        {
            if (aBlock) {
                aBlock(response,NO);
            }
            
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];


}



/**
 应收账款查询详情接口
 
 @param params
 @param aBlock
 */
-(void)getYingShowInfoDetailWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking postWithUrl:YingshowDetailUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
            else
            {
                NSDictionary *dict = (NSDictionary *)response;
                NSString *resultCode = [dict objectForKey:@"resultCode"];

                if (resultCode.integerValue == 605) {
                    aBlock(@"未购买",YES);
                }
                else{
                    aBlock(CommonNetErrorTip,NO);
 
                }
                
            
                
            }
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];


}



/**
 下单接口
 
 @param params
 @param aBlock
 */
-(void)buyYingShowInfoWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{

    [self appendCommonParamsWithDict:params];
    [XuNetWorking postWithUrl:BuyYingShowUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
            else
            {
              
                aBlock(CommonNetErrorTip,NO);
            }
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];
}




/**
 获取我的购买应收账款列表
 
 @param params 参数
 @param aBlock 回调block
 */
-(void)getYingShowMyBuyListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking getWithUrl:MyBuyYingShowUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else
        {
            if (aBlock) {
                aBlock(CommonNetErrorTip,NO);
            }
            
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];

}

/**
 获取我的上传的应收账款列表
 
 @param params 参数
 @param aBlock 回调block
 */
-(void)getYingShowMyUploadListWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking getWithUrl:MyUploadYingShowUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else
        {
            if (aBlock) {
                aBlock(CommonNetErrorTip,NO);
            }
            
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];
    
}



/**
 删除相应的我发布的应收账款信息
 
 @param params 参数
 @param aBlock 回调block
 */
-(void)deleteMyUploadYingShowInfoWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking getWithUrl:DeleteYingShowInfoUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            if (aBlock) {
                aBlock(response,YES);
            }
        }
        else
        {
            if (aBlock) {
                aBlock(CommonNetErrorTip,NO);
            }
            
        }
        
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];
}



/**
 *  发布债务债权
 *
 *  @param aParams
 *  @param aBlock
 */
-(void)publishYingShowWithParams:(NSMutableDictionary *)params imageData:(NSData *)proofImageData  panjueshuImageData:(NSData *)panjueshuData Block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    
    AFHTTPSessionManager *manager = [XuNetWorking manager];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",[XuNetWorking baseUrl],PublishYingShowUrl] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:proofImageData name:@"proof" fileName:@"proof" mimeType:@"image/jpeg"];
        if (panjueshuData) {
            [formData appendPartWithFileData:proofImageData name:@"judgeDocument" fileName:@"judgeDocument" mimeType:@"image/jpeg"];    
        }
        

        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (aBlock && [self isCommonCorrectResultCodeWithResponse:responseObject]) {
            aBlock(responseObject,YES);
        }
        else
        {
            aBlock(responseObject,NO);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (aBlock) {
            aBlock(@"网络错误,请稍后重试",NO);
        }
    }];
}


@end
