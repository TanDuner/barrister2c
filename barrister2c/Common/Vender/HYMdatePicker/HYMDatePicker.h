//
//  HYMDatePicker.h
//  HYMDatePicker
//
//  Created by 我家有福 on 16/3/10.
//  Copyright © 2016年 我家有福. All rights reserved.
//



//#import "ViewController.h"
//#import "HYMDatePicker.h"
//
//@interface ViewController () <HYMDatePickerDelegate>
//@property (strong, nonatomic) HYMDatePicker *datePicker;
//@property (strong, nonatomic) UILabel *timeLabel;
//@end
//
//@implementation ViewController
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    self.datePicker = [[HYMDatePicker alloc] init];
//    self.datePicker.delegateDiy = self;
//    self.datePicker.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height*0.5);
//    [self.view addSubview:self.datePicker];
//    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
//    self.timeLabel.center = CGPointMake(self.view.center.x, self.view.center.y*1.25);
//    self.timeLabel.textColor = [UIColor redColor];
//    self.timeLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.timeLabel];
//}
//- (void)currentSelectedDate:(NSDate *)a{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSLog(@"选中的时间 %@",[formatter stringFromDate:a]);
//    self.timeLabel.text = [formatter stringFromDate:a];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}




#import <UIKit/UIKit.h>
@protocol HYMDatePickerDelegate;
@interface HYMDatePicker : UIPickerView
@property (strong, nonatomic) id<HYMDatePickerDelegate> delegateDiy;
//已选择时间
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *hour;
@property (strong, nonatomic) NSString *minute;

@end

@protocol HYMDatePickerDelegate <NSObject>
@optional
- (void)currentSelectedDate:(NSDate *)a;
@end