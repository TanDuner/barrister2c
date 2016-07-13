//
//  AppointmentMoel.m
//  barrister
//
//  Created by 徐书传 on 16/6/30.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "AppointmentMoel.h"
#import "AppointmentManager.h"

@implementation AppointmentMoel

+(AppointmentMoel *)getEmptyModelWithInitDateWithModel:(AppointmentMoel *)model
{
    AppointmentMoel *appointmentModel = [[AppointmentMoel alloc] init];
    appointmentModel.settingArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 36; i ++) {
        [appointmentModel.settingArray addObject:@"0"];
    }
    appointmentModel.date = model.date;
    return appointmentModel;
}


/**
 *  筛选出model 的全部为2 的 字段拼出来 时间段的字符串
 *
 *  @param model
 *
 *  @return
 */
+(NSString *)getStringWithModel:(AppointmentMoel *)model
{
    
    NSString *str = @"";
    for (int i = 0; i < model.settingArray.count; i ++) {
        NSString *state = [model.settingArray safeObjectAtIndex:i];
        if ([state isEqualToString:@"2"]) {
            NSString *timeTmepStr = [[AppointmentManager shareInstance].commonTimeArray safeObjectAtIndex:i];
            NSLog(@"%@",[AppointmentManager shareInstance].commonTimeArray);
            str = [NSString stringWithFormat:@"%@,%@",str,timeTmepStr];
        }
        
    }
    
    if ([str hasPrefix:@","]) {
        str = [str substringFromIndex:1];
    }
    if (str.length > 0) {
        str = [NSString stringWithFormat:@"%@：%@",model.date,str];
    }
    
    return str;
}

-(void)setSettings:(NSString *)settings
{
    _settings = settings;
    self.settingArray = [NSMutableArray arrayWithArray:[_settings componentsSeparatedByString:@","]];
    
}



/**
 *  把获得的当天的model 的当前时间之前的 全部设置为2
 */

-(void)setCurrentOrEailerDateUnSelected
{
    NSDate *date = [NSDate date];
    NSString *dateStr = [XuUtlity stringFromDate:date forDateFormatterStyle:DateFormatterTime];//13:40
    NSRange range = [dateStr rangeOfString:@":"];
    
    NSString *minStr = [dateStr substringFromIndex:range.location + 1];
    
    dateStr = [dateStr substringToIndex:range.location];
    
    NSInteger index = dateStr.integerValue *2 - 12;
    
    if (minStr.intValue > 30) {
        index += 1;
    }

        NSString *str = @"";
    for ( int i = 0 ; i < self.settingArray.count; i ++) {
        if (i < index) {
            [self.settingArray replaceObjectAtIndex:i withObject:@"2"];
            str = [NSString stringWithFormat:@"%@,%@",str,@"2"];
        }
        else
        {
            NSString *originStr = [self.settingArray safeObjectAtIndex:i];
            str = [NSString stringWithFormat:@"%@,%@",str,originStr];
        }

        if ([str hasPrefix:@","]) {
            str = [str substringFromIndex:1];
        }
        
    }
    
    
    self.settings = str;
}


@end
