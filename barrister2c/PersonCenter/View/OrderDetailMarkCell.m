//
//  OrderDetailMarkCell.m
//  barrister
//
//  Created by 徐书传 on 16/6/12.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderDetailMarkCell.h"
#define TipLabelWidth 70

@interface OrderDetailMarkCell ()

@property (nonatomic,strong) UILabel *customMarkTipLabel;

@property (nonatomic,strong) UILabel *customMarkContentLabel;

@property (nonatomic,strong) UILabel *lawyerMarkTipLabel;

@property (nonatomic,strong) UILabel *lawyerMarkContentLabel;

@property (nonatomic,strong) UIView *sepView;

@end

@implementation OrderDetailMarkCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:[self getLineViewWithRect:RECT(0, 0.5, SCREENWIDTH, .5)]];
        [self addSubview:self.customMarkTipLabel];
        [self addSubview:self.customMarkContentLabel];
        [self addSubview:self.lawyerMarkTipLabel];
        [self addSubview:self.lawyerMarkContentLabel];
        [self addSubview:self.sepView];
    }
    return self;
}

+(CGFloat)getCellHeightWithModel:(BarristerOrderDetailModel *)model
{
    return LeftPadding + model.lawyerFeedBackHeight + model.markHeight + LeftPadding + 8;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.customMarkContentLabel setFrame:RECT(CGRectGetMaxX(self.customMarkTipLabel.frame) + 5, 8, TipLabelWidth, self.model.markHeight)];

    [self.lawyerMarkTipLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.customMarkContentLabel.frame) + LeftPadding, TipLabelWidth, 13)];
    [self.lawyerMarkContentLabel setFrame:RECT(CGRectGetMaxX(self.lawyerMarkTipLabel.frame) + 5, CGRectGetMaxY(self.customMarkContentLabel.frame) + 8, TipLabelWidth, self.model.markHeight)];
    
    self.customMarkContentLabel.text = self.model.remarks?self.model.remarks:@"无";
    self.lawyerMarkContentLabel.text = self.model.lawFeedback?self.model.lawFeedback:@"无";

    [self.sepView setFrame:RECT(0, self.height - .5, SCREENWIDTH, .5)];
}

#pragma -mark ----

-(UILabel *)customMarkTipLabel
{
    if (!_customMarkTipLabel) {
        _customMarkTipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, LeftPadding, TipLabelWidth, 13)];
        _customMarkTipLabel.font = SystemFont(14.0f);
        _customMarkTipLabel.textColor = KColorGray666;
        _customMarkTipLabel.text = @"订单备注：";
    }
    return _customMarkTipLabel;
}

-(UILabel *)customMarkContentLabel
{
    if (!_customMarkContentLabel) {
        _customMarkContentLabel = [[UILabel alloc] initWithFrame:RECT(CGRectGetMaxX(self.customMarkTipLabel.frame) + 5, 5, TipLabelWidth, 13)];
        _customMarkContentLabel.font = SystemFont(14.0f);
        _customMarkContentLabel.textColor = KColorGray999;
    }
    return _customMarkContentLabel;
}


-(UILabel *)lawyerMarkTipLabel
{
    if (!_lawyerMarkTipLabel) {
        _lawyerMarkTipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, LeftPadding, TipLabelWidth, 13)];
        _lawyerMarkTipLabel.font = SystemFont(14.0f);
        _lawyerMarkTipLabel.textColor = KColorGray666;
        _lawyerMarkTipLabel.text = @"律师总结：";
    }
    return _lawyerMarkTipLabel;
}

-(UILabel *)lawyerMarkContentLabel
{
    if (!_lawyerMarkContentLabel) {
        _lawyerMarkContentLabel = [[UILabel alloc] initWithFrame:RECT(CGRectGetMaxX(self.customMarkTipLabel.frame) + 5, LeftPadding, TipLabelWidth, 13)];
        _lawyerMarkContentLabel.font = SystemFont(14.0f);
        _lawyerMarkContentLabel.textColor = KColorGray999;
    }
    return _lawyerMarkContentLabel;
}


-(UIView *)sepView
{
    if (!_sepView) {
        _sepView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, .5)];
        _sepView.backgroundColor = kSeparatorColor;
    }
    return _sepView;
}

@end
