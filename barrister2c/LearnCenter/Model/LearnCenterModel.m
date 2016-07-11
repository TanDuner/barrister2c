//
//  LearnCenterModel.m
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LearnCenterModel.h"

@implementation LearnCenterModel


-(void)handlePropretyWithDict:(NSDictionary *)dict{
    self.learnId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    
//[XuUtlity NSStringDateToNSDate:[dict objectForKey:@"date"] forDateFormatterStyle:DateFormatterDateAndTime]
    self.date = [dict objectForKey:@"date"];
    
}
@end

