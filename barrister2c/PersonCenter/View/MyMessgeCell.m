//
//  MyMessgeCell.m
//  barrister
//
//  Created by 徐书传 on 16/6/14.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyMessgeCell.h"

@interface MyMessgeCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *timeLabel;;
@end

@implementation MyMessgeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}

+(CGFloat)getCellHeightWithModel:(MyMessageModel *)model
{
    return LeftPadding + model.titleHeight + 8 + model.contentHeight + LeftPadding;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel setFrame:RECT(LeftPadding, 10, 200, self.model.titleHeight)];
    [self.subTitleLabel setFrame:RECT(LeftPadding, self.titleLabel.y + self.titleLabel.height + 10, SCREENWIDTH - 20, self.model.contentHeight)];
}

-(void)configData
{
    [super configData];
    self.titleLabel.text = self.model.title;
    self.subTitleLabel.text = self.model.content;
    self.timeLabel.text = self.model.date;
    
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

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10, 200, 12.5)];
        _titleLabel.font = SystemFont(14.0f);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = KColorGray222;
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.titleLabel.y + self.titleLabel.height + 10, SCREENWIDTH - 20, 12.5)];
        _subTitleLabel.font = SystemFont(14.0f);
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.textColor = KColorGray666;
        
    }
    return _subTitleLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:RECT(SCREENWIDTH - 150 - 10, 10, 150, 12.5)];
        _timeLabel.font = SystemFont(14.0f);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = KColorGray333;

    }
    return _timeLabel;
}



@end
