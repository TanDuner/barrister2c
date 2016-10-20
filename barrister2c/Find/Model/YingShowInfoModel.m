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

@end
