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
@property (nonatomic,strong) UILabel *typeLabel;
@end

@implementation MyAccountDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.typeLabel];
        [self addSubview:self.handleLabel];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    self.titleLabel.text = [NSString stringWithFormat:@"流水号:%@",self.model.serialNum];
    self.timeLabel.text = self.model.date;
    
    
    if ([self.model.type isEqualToString:TYPE_ORDER]) {
        self.typeLabel.text = @"订单消费";
        self.handleLabel.text = [NSString stringWithFormat:@"-%@",self.model.money];
    }
    else if ([self.model.type isEqualToString:TYPE_GET_MONEY])
    {
        self.typeLabel.text = @"提现";
        self.handleLabel.text = [NSString stringWithFormat:@"-%@",self.model.money];
    }
    else if([self.model.type isEqualToString:TYPE_REWARD])
    {
        self.typeLabel.text = @"订单打赏";
        self.handleLabel.text = [NSString stringWithFormat:@"-%@",self.model.money];
    }
    else if ([self.model.type isEqualToString:TYPE_RECHARGE])
    {
        self.typeLabel.text = @"充值";
        self.handleLabel.text = [NSString stringWithFormat:@"+%@",self.model.money];
        
    }
    else if ([self.model.type isEqualToString:TYPE_BACK])
    {
        self.typeLabel.text = @"系统退款";
        self.handleLabel.text = [NSString stringWithFormat:@"+%@",self.model.money];
    }
    _handleLabel.textColor = [UIColor greenColor];

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
        [_titleLabel setFrame:RECT(10, 10, 240, 12)];
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
        [_timeLabel setFrame:RECT(10, self.titleLabel.y + self.titleLabel.height + 15, 240, 10)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = KColorGray666;
    }
    return _timeLabel;
}

-(UILabel *)handleLabel
{
    if (!_handleLabel) {
        _handleLabel = [[UILabel alloc] init];
        _handleLabel.frame = RECT(SCREENWIDTH - 80 - 10, 35, 80, 15);
        _handleLabel.font = SystemFont(20);
        _handleLabel.textColor = [UIColor greenColor];
        _handleLabel.textColor = KColorGray222;
        _handleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _handleLabel;
}

-(UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        [_typeLabel setFrame:RECT(SCREENWIDTH - 80 - 10, LeftPadding, 80, 13)];
        _typeLabel.font = SystemFont(13.0f);
        _typeLabel.textColor = KColorGray666;
        _typeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _typeLabel;
}
@end
