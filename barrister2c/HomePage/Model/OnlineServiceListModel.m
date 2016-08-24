//
//  OnlineServiceListModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OnlineServiceListModel.h"

@implementation OnlineServiceListModel

-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    _introContentHeight = [XuUtlity textHeightWithString:self.intro withFont:SystemFont(13) sizeWidth:SCREENWIDTH - 10 - 40 - 10 - 60 - 10];
    
}

@end
