//
//  MyAccountHeadView.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyAccountHeadView.h"

@implementation MyAccountHeadView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.remainLabel];
        [self addSubview:self.remainTipLabel];
        self.backgroundColor = kNavigationBarColor;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.remainLabel.text = @"689.79";
}


#pragma -mark ---Getter---

-(UILabel *)remainTipLabel
{
    if (!_remainTipLabel) {
        _remainTipLabel = [[UILabel alloc] initWithFrame:RECT(0, 73, SCREENWIDTH, 13)];
        _remainTipLabel.textColor = [UIColor whiteColor];
        _remainTipLabel.textAlignment = NSTextAlignmentCenter;
        _remainTipLabel.text = @"余额(元)";
    }
    return _remainTipLabel;
}


-(UILabel *)remainLabel
{
    if (!_remainLabel) {
        _remainLabel = [[UILabel alloc] initWithFrame:RECT(0, 28, SCREENWIDTH, 28)];
        _remainLabel.textColor = [UIColor whiteColor];
        _remainLabel.textAlignment = NSTextAlignmentCenter;
        _remainLabel.font = SystemFont(30.0f);
        
    }
    return _remainLabel;
}

@end
