//
//  BussinessTypeModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BussinessTypeModel.h"

@implementation BussinessTypeModel

-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    self.typeId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
}


@end
