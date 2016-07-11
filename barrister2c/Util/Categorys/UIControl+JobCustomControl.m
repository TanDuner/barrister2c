//
//  UIControl+JobCustomControl.m
//  Demo
//
//  Created by shanpengtao on 16/4/26.
//  Copyright © 2016年 shanpengtao. All rights reserved.
//

#import "UIControl+JobCustomControl.h"
#import <objc/runtime.h>

@interface UIControl()

/**
 *  点击的时刻
 */
@property (nonatomic, assign) NSTimeInterval acceptEventTime;

@end

@implementation UIControl (JobCustomControl)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)acceptEventTime {
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    /* 获取系统方法 */
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    /* 自己定义方法 */
    Method myMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    SEL mySEL = @selector(custom_sendAction:to:forEvent:);
    
    /* 添加方法进去 */
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    if (didAddMethod) {
        /* 如果方法已经存在了 */
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }
    else {
        /* 方法不存在进行交换 */
        method_exchangeImplementations(systemMethod, myMethod);
    }
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (target == nil || ![target respondsToSelector:action]) {
        return;
    }
    
    if (NSDate.date.timeIntervalSince1970 - self.acceptEventTime < self.acceptEventInterval) {
        return;
    }
    
    if (self.acceptEventInterval > 0) {
        self.acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    [self custom_sendAction:action to:target forEvent:event];
}

@end
