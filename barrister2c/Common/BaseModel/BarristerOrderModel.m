//
//  BarristerOrderModel.m
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BarristerOrderModel.h"

@implementation BarristerOrderModel

-(id)initWithDictionary:(NSDictionary *)jsonObject
{
    if (self = [super initWithDictionary:jsonObject]) {

    }
    return self;
}

-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    CGFloat height = [XuUtlity textHeightWithString:self.markStr withFont:SystemFont(14.0f) sizeWidth:SCREENWIDTH - 20 WithLineSpace:5];

    if (height <= 13) {
        height = 13;
    }
    self.markHeight = height;

    self.orderId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
}


@end
