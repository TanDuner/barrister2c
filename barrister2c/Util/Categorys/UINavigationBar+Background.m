//
//  UINavigationBar+Background.m
//  CustomNavicationController
//
//  Created by shanpengtao on 16/5/20.
//  Copyright (c) 2016年 shanpengtao. All rights reserved.
//
#import <objc/runtime.h>
#import "UINavigationBar+Background.h"

@implementation UINavigationBar (Background)

static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNavigationBarBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    
    self.overlay.backgroundColor = backgroundColor;
}

- (void)setNavigationBarTitleColor:(UIColor *)titleColor
{
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : titleColor} ;
    
    [self setTitleTextAttributes : attributes];
}

- (void)navigationBarReset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.overlay removeFromSuperview];
    
    self.overlay = nil;
    
    [self setNavigationBarTitleColor:KColorGray666];
    
    self.barStyle = UIBarStyleDefault;
}

@end
