//
//  BadgeNumberView.m
//  WXD
//
//  Created by Fantasy on 14-11-19.
//  Copyright (c) 2014年 JD.COM. All rights reserved.
//

#import "BadgeNumberView.h"
//#import "Constant.h"

@implementation BadgeNumberView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initBadgeView];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initBadgeView];
    }
    
    return self;
}

- (void)initBadgeView
{
    CGRect frame = self.frame;
    _badgeNumberView = [[UIImageView alloc] initWithFrame:frame];
    _badgeNumberView.image = [[UIImage imageNamed:@"newindex_bubble_1"] resizableImageWithCapInsets:UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f)];
    
    [self addSubview:_badgeNumberView];
    
    _badgeNumberLabel = [[UILabel alloc] initWithFrame:frame];
    _badgeNumberLabel.font = SystemFont(13);
    _badgeNumberLabel.backgroundColor = [UIColor clearColor];
    _badgeNumberLabel.textColor = kButtonColor1Normal;
    
    [self addSubview:_badgeNumberLabel];
}

- (void)layoutSubviews
{
    if (_style == BadgeNumberViewStyleNumber)
    {
        _badgeNumberView.image = [[UIImage imageNamed:@"newindex_bubble_1"] resizableImageWithCapInsets:UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f)];

        if (_badgeNumber > 0)
        {
            self.hidden = NO;
            
            NSString *unreadString = nil;
            
            if (_badgeNumber > 99)
            {
                unreadString = @"99+";
            }
            else
            {
                unreadString = [[NSString alloc] initWithFormat:@"%ld", (long)_badgeNumber];
            }
            
            CGSize size = [unreadString sizeWithFont:_badgeNumberLabel.font];
            
            CGFloat width = size.width + 8.0f;
            if (width < 16.0f) {
                width = 16.0f;
            }
            
            _badgeNumberView.frame = CGRectMake(0, 0, width, 16);
            
            CGRect frame = CGRectMake((width - size.width) / 2.0f + 0.5f, (_badgeNumberView.height - size.height) / 2.0f, size.width, size.height);
            _badgeNumberLabel.frame = frame;
            _badgeNumberLabel.text = unreadString;
            
            self.size = _badgeNumberView.size;
        }
        else {
            self.hidden = YES;
        }
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"newindex_bubble_1"];
        
        _badgeNumberView.image = image;
        _badgeNumberView.size = image.size;
    }
}

- (CGSize)sizeForbadgeNumberView
{
    if (_style == BadgeNumberViewStyleNumber)
    {
        NSString *unreadString = nil;
        
        if (_badgeNumber > 99)
        {
            unreadString = [[NSString alloc] initWithFormat:@"%ld+", (long)_badgeNumber];
        }
        else
        {
            unreadString = [[NSString alloc] initWithFormat:@"%ld", (long)_badgeNumber];
        }
        
        CGSize size = [unreadString sizeWithFont:_badgeNumberLabel.font];
        
        CGFloat width = size.width + 8.0f;
        if (width < 16.0f) {
            width = 16.0f;
        }
        
        return CGSizeMake(width, width);
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"newindex_bubble_1"];

        return image.size;
    }
}

- (void)setBadgeNumber:(NSInteger)badgeNumber
{
    _badgeNumber = badgeNumber;
    
    [self layoutSubviews];
}

- (void)setStyle:(BadgeNumberViewStyle)style
{
    _style = style;
    
    [self layoutSubviews];
}

@end
