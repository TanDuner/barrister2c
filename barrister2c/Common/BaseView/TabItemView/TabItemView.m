//
//  TabItemView.m
//  Demo
//
//  Created by Liuxl on 14/12/3.
//  Copyright (c) 2014年 Hollance. All rights reserved.
//

#import "TabItemView.h"
#import "BaseCommonHeader.h"

@interface TabItemView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) TabItemHandler handle;

@end

@implementation TabItemView

@synthesize selected = _selected;

- (id)initWithFrame:(CGRect)frame handel:(TabItemHandler)handel
{
    if( (self = [super initWithFrame:frame]) )
    {
        _handle = handel;
        [self configure];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0f, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(context);

    if(self.selected)
    {
        CGContextSetStrokeColorWithColor(context, kNavigationBarColor.CGColor);
        CGContextSetLineWidth(context, 3);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0.0f, self.frame.size.height-2);
        CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height-2);
        CGContextStrokePath(context);
    }
}

#pragma mark -
#pragma mark - -

- (void)configure
{
    self.backgroundColor = kBaseViewBackgroundColor;
    
    [self addSubview:self.button];
}

- (void)clickAction:(UIButton *)button
{
    if (self.handle) {
        self.handle(self);
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = SystemFont(14.0f);
        _titleLabel.textColor = kFontColorNormalJump;
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (BadgeNumberView *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[BadgeNumberView alloc] init];
        
        [self addSubview:_badgeView];
    }
    
    return _badgeView;
}

#pragma mark -
#pragma mark - property

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    self.button.selected = _selected;
    
    if (_selected) {
        _titleLabel.textColor = kNavigationBarColor;
    }
    else {
        _titleLabel.textColor = kFontColorNormalJump;
    }
    
    [self setNeedsDisplay];
}

- (void)setTabTitle:(NSString *)tabTitle
{
    if (tabTitle) {
        [self titleLabel].text = tabTitle;
    }
}

- (void)setBadgeNumber:(NSInteger)badgeNumber
{
    _badgeNumber = badgeNumber;
    
    if (_badgeNumber > 0) {
        [self badgeView].badgeNumber = _badgeNumber;
    }
    else {
        if (_badgeView) {
            _badgeView.badgeNumber = _badgeNumber;
        }
    }
}

- (UIButton *)button
{
    if (_button)
        return _button;
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return _button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_titleLabel) {
        CGSize size = [_titleLabel.text sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(self.width, self.height)];
        _titleLabel.frame = CGRectMake((self.width - size.width) / 2.0f, (self.height - size.height) / 2.0f, size.width, size.height);
    }
    
    if (_badgeView) {
        _badgeView.frame = CGRectMake(_titleLabel.x + _titleLabel.width + 4.0f, (self.height - _badgeView.height) / 2.0f, [_badgeView sizeForbadgeNumberView].width, [_badgeView sizeForbadgeNumberView].height);
    }
}

@end
