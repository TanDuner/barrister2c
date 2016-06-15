//
//  CityChooseViewController.h
//  yoyo
//
//  Created by YoYo on 16/5/12.
//  Copyright © 2016年 cn.yoyoy.mw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^CityBlock)(NSString *province, NSString *area); //定义一个代码块
@interface CityChooseViewController : BaseViewController
@property (copy, nonatomic) CityBlock cityInfo; //选择的城市信息
- (void)returnCityInfo:(CityBlock)block; //赋值的时候回调

@end
