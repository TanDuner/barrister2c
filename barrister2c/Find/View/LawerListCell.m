//
//  LawerListCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerListCell.h"
#import "YYWebImage.h"
#import "CWStarRateView.h"

#define ImageWidth 60

@interface LawerListCell ()

@property (nonatomic,strong) UIImageView *headImageView;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *yearsLabel;

@property (nonatomic,strong) UILabel *areaLabel;

@property (nonatomic,strong) UILabel *companyLabel;

@property (nonatomic,strong) UILabel *goodAtLabel;

@property (nonatomic,strong) CWStarRateView *starView;

@end

@implementation LawerListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.yearsLabel];
        [self addSubview:self.areaLabel];
        [self addSubview:self.companyLabel];
        [self addSubview:self.goodAtLabel];
        [self addSubview:self.starView];
    }
    return self;
}

//area = "\U5317\U4eac\U5e02,\U5317\U4eac\U5e02";
//bizAreas = "<null>";
//company = "<null>";
//id = 4;
//name = "\U5415\U4e16\U6c11";
//rating = 5;
//userIcon = "http://119.254.167.200:8080/upload/2016/06/26/1466939297447.jpg";
//workYears = 6;


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.headImageView setFrame:RECT(LeftPadding, 20, ImageWidth, ImageWidth)];
    
    CGFloat nameWidth = [XuUtlity textWidthWithStirng:self.model.name?self.model.name:@"  " ShowFont:SystemFont(15.0f) sizeHeight:13];
    [self.nameLabel setFrame:RECT(self.headImageView.x + self.headImageView.width + 10, 10, nameWidth, 13)];
    self.nameLabel.text = self.model.name;
    
    [self.yearsLabel setFrame:RECT(self.nameLabel.x + self.nameLabel.width + 5, self.nameLabel.y, 30, 13)];
    [self.yearsLabel setText:[NSString stringWithFormat:@"%@年",self.model.workYears?self.model.workYears:@"1"]];
    
    [self.areaLabel setFrame:RECT(self.nameLabel.x, self.nameLabel.y + self.nameLabel.height + 6, 240, 12)];
    self.areaLabel.text = self.model.area;
    
    [self.companyLabel setFrame:RECT(self.nameLabel.x, self.areaLabel.y + self.areaLabel.height + 6, 240, 12)];
    self.companyLabel.text = self.model.company;
    
    [self.goodAtLabel setFrame:RECT(self.nameLabel.x, self.companyLabel.y + self.companyLabel.height + 6, 260, 12)];
    self.goodAtLabel.text = self.model.goodAtStr;
    
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:self.model.userIcon] placeholder:[UIImage imageNamed:@"commom_default_head"]];

    [self.starView setFrame:RECT(SCREENWIDTH - 80 - 10, 10, 80, 15)];
    [self.starView setScorePercent:self.model.rating.floatValue/5.0];
}


+(CGFloat)getCellHeight
{
    return 90;

}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [kSeparatorColor setStroke];
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [linePath stroke];
    
}

#pragma -mark ---Getter----

-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageView.layer.cornerRadius = 30.0f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}


-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:RECT(self.headImageView.x + self.headImageView.width + 10, 20, ImageWidth, 13)];
        _nameLabel.textColor = KColorGray333;
        _nameLabel.font = SystemFont(15.0f);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"未知";
    }
    return _nameLabel;
}

-(UILabel *)yearsLabel
{
    if (!_yearsLabel) {
        _yearsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _yearsLabel.textColor = [UIColor whiteColor];
        _yearsLabel.font = SystemFont(12.0f);
        _yearsLabel.layer.cornerRadius  = 5;
        _yearsLabel.backgroundColor = kNavigationBarColor;
        _yearsLabel.layer.masksToBounds = YES;
        _yearsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yearsLabel;
}

-(UILabel *)areaLabel
{
    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _areaLabel.textColor = KColorGray666;
        _areaLabel.font = SystemFont(14.0f);
        _areaLabel.textAlignment = NSTextAlignmentLeft;
        _areaLabel.text = @"北京";
    }
    return _areaLabel;
}

-(UILabel *)companyLabel
{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 20, ImageWidth, ImageWidth)];
        _companyLabel.textColor = KColorGray666;
        _companyLabel.font = SystemFont(14.0f);
        _companyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _companyLabel;
}

-(UILabel *)goodAtLabel
{
    if (!_goodAtLabel) {
        _goodAtLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 20, ImageWidth, ImageWidth)];
        _goodAtLabel.textColor = KColorGray666;
        _goodAtLabel.font = SystemFont(14.0f);
        _goodAtLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _goodAtLabel;
}

-(CWStarRateView *)starView
{
    if (!_starView) {
        _starView = [[CWStarRateView alloc] initWithFrame:RECT(SCREENWIDTH - 80 - 10, 10, 80, 15) numberOfStars:5];
        _starView.isAllowTap = NO;
        _starView.hasAnimation = YES;
    }
    return _starView;
}


@end
