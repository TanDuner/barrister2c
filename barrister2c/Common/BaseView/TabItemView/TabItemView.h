//
//  TabItemView.h
//  Demo
//
//  Created by Liuxl on 14/12/1.
//  Copyright (c) 2014年 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeNumberView.h"

@class TabItemView;
typedef void(^TabItemHandler)(TabItemView *tabItem);

@interface TabItemView : UIView {
@private
    BadgeNumberView *_badgeView;
    UILabel *_titleLabel;
}

@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic, strong) NSString *tabTitle;
@property (nonatomic, assign) NSInteger badgeNumber;

- (id)initWithFrame:(CGRect)frame handel:(TabItemHandler)handel;

@end
