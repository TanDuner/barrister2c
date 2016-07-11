//
//  MyLikeModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/7/3.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyLikeModel.h"

@implementation MyLikeModel

-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    self.lawerId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
}

@end
