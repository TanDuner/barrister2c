//
//  YingShowHorSelectItemView.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/13.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowHorSelectItemView.h"
#import "UIButton+EnlargeEdge.h"


@interface YingShowHorSelectItemView ()

@property (nonatomic,strong) UIButton *selectButton;

@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation YingShowHorSelectItemView

-(id)initWithFrame:(CGRect)frame title:(NSString *)title withFont:(UIFont *)font
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.selectButton];
        [self addSubview:self.textLabel];
        
        self.textWidth = [XuUtlity textWidthWithStirng:title ShowFont:(font != nil)?font:YingShowHorSelectFont sizeHeight:15];
        [self.textLabel setFrame:RECT(CGRectGetMaxX(self.selectButton.frame) + 5, 0, _textWidth, 15)];
        
        self.textLabel.text = title;
        
        self.titleStr = title;
    }
    return self;
}


-(void)setIsSelected:(BOOL)isSelected
{
    if (isSelected) {
        [self.selectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
    }
    else{
        [self.selectButton setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    }
}


-(void)chanegStatus
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yingShowDidSelectItemView:)]) {
        [self.delegate yingShowDidSelectItemView:self];
    }
}

#pragma - mark ----Getter---

-(UIButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setFrame:RECT(0, 0, 15, 15)];
        [_selectButton setEnlargeEdgeWithTop:5 right:20 bottom:5 left:0];
        [_selectButton setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(chanegStatus) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectButton;
}


-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = KColorGray666;
        _textLabel.font = YingShowHorSelectFont;
    }
    return _textLabel;
}

@end
