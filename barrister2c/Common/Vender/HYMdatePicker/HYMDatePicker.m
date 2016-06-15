//
//  HYMDatePicker.m
//  HYMDatePicker
//
//  Created by 我家有福 on 16/3/10.
//  Copyright © 2016年 我家有福. All rights reserved.
//

#import "HYMDatePicker.h"

#define CHOOSE_DAY_COUNT 7 //可选时间天数
#define CHOOSE_MIN_HOUR  9 //可选最小时段
#define CHOOSE_MAX_HOUR  19 //可选最大时段

@interface HYMDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>
//pickerView数据源
@property (strong, nonatomic) NSArray *dataSourceForDayComponent;
@property (strong, nonatomic) NSArray *dataSourceForHourComponent;
@property (strong, nonatomic) NSArray *dataSourceForMinuteComponent;
@end

@implementation HYMDatePicker


- (instancetype)init{
    self = [super init];
    if(self){
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}


#pragma mark - 初始化
- (NSString *)day{
    if(!_day){
        if(self.hour.length > 0)
            _day = self.dataSourceForDayComponent[0];
    }
    return _day;
}
- (NSString *)hour{
    if(!_hour){
        _hour = self.dataSourceForHourComponent[0];
    }
    return _hour;
}
- (NSString *)minute{
    if(!_minute){
        _minute = @"00分";
    }
    return _minute;
}

- (NSArray *)dataSourceForDayComponent{
    if(!_dataSourceForDayComponent){
        NSMutableArray *arr = [NSMutableArray array];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *str = [NSString stringWithFormat:@"%@ 00:00:00",[formatter stringFromDate:[NSDate date]]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *baseDate = [formatter dateFromString:str];
        NSLog(@" %@",str);
        for (NSInteger i = 0; i < CHOOSE_DAY_COUNT; i++) {
            if(i >= 2){
                NSDate *date = [NSDate dateWithTimeInterval:24*60*60*i sinceDate:baseDate];
                [formatter setDateFormat:@"M月dd日EE"];
                NSMutableString *dateStr = [[formatter stringFromDate:date] mutableCopy];
                NSLog(@" %@",dateStr);
                [arr addObject:dateStr];
            }else if(i == 0){
                [arr addObject:@"今天"];
            }else if (i == 1){
                [arr addObject:@"明天"];
            }
            
        }
        _dataSourceForDayComponent = [arr copy];
    }
    return _dataSourceForDayComponent;
}
- (NSArray *)dataSourceForHourComponent{
    if(!_dataSourceForHourComponent){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:@"HH"];
        NSString *str = [formatter stringFromDate:[NSDate date]];
        if([str integerValue] < CHOOSE_MIN_HOUR){
            NSMutableArray *arr = [NSMutableArray array];
            for (NSInteger i = CHOOSE_MIN_HOUR; i < CHOOSE_MAX_HOUR+1; i++){
                if(i < 10){
                    [arr addObject:[NSString stringWithFormat:@"0%d时",CHOOSE_MIN_HOUR]];
                }else{
                    [arr addObject:[NSString stringWithFormat:@"%ld时",i]];
                }
                
            }
            _dataSourceForHourComponent = [arr copy];
        }else if ([str integerValue] >= CHOOSE_MAX_HOUR){
            
            if([self.dataSourceForDayComponent[0] isEqualToString:@"今天"]){
                NSMutableArray *arr = [self.dataSourceForDayComponent mutableCopy];
                [arr removeObjectAtIndex:0];
                self.dataSourceForDayComponent = arr;
            }
            NSMutableArray *arr = [NSMutableArray array];
            for (NSInteger i = CHOOSE_MIN_HOUR; i < CHOOSE_MAX_HOUR+1; i++){
                if(i < 10){
                    [arr addObject:[NSString stringWithFormat:@"0%d时",CHOOSE_MIN_HOUR]];
                }else{
                    [arr addObject:[NSString stringWithFormat:@"%ld时",i]];
                }
                
            }
            _dataSourceForHourComponent = [arr copy];
        }else{
            NSMutableArray *arr = [NSMutableArray array];
            for (NSInteger i = [str integerValue]+1; i < CHOOSE_MAX_HOUR+1; i++){
                if(i < 10){
                    [arr addObject:[NSString stringWithFormat:@"0%d时",CHOOSE_MIN_HOUR]];
                }else{
                    [arr addObject:[NSString stringWithFormat:@"%ld时",i]];
                }
                
            }
            _dataSourceForHourComponent = [arr copy];
        }
        
    }
    return _dataSourceForHourComponent;
}
- (NSArray *)dataSourceForMinuteComponent{
    if(!_dataSourceForMinuteComponent){
        _dataSourceForMinuteComponent = @[@"00分",@"30分"];
    }
    return _dataSourceForMinuteComponent;
}


#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger i = self.dataSourceForHourComponent.count;
    switch (component) {
        case 0:
            return self.dataSourceForDayComponent.count;
            break;
        case 1:
            return self.dataSourceForHourComponent.count;
            break;
        case 2:
            return self.dataSourceForHourComponent.count==0?0:self.dataSourceForMinuteComponent.count;
            break;
        default:
            return 0;
            break;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.dataSourceForDayComponent[row];
            break;
        case 1:
            return self.dataSourceForHourComponent[row];
            break;
        case 2:
            return self.dataSourceForMinuteComponent[row];
            break;
        default:
            return 0;
            break;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0 && row != 0){
        //选择的day不是今天
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = CHOOSE_MIN_HOUR; i < CHOOSE_MAX_HOUR+1; i++){
            if(i < 10){
                [arr addObject:[NSString stringWithFormat:@"0%d时",CHOOSE_MIN_HOUR]];
            }else{
                [arr addObject:[NSString stringWithFormat:@"%ld时",i]];
            }
            
        }
        self.dataSourceForHourComponent = arr;
        self.hour = nil;
        self.minute = nil;
        [self reloadComponent:1];
        [self reloadComponent:2];
        [self selectRow:0 inComponent:1 animated:YES];
        [self selectRow:0 inComponent:2 animated:YES];
    }else if(component == 0 && row == 0){
        //选择的day是今天
        self.dataSourceForHourComponent = nil;
        self.hour = nil;
        self.minute = nil;
        [self reloadComponent:1];
        [self reloadComponent:2];
        [self selectRow:0 inComponent:1 animated:YES];
        [self selectRow:0 inComponent:2 animated:YES];
    }else if (component == 1){
        //选择了新的小时
        self.minute = nil;
        [self reloadComponent:2];
        [self selectRow:0 inComponent:2 animated:YES];
    }
    //
    switch (component) {
        case 0:
            self.day = self.dataSourceForDayComponent[row];
            break;
        case 1:
            self.hour = self.dataSourceForHourComponent[row];
            break;
        case 2:
            self.minute = self.dataSourceForMinuteComponent[row];
            break;
        default:
            break;
    }
    [self selectedDate];
}
- (void)selectedDate{
    NSLog(@"HYM选择时间 %@ %@ %@",self.day,self.hour,self.minute);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy年"];
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *dateStr = [NSString stringWithFormat:@"%@%@ %@%@",str,self.day,self.hour,self.minute];
    if([self.day isEqualToString:@"今天"]){
        [formatter setDateFormat:@"MM月dd日EE"];
        self.day = [formatter stringFromDate:[NSDate date]];
    }else if ([self.day isEqualToString:@"明天"]){
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *str = [NSString stringWithFormat:@"%@ 00:00:00",[formatter stringFromDate:[NSDate date]]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *baseDate = [formatter dateFromString:str];
        [formatter setDateFormat:@"MM月dd日EE"];
        self.day = [formatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:baseDate]];
    }
    [formatter setDateFormat:@"yyyy年MM月dd日EE HH时mm分"];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"HYM%@",[formatter stringFromDate:date]);
    if(self.delegateDiy && [self.delegateDiy respondsToSelector:@selector(currentSelectedDate:)]){
        [self.delegateDiy currentSelectedDate:date];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [UIScreen mainScreen].bounds.size.width*0.5;
            break;
        case 1:
            return [UIScreen mainScreen].bounds.size.width*0.25;
            break;
        case 2:
            return [UIScreen mainScreen].bounds.size.width*0.25;
            break;
        default:
            return [UIScreen mainScreen].bounds.size.width*0.25;
            break;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
