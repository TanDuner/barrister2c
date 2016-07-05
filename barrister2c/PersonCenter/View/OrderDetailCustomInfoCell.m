//
//  OrderDetailCustomInfoCell.m
//  barrister
//
//  Created by 徐书传 on 16/6/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderDetailCustomInfoCell.h"
#import "UIImageView+YYWebImage.h"

@interface OrderDetailCustomInfoCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *headImageView;

@property (nonatomic,strong) UILabel *customNamemLabel;

@property (nonatomic,strong) UILabel *customPhoneLabel;

@property (nonatomic,strong) UIView *separteView;


@end

@implementation OrderDetailCustomInfoCell

+(CGFloat)getHeightWithModel:(BarristerOrderDetailModel *)model
{
    return 105 + 10;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
    
        [self addSubview:[self getLineViewWithRect:RECT(0, 39.5, SCREENWIDTH, .5)]];
        
        [self addSubview:self.headImageView];
        
        [self addSubview:self.customNamemLabel];
        
        [self addSubview:self.customPhoneLabel];
        
        [self addSubview:self.callButton];
        
        [self addSubview:self.separteView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:self.model.barristerIcon] placeholder:[UIImage imageNamed:@"commom_default_head"]];
    if (IS_NOT_EMPTY(self.model.barristerNickname)) {
        self.customNamemLabel.text = self.model.barristerNickname;
    }
    else
    {
        self.customNamemLabel.text = [NSString stringWithFormat:@"律师：%@",self.model.barristerPhone];
    }

    self.customPhoneLabel.text = self.model.barristerPhone;
    [_callButton setFrame:RECT(self.width - 40 - 10, 40 + (64 - 40)/2.0, 40, 40)];
    [self.separteView setFrame:RECT(0, self.height - 10, SCREENWIDTH, 10)];

}


#pragma -mark ----Getter---

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:RECT(10, 13, 200, 13)];
        _titleLabel.text = @"订单信息";
        _titleLabel.textColor = KColorGray222;
        _titleLabel.font = SystemFont(15.0f);
    }
    return _titleLabel;
}


-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, 40 + 10, 45, 45)];
        _headImageView.layer.cornerRadius = 22.5f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}


-(UIButton *)callButton
{
    if (!_callButton) {
        _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callButton setImage:[UIImage imageNamed:@"orderdetail_call.png"] forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(callAciton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _callButton;
}

-(UILabel *)customNamemLabel
{
    if (!_customNamemLabel) {
        _customNamemLabel = [[UILabel alloc] initWithFrame:RECT(self.headImageView.x + self.headImageView.width + 15, 40 + 16.5, 200, 13)];
        _customNamemLabel.textColor = KColorGray333;
        _customNamemLabel.font = SystemFont(15.0f);
    }
    return _customNamemLabel;
}



-(UILabel *)customPhoneLabel
{
    if (!_customPhoneLabel) {
        _customPhoneLabel = [[UILabel alloc] initWithFrame:RECT(self.headImageView.x + self.headImageView.width + 15, self.customNamemLabel.y + self.customNamemLabel.height + 10, 200, 13)];
        _customPhoneLabel.textColor = KColorGray666;
        _customPhoneLabel.font = SystemFont(15.0f);
    }
    return _customPhoneLabel;
}

-(UIView *)separteView
{
    if (!_separteView) {
        _separteView = [[UIView alloc] init];
        _separteView.backgroundColor = kBaseViewBackgroundColor;
        
    }
    return _separteView;
}

#pragma -mark -------Action----------

-(void )callAciton:(UIButton *)btn
{
    
}



@end
