//
//  LawerDetailMidCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerDetailMidCell.h"

#define ButtonWidth (SCREENWIDTH - 1)/2.0
#define ButtonHeight 52


@interface LawerDetailMidCell ()

@property (nonatomic,strong) UIButton *serviceButton;

//@property (nonatomic,strong) UIButton *appraiseButton;

@property (nonatomic,strong) UIButton *collectButton;

@property (nonatomic,strong) UILabel *introduceTipLabel;

@property (nonatomic,strong) UILabel *introduceLabel;

@property (nonatomic,strong) UIButton *showAllButton;


@end

@implementation LawerDetailMidCell

+(CGFloat)getCellHeightWithModel:(BarristerLawerModel *)model
{
    if (model.isShowAll) {
        return model.showAllIntroduceViewHeight;
    }
    else
    {
        return model.showIntroduceViewHeight;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.serviceButton];
        
//        [self addSubview:self.appraiseButton];
        
        [self addSubview:self.collectButton];
        
        [self addSubview:self.introduceTipLabel];
        
        [self addSubview:self.introduceLabel];
        
        [self addSubview:self.showAllButton];
        
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

-(void)layoutSubviews
{
    if (!self.model) {
        return;
    }
    
    [self.serviceButton setTitle:[NSString stringWithFormat:@"服务%ld",self.model.recentServiceTimes] forState:UIControlStateNormal];
    
//    [self.appraiseButton setTitle:[NSString stringWithFormat:@"评价%ld",self.model.appraiseCount] forState:UIControlStateNormal];
    
    [self.collectButton setTitle:[NSString stringWithFormat:@"收藏%ld",self.model.appraiseCount] forState:UIControlStateNormal];
    
    
    if (self.model.intro.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        style.lineSpacing = 5;
        NSDictionary *attribute = @{NSFontAttributeName : SystemFont(14.0f), NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName:[UIColor colorWithString:@"#666666" colorAlpha:1]};
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self.model.intro attributes:attribute];
        
        if (self.model.isShowAll) {
            [_introduceLabel setFrame:RECT(10,  52 + 35, SCREENWIDTH - 30, self.model.allIntroduceStrHeight)];
        }
        else
        {
            [_introduceLabel setFrame:RECT(10, 52 + 35, SCREENWIDTH - 30, self.model.introducestrHeight)];
        }
        
        _introduceLabel.attributedText = attributeStr;
        
        
        if (self.model.isNeedShowAll) {
            self.showAllButton.hidden = NO;
        }
        else
        {
            self.showAllButton.hidden = YES;
        }

    }
    else
    {
        
        NSDictionary *attribute = @{NSFontAttributeName : SystemFont(14.0f), NSForegroundColorAttributeName:[UIColor colorWithString:@"#a5a6a7" colorAlpha:1]};
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"无" attributes:attribute];
        _introduceLabel.attributedText = attributeStr;
        
        [_introduceLabel setFrame:RECT(10, 35, SCREENWIDTH - 20, self.model.showAllIntroduceViewHeight)];
        
        
        self.showAllButton.hidden = YES;
    }
    
    
    [_showAllButton setFrame:RECT((SCREENWIDTH - 120)/2.0, self.height - 15 - 15, 120, 15)];
    
    if ([self.model.isCollect isEqualToString:@"yes"]) {
        [_collectButton setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    }
    else{
        [_collectButton setImage:[UIImage imageNamed:@"uncollect"] forState:UIControlStateNormal];
    }
}

-(void)collectAcitonButton:(UIButton *)btn
{
    if (self.block) {
        self.block(self.model);
    }
}

#pragma -mark ---Getter----

-(UIButton *)serviceButton
{
    if (!_serviceButton) {
        _serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceButton setTitleColor:RGBCOLOR(132, 133, 134) forState:UIControlStateNormal];
        _serviceButton.titleLabel.font = SystemFont(13.0f);
        _serviceButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_serviceButton setImage:[UIImage imageNamed:@"service"] forState:UIControlStateNormal];
        [_serviceButton setFrame:RECT(0, 0, ButtonWidth, ButtonHeight)];
        [self addSubview:[self getLineViewWithRect:RECT(ButtonWidth, 5, .5, ButtonHeight - 10)]];

    }
    return _serviceButton;
}



-(UIButton *)collectButton
{
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setTitleColor:RGBCOLOR(132, 133, 134) forState:UIControlStateNormal];
        _collectButton.titleLabel.font = SystemFont(13.0f);
        _collectButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_collectButton setFrame:RECT(ButtonWidth  + 1, 0, ButtonWidth, ButtonHeight)];
        [_collectButton addTarget:self action:@selector(collectAcitonButton:) forControlEvents:UIControlEventTouchUpInside];
        [_collectButton setImage:[UIImage imageNamed:@"uncollect"] forState:UIControlStateNormal];
        [self addSubview:[self getLineViewWithRect:RECT(ButtonWidth *2 + 1, 5, .5, ButtonHeight - 10)]];
        [self addSubview:[self getLineViewWithRect:RECT(0, ButtonHeight, SCREENWIDTH, .5)]];
        
    }
    return _collectButton;
}


-(UILabel *)introduceTipLabel
{
    if (!_introduceTipLabel) {
        _introduceTipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, ButtonHeight + 10, 200, 14)];
        _introduceTipLabel.textColor = KColorGray333;
        _introduceTipLabel.text = @"简介：";
    }
    return _introduceTipLabel;
}

-(UILabel *)introduceLabel
{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.font = SystemFont(14.0f);
        _introduceLabel.numberOfLines = 3;
        _introduceLabel.textColor = KColorGray999;
    }
    return _introduceLabel;
}

-(UIButton *)showAllButton
{
    if (!_showAllButton) {
        _showAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _showAllButton.backgroundColor = [UIColor redColor];
        _showAllButton.hidden = YES;
    }
    return _showAllButton;
}


@end
