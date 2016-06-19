//
//  BarristerLawerModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BarristerLawerModel.h"




@implementation BarristerLawerModel


-(id)initWithDictionary:(NSDictionary *)jsonObject
{
    if (self = [super initWithDictionary:jsonObject]) {
        [self handleProprety];
    }
    return self;
}

-(void)handleProprety
{
    self.workYears = @"1";
}

@end
