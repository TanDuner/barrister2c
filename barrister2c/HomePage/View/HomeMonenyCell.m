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

@implementation HomeMonenyCell

+(CGFloat)getCellHeight
{
    return SelfHeight;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.remainTipLabel];
        [self addSubview:self.remainLabel];
        
        [self addSubview:[self getLineViewWithRect:RECT(LabelWidht, 18, 1, 32)]];
        
        [self addSubview:self.costTipLabel];
        [self addSubview:self.costLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.remainLabel.text = [BaseDataSingleton shareInstance].remainingBalance;
    
    self.costLabel.text = [BaseDataSingleton shareInstance].cost;
    
    
}


#pragma -mark ---
#pragma -mark ---Getter--


-(UILabel *)remainTipLabel
{
    if (!_remainTipLabel) {
        _remainTipLabel = [[UILabel alloc] initWithFrame:RECT(0, 17, LabelWidht, 12)];
        _remainTipLabel.textColor = RGBCOLOR(151, 152, 153);
        _remainTipLabel.font = SystemFont(14.0f);
        _remainTipLabel.text = @"余额";
        _remainTipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remainTipLabel;
}



-(UILabel *)remainLabel
{
    if (!_remainLabel) {
        _remainLabel = [[UILabel alloc] initWithFrame:RECT(0, SelfHeight - 16 - 14, LabelWidht, 14)];
        _remainLabel.textColor = RGBCOLOR(251, 156, 39);
        _remainLabel.font = SystemFont(18.0f);
        _remainLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remainLabel;
}




-(UILabel *)costTipLabel
{
    if (!_costTipLabel) {
        _costTipLabel = [[UILabel alloc] initWithFrame:RECT(LabelWidht +  1 + 0, 17, LabelWidht, 12)];
        _costTipLabel.textColor = RGBCOLOR(151, 152, 153);
        _costTipLabel.text = @"累计消费";
        _costTipLabel.textAlignment = NSTextAlignmentCenter;
        _costTipLabel.font = SystemFont(14.0f);
    }
    return _costTipLabel;
}



-(UILabel *)costLabel
{
    if (!_costLabel) {
        _costLabel = [[UILabel alloc] initWithFrame:RECT(LabelWidht +  1 + 0, SelfHeight - 16 - 14, LabelWidht, 14)];
        _costLabel.textColor = RGBCOLOR(251, 156, 39);
        _costLabel.textAlignment = NSTextAlignmentCenter;
        _costLabel.font = SystemFont(18.0f);
    }
    return _costLabel;
}



@end
