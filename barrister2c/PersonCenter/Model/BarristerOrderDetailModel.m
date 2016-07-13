//
//  BarristerOrderDetailModel.m
//  barrister
//
//  Created by 徐书传 on 16/6/28.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BarristerOrderDetailModel.h"

@implementation BarristerOrderDetailModel


-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    NSArray *array  = [dict objectForKey:@"callHistories"];
    if ([XuUtlity isValidArray:array]) {
        for (int i = 0; i < array.count; i ++) {
            NSDictionary *dict = (NSDictionary *)[array safeObjectAtIndex:i];
            CallHistoriesModel *model = [[CallHistoriesModel alloc] initWithDictionary:dict];
            [self.callRecordArray addObject:model];
        }
    }
  
    
    
    if ([dict respondsToSelector:@selector(objectForKey:)]) {
        self.orderId = [dict objectForKey:@"id"];
        CGFloat customMarkHeight = [XuUtlity textHeightWithString:self.remarks withFont:SystemFont(14.0f) sizeWidth:SCREENWIDTH - 90 WithLineSpace:0];
        
        if (customMarkHeight <= 13) {
            customMarkHeight = 13;
        }
        self.markHeight = customMarkHeight;
        
        self.orderId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    
        
        CGFloat lawyerFeedBackHeight = [XuUtlity textHeightWithString:self.lawFeedback withFont:SystemFont(14.0f) sizeWidth:SCREENWIDTH - 90 WithLineSpace:5];
        if (lawyerFeedBackHeight <= 13) {
            lawyerFeedBackHeight = 13;
        }
        
        self.lawyerFeedBackHeight = lawyerFeedBackHeight;
        
        if (!self.customerNickname) {
            self.customerNickname = [NSString stringWithFormat:@"用户%@",self.customerPhone];
        }
        
        
        CGFloat commonHeight = [XuUtlity textHeightWithString:self.comment withFont:SystemFont(14.0f) sizeWidth:SCREENWIDTH - 90 WithLineSpace:5];
        if (commonHeight <= 13) {
            commonHeight = 13;
        }
        
        self.customCommonHeight = commonHeight;

        
    }

}

-(NSMutableArray *)callRecordArray
{
    if (!_callRecordArray) {
        _callRecordArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _callRecordArray;
}

@end
