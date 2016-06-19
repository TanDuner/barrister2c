//
//  PersonCenterCustomCell.m
//  barrister
//
//  Created by 徐书传 on 16/3/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "PersonCenterCustomCell.h"

#define IconWidht 30

@interface PersonCenterCustomCell ()

@property (nonatomic,strong) UIImageView *iconImageIVew;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *rightRow;
@property (nonatomic,strong) UILabel *subTitleLabel;

@end

@implementation PersonCenterCustomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconImageIVew];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightRow];
        [self addSubview:self.subTitleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageIVew setFrame:RECT(LeftPadding + 5, ([PersonCenterCustomCell getCellHeight] - IconWidht)/2.0, IconWidht, IconWidht)];
    [self.titleLabel setFrame:RECT(self.iconImageIVew.x + self.iconImageIVew.width + 15, ([PersonCenterCustomCell getCellHeight] - 15)/2.0, SCREENWIDTH - 100, 15)];
    [self.rightRow setFrame:CGRectMake(SCREENWIDTH - 15 - 15, self.titleLabel.y, 15, 15)];
    [self.subTitleLabel setFrame:RECT(SCREENWIDTH - 15 - 100, self.titleLabel.y, 100, 15)];
}


-(void)configData
{
    if (self.model) {
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.model.iconNameStr ofType:nil]];
        self.iconImageIVew.image = image;
        self.titleLabel.text = self.model.titleStr;
        
        if (self.model.isShowArrow) {
            self.rightRow.hidden = NO;
            self.subTitleLabel.hidden = YES;
        }
        else {
            self.rightRow.hidden = YES;
            self.subTitleLabel.hidden = NO;
            self.subTitleLabel.text = self.model.subtitleStr;
        }
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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)getCellHeight
{
    return LeftPadding*2 + IconWidht;
}

#pragma -mark ------Getter----------


-(UIImageView *)iconImageIVew
{
    if (!_iconImageIVew) {
        _iconImageIVew = [[UIImageView alloc] init];
    }
    return _iconImageIVew;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KColorGray222;
        _titleLabel.font = SystemFont(15.0f);
    }
    return _titleLabel;
}


-(UIImageView*)rightRow
{
    if (!_rightRow) {
        _rightRow = [[UIImageView alloc] init];
        _rightRow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rightRow.png" ofType:nil]];
        _rightRow.hidden = YES;

    }
    return _rightRow;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = KColorGray333;
        _subTitleLabel.font = [UIFont systemFontOfSize:13.0f];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        _subTitleLabel.hidden = YES;
    }
    return _subTitleLabel;
}

@end
