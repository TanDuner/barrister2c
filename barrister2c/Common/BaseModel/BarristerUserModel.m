//
//  BarristerUserModel.m
//  barrister
//
//  Created by 徐书传 on 16/5/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BarristerUserModel.h"

@implementation BarristerUserModel


-(void)handlePropretyWithDict:(NSDictionary *)jsoObject
{
    self.userId = [jsoObject objectForKey:@"id"];
    if (self.nickName == nil) {
        self.nickName = [NSString stringWithFormat:@"用户%@",self.phone];
    }
}


@end
