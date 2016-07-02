//
//  BussinessAreaModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BussinessAreaModel.h"

@implementation BussinessAreaModel

-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    self.areaId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
}

@end

