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
        NSString *state = [model.settingArray objectAtIndex:i];
        if ([state isEqualToString:@"2"]) {
            NSString *timeTmepStr = [[AppointmentManager shareInstance].commonTimeArray objectAtIndex:i];
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

@end
