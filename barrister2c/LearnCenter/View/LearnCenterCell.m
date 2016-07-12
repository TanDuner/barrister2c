//
//  LearnCenterCell.m
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LearnCenterCell.h"
#import "YYWebImage.h"

@interface LearnCenterCell ()

@property (nonatomic,strong) YYAnimatedImageView *leftImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation LearnCenterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.leftImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.leftImageView setFrame:RECT(LeftPadding, LeftPadding + 5, 100, 60)];
    if (self.model) {
        if (IS_NOT_EMPTY(self.model.thumb)) {
            self.leftImageView.hidden = NO;
            [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:self.model.thumb] placeholder:[UIImage imageNamed:@"timeline_image_loading"]];
            [self.titleLabel setFrame:RECT(self.leftImageView.x + self.leftImageView.width + 10, self.leftImageView.y, SCREENWIDTH - LeftPadding *2 - CGRectGetMaxX(self.leftImageView.frame) - LeftPadding, 15)];
            [self.timeLabel setFrame:CGRectMake(SCREENWIDTH - 160, self.height - 25, 150, 15)];
            
        }
        else
        {
            self.leftImageView.hidden = YES;
            [self.titleLabel setFrame:RECT(LeftPadding, LeftPadding, SCREENWIDTH - LeftPadding *2, 40)];
            self.titleLabel.numberOfLines = 3;
            [self.timeLabel setFrame:CGRectMake(SCREENWIDTH - 160, self.height - 25, 150, 15)];
            
        }
    }
}


-(void)configData
{
    [super configData];
    
    self.titleLabel.text = self.model.title;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",self.model.date];
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [kSeparatorColor setStroke];
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [linePath stroke];
    
}

#pragma -mark ------Getter----------


-(YYAnimatedImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[YYAnimatedImageView alloc] init];
    }
    return _leftImageView;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KColorGray333;
        _titleLabel.font = SystemFont(15.0f);
    }
    return _titleLabel;
}




-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = KColorGray999;
        _timeLabel.font = SystemFont(13.0f);
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}


@end
