//
//  OnlineWaitPayCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OnlineWaitPayCell.h"
#import "UIImage+Additions.h"


@interface OnlineWaitPayCell ()

@property (nonatomic,strong) UIView *topSepView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIView *bottomSepView;
@end


@implementation OnlineWaitPayCell


+(CGFloat)getCellHeight
{
    return 10 + 10 + 15 + 10 + 40 + 10 + 10;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.topSepView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.bottomSepView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_bottomSepView setFrame:RECT(0,  10 + 10 + 15 + 10 + 40 + 10  , SCREENWIDTH, 10)];
    
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


-(UIView *)bottomSepView
{
    if (!_bottomSepView) {
        _bottomSepView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, 10)];
        _bottomSepView.backgroundColor = [UIColor colorWithString:@"#eeeeee" colorAlpha:1];
        
    }
    return _bottomSepView;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.topSepView.frame) + 10, SCREENWIDTH, 15)];
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.font = SystemFont(11.0f);
        _tipLabel.text = @"支付订单相关费用";
    }
    return _tipLabel;
}

-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"支付" forState:UIControlStateNormal];
        [_cancelBtn setBackgroundImage:[UIImage createImageWithColor:kNavigationBarColor] forState:UIControlStateNormal];
        [_cancelBtn setFrame:RECT(LeftPadding , CGRectGetMaxY(self.tipLabel.frame) + 10, SCREENWIDTH - LeftPadding *2, 40)];
        _cancelBtn.layer.cornerRadius = 4.0f;
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.layer.masksToBounds = YES;
    }
    return _cancelBtn;
}



-(void)cancelAction
{
    if (self.block) {
        self.block(@"同意");
    }
}
@end
