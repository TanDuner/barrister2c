//
//  ShareCosumeListCell.m
//  barrister2c
//
//  Created by 徐书传 on 17/5/6.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "ShareCosumeListCell.h"

@interface ShareCosumeListCell ()


@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *phoneLabel;
@property (strong, nonatomic) UILabel *tipLabel;
@end

@implementation ShareCosumeListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.timeLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}



+(CGFloat)getCellHeightWithModel:(ShareCosumeModel *)model
{
    return 60;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.timeLabel setFrame:RECT(LeftPadding, 10, 150, 15)];
    [self.phoneLabel setFrame:RECT(LeftPadding, self.timeLabel.y, 200, 15)];
    [self.tipLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.phoneLabel.frame) + 10, SCREENWIDTH - 20, 15)];
    
    
}

-(void)configData
{
    [super configData];
    self.timeLabel.text = self.model.consumeTime;
    self.phoneLabel.text = self.model.consumerPhone;
    self.tipLabel.text = [NSString stringWithFormat:@"消费了一次，提成%@元",self.model.money];
    
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [kSeparatorColor setStroke];
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [linePath stroke];
    
}


#pragma -mark --Getter-----

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10, 150, 15)];
        _timeLabel.font = SystemFont(14.0f);
        _timeLabel.numberOfLines = 0;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = KColorGray222;
    }
    return _timeLabel;
}

-(UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.timeLabel.y, 200, 15)];
        _phoneLabel.numberOfLines = 0;
        _phoneLabel.font = SystemFont(14.0f);
        _phoneLabel.numberOfLines = 0;
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.textColor = KColorGray666;
        
    }
    return _phoneLabel;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.phoneLabel.frame) + 10, SCREENWIDTH - 20, 15)];
        _tipLabel.font = SystemFont(14.0f);
        _tipLabel.textAlignment = NSTextAlignmentRight;
        _tipLabel.textColor = KColorGray333;
        
    }
    return _tipLabel;
}




@end
