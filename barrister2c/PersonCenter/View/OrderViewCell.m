//
//  OrderViewCell.m
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderViewCell.h"
#import "YYWebImage.h"
#import "CALayer+YYAdd.h"

@interface OrderViewCell ()

/**
 *  头像
 */
@property (nonatomic,strong) UIImageView *headerImageView;

/**
 *  用户名称Label
 */
@property (nonatomic,strong) UILabel *nameLabel;

/**
 * 时间Lable
 */
@property (nonatomic,strong) UILabel *timeLabel;

/**
 *  类型Label
 */

@property (nonatomic,strong) UILabel *typeLabel;

@end

@implementation OrderViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headerImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.typeLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.headerImageView setFrame:RECT(LeftPadding, LeftPadding + 5, 45, 45)];
    [self.nameLabel setFrame:RECT(self.headerImageView.x + self.headerImageView.width + 10, self.headerImageView.y, 150, 15)];
    [self.typeLabel setFrame:CGRectMake(SCREENWIDTH - 160, LeftPadding + 5, 150, 15)];
    [self.timeLabel setFrame:CGRectMake(self.nameLabel.x, self.nameLabel.y + self.nameLabel.height + 10, 250, 15)];
}


-(void)configData
{
    [super configData];
    
    if (self.model) {
        [self.headerImageView yy_setImageWithURL:[NSURL URLWithString:self.model.userIcon] placeholder:[UIImage imageNamed:@"timeline_image_loading"]];
        self.nameLabel.text = self.model.name;
        if (self.model.orderType == BarristerOrderTypeJSZX) {
            self.timeLabel.text = [NSString stringWithFormat:@"%@",self.model.orderTime];
        }
        else
        {
            self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",self.model.startTime,self.model.endTime];
        }
        self.typeLabel.text = [NSString stringWithFormat:@"类型:%@",self.model.caseType];
    }
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


-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = KColorGray333;
        _nameLabel.font = SystemFont(15.0f);
    }
    return _nameLabel;
}

-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        [_headerImageView.layer setCornerRadius:22.5f];
        [_headerImageView.layer setMasksToBounds:YES];

    }
    return _headerImageView;
}

-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = KColorGray999;
        _timeLabel.font = SystemFont(13.0f);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

-(UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textColor = KColorGray999;
        _typeLabel.font = SystemFont(13.0f);
        _typeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _typeLabel;
}


@end
