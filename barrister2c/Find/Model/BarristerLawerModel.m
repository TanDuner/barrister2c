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

-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    self.laywerId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    
    NSString *areaStr = @"";
    NSArray *array = [dict objectForKey:@"bizAreas"];
    if (!array) {
        array = [dict objectForKey:@"bizAreaList"];
    }
    if ([XuUtlity isValidArray:array]) {
        for (NSDictionary *dictTmep in array) {
            NSString *nameStr = [dictTmep objectForKey:@"name"];
            areaStr = [NSString stringWithFormat:@"%@|%@",areaStr,nameStr];
        }
    }

   
    
    if ([areaStr hasPrefix:@"|"]) {
        areaStr = [areaStr substringFromIndex:1];
    }
    self.goodAtStr = areaStr;
    
    
    
    if (self.intro.length > 0) {
        CGFloat height = [XuUtlity textHeightWithString:self.intro withFont:SystemFont(14.0f) sizeWidth:SCREENWIDTH - 20 WithLineSpace:5];
        
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
