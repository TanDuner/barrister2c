//
//  AppriseOrderCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/7/4.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "AppriseOrderCell.h"
#import "UIImage+Additions.h"

@interface AppriseOrderCell ()

@property (nonatomic,strong) UIView *topSepView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIButton *agreeBtn;

@end
@implementation AppriseOrderCell

+(CGFloat)getCellHeight
{
    return 10 + 10 + 15 + 10 + 40 + 10;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.topSepView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.agreeBtn];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma -mark ----Getter-----

-(UIView *)topSepView
{
    if (!_topSepView) {
        _topSepView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, 10)];
        _topSepView.backgroundColor = [UIColor colorWithString:@"#eeeeee" colorAlpha:1];
        
    }
    return _topSepView;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.topSepView.frame) + 10, SCREENWIDTH, 15)];
        _tipLabel.textColor = [UIColor cyanColor];
        _tipLabel.font = SystemFont(11.0f);
        _tipLabel.text = @"如果已经完成订单，请及时评价";
    }
    return _tipLabel;
}


-(UIButton *)agreeBtn
{
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setTitle:@"完成订单" forState:UIControlStateNormal];
        [_agreeBtn setFrame:RECT(LeftPadding , CGRectGetMaxY(self.tipLabel.frame) + 10, SCREENWIDTH - LeftPadding *2, 40)];
        [_agreeBtn addTarget:self action:@selector(FinishOrderAction) forControlEvents:UIControlEventTouchUpInside];
        [_agreeBtn setBackgroundImage:[UIImage createImageWithColor:kNavigationBarColor] forState:UIControlStateNormal];
        _agreeBtn.layer.cornerRadius = 4.0f;
        _agreeBtn.layer.masksToBounds = YES;
    }
    return _agreeBtn;
}


-(void)FinishOrderAction
{
    if (self.block) {
        self.block();
    }
}


@end
