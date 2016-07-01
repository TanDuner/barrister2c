//
//  LearnCenterChannelModel.m
//  barrister
//
//  Created by 徐书传 on 16/6/28.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LearnCenterChannelModel.h"

@implementation LearnCenterChannelModel


-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    self.channelId = [dict objectForKey:@"id"];
}
@end
