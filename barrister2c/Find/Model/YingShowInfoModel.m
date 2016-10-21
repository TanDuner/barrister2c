//
//  YingShowInfoModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowInfoModel.h"
#import "YingShowUserModel.h"

@implementation YingShowInfoModel

-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    self.yingShowInfoId = [dict objectForKey:@"id"];
   
    NSDictionary *creditUserDict = [dict objectForKey:@"creditUser"];
    
    self.creditUser = [[YingShowUserModel alloc] initWithDictionary:creditUserDict];
    
    
    NSDictionary *debtUserDict = [dict objectForKey:@"debtUser"];
    
    self.debtUser = [[YingShowUserModel alloc] initWithDictionary:debtUserDict];
    
    
    
}


+(NSString *)getSubmitStrWithSelectObject:(NSString *)selectObject
{
    
    if ([selectObject isEqualToString:@"债权人"])
    {
        return @"credit";
        
    }
    else if ([selectObject isEqualToString:@"债务人"])
    {
        return @"debt";
        
    }
    
    
    else if ([selectObject isEqualToString:@"合同欠款"])
    {
        return TYPE_CONTRACT;
    }
    else if ([selectObject isEqualToString:@"借款"])
    {
        return TYPE_BORROW_MONEY;
    }
    else if ([selectObject isEqualToString:@"侵权"])
    {
        return TYPE_TORT;
    }
    else if ([selectObject isEqualToString:@"劳动与劳务"])
    {
        return TYPE_LABOR_DISPUTES;
    }
    else if ([selectObject isEqualToString:@"其他"])
    {
        return TYPE_OTHER;
    }
    
    
    
    else if ([selectObject isEqualToString:@"合同"])
    {
        return PROOF_TYPE_HETONG;
    }
    else if ([selectObject isEqualToString:@"协议"])
    {
        return PROOF_TYPE_XIEYI;
    }
    else if ([selectObject isEqualToString:@"欠条"])
    {
        return PROOF_TYPE_QIANTIAO;
    }
    else if ([selectObject isEqualToString:@"其他"])
    {
        return PROOF_TYPE_QITA;
    }
    else{
        return @"";
    }
    
    
}

@end
