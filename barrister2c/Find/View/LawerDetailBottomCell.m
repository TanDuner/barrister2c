//
//  LawerDetailBottomCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerDetailBottomCell.h"

#define ImageWidth 40


@implementation LawerDetailBottomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.leftImageView];
        [self addSubview:self.topLabel];
        [self addSubview:self.bottomLabel];
        [self addSubview:self.rightLabel];
    }
    return self;
}



-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [kSeparatorColor setStroke];
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [linePath stroke];
    
}

#pragma - mark --Getter--

-(UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, LeftPadding, ImageWidth, ImageWidth)];
        _leftImageView.layer.cornerRadius = 20.5f;
        _leftImageView.layer.masksToBounds = YES;
    }
    return _leftImageView;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:RECT(self.topLabel.x + self.topLabel.width + 10, LeftPadding , 100, 15)];
        _rightLabel.font = SystemFont(13.0f);
    }
    return _rightLabel;
}

-(UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding + ImageWidth + LeftPadding, LeftPadding, 200, 15)];
        _topLabel.textColor = KColorGray333;
        _topLabel.text = @"即时咨询";
        _topLabel.font = SystemFont(15.0f);
    }
    return _topLabel;
}

-(UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:RECT(self.topLabel.x , self.topLabel.y + self.topLabel.height + 10 , 200, 15)];
        _bottomLabel.textColor = KColorGray666;
        _bottomLabel.text = @"立即与律师沟通";
        _bottomLabel.font = SystemFont(15.0f);
    }
    return _bottomLabel;
}

@end
