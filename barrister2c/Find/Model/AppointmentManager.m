//
//  AppointmentManager.m
//  barrister
//
//  Created by 徐书传 on 16/6/30.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "AppointmentManager.h"

@implementation AppointmentManager


+ (nonnull instancetype)shareInstance;
{
    static AppointmentManager *dataSingleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSingleTon = [[self alloc] init];
        dataSingleTon.commonTimeArray = [NSArray arrayWithObjects:@"06:00~06:30",@"06:30~07:00",@"07:00~07:30",@"07:30~08:00",@"08:00~08:30",@"08:30~09:00",@"09:00~09:30",@"09:30~10:00",@"10:00~10:30"@"10:30~11:00",@"11:00~11:30",@"11:30~12:00",@"12:00~12:30",@"12:30~13:00",@"13:00~13:30",@"13:30~14:00",@"14:00~14:30",@"14:30~15:00",@"15:00~15:30",@"15:30~16:00",@"16:00~16:30",@"16:30~17:00",@"17:00~17:30",@"17:30~18:00",@"18:00~18:30",@"18:30~19:00",@"19:00~19:30",@"19:30~20:00",@"20:00~20:30",@"20:30~21:00",@"21:00~21:30",@"21:30~22:00",@"22:00~22:30",@"22:30~23:00",@"23:00~23:30",@"23:30~24:00", nil];

        [dataSingleTon initData];
    });
    
    return dataSingleTon;
}


-(void)initData
{
    
    NSMutableArray *dateStrArray = [self getDateStrArraySinceDate:[NSDate date]];
    NSMutableArray *settingStrArray  = [self getDateSettingStrArray];
    
    if (dateStrArray.count == settingStrArray.count) {
        for (int i = 0; i <dateStrArray.count; i ++) {
            NSString *dateStr  =[dateStrArray safeObjectAtIndex:i];
            NSString *settingStr = [settingStrArray safeObjectAtIndex:i];
            AppointmentMoel *model = [[AppointmentMoel alloc] init];
            model.date  = dateStr;
            model.settings = settingStr;
            [self.modelArray addObject:model];
        }
    }

}


-(NSMutableArray *)getDateStrArraySinceDate:(NSDate *)date
{
    NSMutableArray *retunrArray = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < 7; i ++) {
        NSString *dateStr = [XuUtlity stringFromDate:date forDateFormatterStyle:DateFormatterDate];
        [retunrArray addObject:dateStr];
        date = [NSDate dateWithTimeInterval:86400 sinceDate:date];
    }
    
    return retunrArray;
}


-(NSMutableArray *)getDateSettingStrArray
{
    NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:7];
    for ( int i = 0; i < 7; i ++) {
        NSString *settingStr = @"";
        for (int j = 0; j < 36 ; j++) {
            settingStr = [settingStr stringByAppendingString:@",1"];
        }
        if ([settingStr hasPrefix:@","]) {
            settingStr = [settingStr substringFromIndex:1];
        }
        [returnArray addObject:settingStr];
    }
    return returnArray;
}



//-(NSMutableArray *)commitArray
//{
//    if (!_commitArray) {
//        _commitArray = [NSMutableArray arrayWithCapacity:10];
//    }
//    return _commitArray;
//}


-(NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray arrayWithCapacity:7];
    }
    return _modelArray;
}

-(nullable NSString *)objectToJsonStr:(nullable id )object

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


-(void)resetData
{
    for (int i = 0; i < self.modelArray.count; i ++) {
        AppointmentMoel *model = [self.modelArray safeObjectAtIndex:i];
        model.settings = @"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
    }
}

@end
