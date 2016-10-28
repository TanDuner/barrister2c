//
//  HomeMonenyCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "HomeMonenyCell.h"

#define LabelWidht (SCREENWIDTH - 1)/2.0
#define SelfHeight 68
#define ButtonWidth  (SCREENWIDTH - 1)/3.0

@implementation HomeMonenyCell

+(CGFloat)getCellHeight
{
    return SelfHeight;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = kBaseViewBackgroundColor;
        [self addSubview:self.jishiButton];
        [self addSubview:self.yuyueButton];
        [self addSubview:self.zhuanjiaButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.jishiButton setFrame:RECT(0, 0, ButtonWidth, SelfHeight)];
    [self.yuyueButton setFrame:RECT(ButtonWidth + .5, 0, ButtonWidth, SelfHeight)];
    [self.zhuanjiaButton setFrame:RECT(2 *ButtonWidth + 1, 0, ButtonWidth, SelfHeight)];
}


#pragma -mark ---
#pragma -mark ---Getter--


-(UIButton *)jishiButton
{
    if (!_jishiButton) {
        _jishiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jishiButton setTitle:@"即时咨询" forState:UIControlStateNormal];
        _jishiButton.titleLabel.font = SystemFont(14.0f);
        _jishiButton.backgroundColor = [UIColor whiteColor];
        [_jishiButton setTitleColor:KColorGray333 forState:UIControlStateNormal];
        _jishiButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_jishiButton setImage:[UIImage imageNamed:@"JSZX"] forState:UIControlStateNormal];
        [_jishiButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jishiButton;
}

-(UIButton *)yuyueButton
{
    if (!_yuyueButton) {
        _yuyueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yuyueButton setTitle:@"预约咨询" forState:UIControlStateNormal];
        _yuyueButton.titleLabel.font = SystemFont(14.0f);
        _yuyueButton.backgroundColor = [UIColor whiteColor];
        [_yuyueButton setTitleColor:KColorGray333 forState:UIControlStateNormal];
        _yuyueButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_yuyueButton setImage:[UIImage imageNamed:@"YYZX"] forState:UIControlStateNormal];
        [_yuyueButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yuyueButton;
}



-(UIButton *)zhuanjiaButton
{
    if (!_zhuanjiaButton) {
        _zhuanjiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zhuanjiaButton setTitle:@"专家咨询" forState:UIControlStateNormal];
        _zhuanjiaButton.titleLabel.font = SystemFont(14.0f);
        _zhuanjiaButton.backgroundColor = [UIColor whiteColor];
        [_zhuanjiaButton setTitleColor:KColorGray333 forState:UIControlStateNormal];
        _zhuanjiaButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_zhuanjiaButton setImage:[UIImage imageNamed:@"zhuanjia"] forState:UIControlStateNormal];
        [_zhuanjiaButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zhuanjiaButton;
}


-(void)clickAction:(UIButton *)button
{
    NSString *type;
    
    if (button == self.jishiButton) {
        type = @"IM";
    }
    else if (button == self.yuyueButton)
    {
        type = @"APPOINMENT";
    }
    else if (button == self.zhuanjiaButton)
    {
        type = @"EXPERT";
    }
    
    if (self.clickBlock) {
        self.clickBlock(type);
    }
    
    
}

@end
