//
//  BadgeNumberView.h
//  WXD
//
//  Created by Fantasy on 14-11-19.
//  Copyright (c) 2014年 JD.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    BadgeNumberViewStyleNumber,                 // 带数字
    BadgeNumberViewStyleJustDot                 // 只有红点
} BadgeNumberViewStyle;

@interface BadgeNumberView : UIView {
@private
    UIImageView *_badgeNumberView;
    UILabel *_badgeNumberLabel;
}

@property (nonatomic, assign) NSInteger badgeNumber;
@property (nonatomic, assign) BadgeNumberViewStyle style;

- (CGSize)sizeForbadgeNumberView;

@end
