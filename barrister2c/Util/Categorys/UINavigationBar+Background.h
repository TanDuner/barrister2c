//
//  UINavigationBar+Background.h
//  CustomNavicationController
//
//  Created by shanpengtao on 16/5/20.
//  Copyright (c) 2016年 shanpengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Background)

/**
 *  设置导航栏背景颜色
 */
- (void)setNavigationBarBackgroundColor:(UIColor *)backgroundColor;

/**
 *  设置导航栏标题颜色
 */
- (void)setNavigationBarTitleColor:(UIColor *)titleColor;

/**
 *  导航栏重置
 */
- (void)navigationBarReset;

@end
