//
//  AccountProxy.m
//  barrister
//
//  Created by 徐书传 on 16/5/30.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "AccountProxy.h"

#define AccountDetialUrl @""
#define TixianUrl @""
#define BindBankCardUrl @"bindBankCard"

@implementation AccountProxy


/**
 *  绑定银行卡
 userId,verifyCode,cardNum（卡号）,cardholderName（持卡人姓名），bankName(银行名称)，bankAddress(开户行)
 */
-(void)bindCarkWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:BindBankCardUrl params:params success:^(id response) {
        if (aBlock) {
            aBlock(response,YES);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
        
    }];

}

-(void)getAccountDetailDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:AccountDetialUrl params:params success:^(id response) {
        if (aBlock) {
            aBlock(response,YES);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }

    }];
}

-(void)tiXianActionWithMoney:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking postWithUrl:TixianUrl params:params success:^(id response) {
        aBlock(response ,YES);
    } fail:^(NSError *error) {
        aBlock(nil,NO);
    }];
}



-(void)getCardInfoWithCardNum:(NSString *)cardNum WithBlock:(ServiceCallBlock)aBlock
{
    NSString *httpUrl = @"http://apis.baidu.com/datatiny/cardinfo/cardinfo";
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?cardnum=%@", httpUrl, cardNum];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"732bbaf70af9fc28eaad5c5d28991262" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   if (aBlock) {
                                       aBlock(error,NO);
                                   }
                                   
                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                   NSString *status = [jsonObject objectForKey:@"status"];
                                   if ([NSString stringWithFormat:@"%@",status].intValue == 1) {
                                       NSDictionary *dataDict = [jsonObject objectForKey:@"data"];
                                       aBlock(dataDict,YES);
                                   }
                                   else
                                   {
                                       aBlock(nil,NO);
                                   }
                               }
                           }];
}

@end
