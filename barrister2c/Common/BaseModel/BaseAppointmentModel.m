//
//  BaseAppointmentModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/24.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseAppointmentModel.h"

@implementation BaseAppointmentModel


+ (nonnull instancetype)shareInstance;
{
    static BaseAppointmentModel *dataSingleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSingleTon = [[self alloc] init];
    });
    
    return dataSingleTon;
}

-(NSMutableArray *)daysArray
{
    if (!_daysArray) {
        _daysArray  = [NSMutableArray arrayWithCapacity:10];

        NSDate *dateTemp = [NSDate date];

        for ( int i = 0; i < 7 ; i ++) {
            NSString *dateStr = [XuUtlity stringFromDate:dateTemp forDateFormatterStyle:DateFormatterDate];
            [_daysArray addObject:dateStr];
            dateTemp = [NSDate dateWithTimeInterval:86400 sinceDate:dateTemp];
            
        }
      
    }
    return _daysArray;
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic;

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
