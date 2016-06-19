//
//  MyAccountDetailCell.m
//  barrister
//
//  Created by 徐书传 on 16/5/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyAccountDetailCell.h"



@interface MyAccountDetailCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *handleLabel;

@end

@implementation MyAccountDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.handleLabel];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.text = self.model.titleStr;
    self.timeLabel.text = self.model.dateStr;
    if (self.model.handleType == 0) {
        self.handleLabel.text = [NSString stringWithFormat:@"+%@",self.model.numStr];
    }
    else
    {
        self.titleLabel.text = @"提现";
        self.handleLabel.text = [NSString stringWithFormat:@"-%@",self.model.numStr];
    }
}

+(CGFloat)getCellHeight
{
    return 60;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [kSeparatorColor setStroke];
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [linePath stroke];
    
}

#pragma -mark --Getter---
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = SystemFont(14);
        [_titleLabel setFrame:RECT(10, 22, 240, 12)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = KColorGray333;
    }
    return _titleLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = SystemFont(12);
        [_timeLabel setFrame:RECT(10, self.titleLabel.y + self.titleLabel.height + 10, 240, 10)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = KColorGray666;
    }
    return _timeLabel;
}

-(UILabel *)handleLabel
{
    if (!_handleLabel) {
        _handleLabel = [[UILabel alloc] init];
        _handleLabel.frame = RECT(SCREENWIDTH - 80 - 10, (60-13)/2.0, 80, 13);
        _handleLabel.font = SystemFont(17);
        _handleLabel.textColor = KColorGray222;
        _handleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _handleLabel;
}
@end
