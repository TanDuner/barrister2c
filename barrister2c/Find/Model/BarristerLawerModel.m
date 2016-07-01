//
//  BarristerLawerModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BarristerLawerModel.h"


#define MaxIntroduceHeight 56


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
    
    if (self.introduceStr.length > 0) {
        CGFloat height = [XuUtlity textHeightWithString:self.introduceStr withFont:SystemFont(14.0f) sizeWidth:SCREENWIDTH - 20 WithLineSpace:5];
        
        self.allIntroduceStrHeight =  height;
        
        self.isShowAll = NO;
        
        if (height > MaxIntroduceHeight) {
            self.introducestrHeight = MaxIntroduceHeight + 5;
            self.isNeedShowAll = YES;
            
            self.showAllIntroduceViewHeight = 52 + 35 + self.allIntroduceStrHeight + 10 + 15 + 15  ;
            self.showIntroduceViewHeight = 52 + 35 + self.introducestrHeight + 10 + 15 + 15;

        }
        else
        {
            
            self.introducestrHeight = height;
            self.isNeedShowAll = NO;
            self.showAllIntroduceViewHeight = height + 35 + 15 + 52;
            self.showIntroduceViewHeight = height + 35 + 15 + 52;
        }

    }
    else
    {
        self.isNeedShowAll = NO;
        self.isShowAll = YES;
        self.showAllIntroduceViewHeight = 35 + 12 + 15 + 52;
        self.showIntroduceViewHeight = 35 + 12 + 15 + 52;
    }
}

@end