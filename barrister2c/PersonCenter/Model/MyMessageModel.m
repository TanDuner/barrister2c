//
//  MyMessageModel.m
//  barrister
//
//  Created by 徐书传 on 16/6/14.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyMessageModel.h"

@implementation MyMessageModel

-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    self.messageId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    
    if (self.content) {

        self.contentHeight = [XuUtlity textHeightWithString:self.content withFont:SystemFont(14.0f) sizeWidth:SCREENWIDTH - LeftPadding - LeftPadding];
        if (self.contentHeight < 13) {
            self.contentHeight = 13;
        }
    }
    
    if (self.title) {
        self.titleHeight = [XuUtlity textHeightWithString:self.title withFont:SystemFont(14.0f) sizeWidth:SCREENWIDTH - LeftPadding - LeftPadding];
        if (self.titleHeight < 13) {
            self.titleHeight = 13;
        }
    }
}

@end
