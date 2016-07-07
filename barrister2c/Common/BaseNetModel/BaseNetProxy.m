//
//  BaseNetProxy.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNetProxy.h"
#define BaseDomainUrl @""

@implementation BaseNetProxy

-(void)appendCommonParamsWithDict:(NSMutableDictionary *)params
{
    if ([BaseDataSingleton shareInstance].userModel.userId) {
        [params setObject:[BaseDataSingleton shareInstance].userModel.userId forKey:@"userId"];
    }
    if ([BaseDataSingleton shareInstance].userModel.verifyCode) {
        [params setObject:[BaseDataSingleton shareInstance].userModel.verifyCode forKey:@"verifyCode"];
    }

}

-(NSString *)appendUrlWithString:(NSString *)urlString
{
    NSString *retString = [NSString stringWithFormat:@"%@%@",BaseDomainUrl,urlString];
    return retString;
}

-(BOOL)isCommonCorrectResultCodeWithResponse:(id)response
{
    NSDictionary *dict = (NSDictionary *)response;
    NSString *resultCode = [dict objectForKey:@"resultCode"];
    if (resultCode.integerValue == 200 || resultCode.integerValue == 1006) {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
