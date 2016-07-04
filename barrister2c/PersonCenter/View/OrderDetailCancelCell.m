//
//  OrderDetailCancelCell.m
//  barrister
//
//  Created by 徐书传 on 16/7/3.
//  Copyright © 2016年 Xu. All rights reserved.
//

/**
 *  10
 *  10
 *  15
 *  10
 *  40
 *  10
 */

#import "OrderDetailCancelCell.h"
#import "UIImage+Additions.h"

@interface OrderDetailCancelCell ()


@property (nonatomic,strong) UIView *topSepView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIButton *cancelBtn;
@end

@implementation OrderDetailCancelCell

+(CGFloat)getCellHeight
{
    return 10 + 10 + 15 + 10 + 40 + 10;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.topSepView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.cancelBtn];
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
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.font = SystemFont(11.0f);
        _tipLabel.text = @"律师没有及时处理订单，您可以选择取消";
    }
    return _tipLabel;
}

-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"不同意" forState:UIControlStateNormal];
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
