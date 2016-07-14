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

@property (nonatomic,strong) UILabel *customCommonTipLabel;

@property (nonatomic,strong) UILabel *customCommonLabel;

@end

@implementation OrderDetailMarkCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:[self getLineViewWithRect:RECT(0, 0.5, SCREENWIDTH, .5)]];
        [self addSubview:self.customMarkTipLabel];
        [self addSubview:self.customMarkContentLabel];
        [self addSubview:self.lawyerMarkTipLabel];
        [self addSubview:self.lawyerMarkContentLabel];
        [self addSubview:self.customCommonTipLabel];
        [self addSubview:self.customCommonLabel];
        [self addSubview:self.sepView];
    }
    return self;
}

+(CGFloat)getCellHeightWithModel:(BarristerOrderDetailModel *)model
{
    return LeftPadding + model.lawyerFeedBackHeight  + 8 + model.markHeight +  8 + model.customCommonHeight + LeftPadding;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.customMarkContentLabel setFrame:RECT(CGRectGetMaxX(self.customMarkTipLabel.frame) + 5, 8, SCREENWIDTH - 90, self.model.markHeight)];

    [self.lawyerMarkTipLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.customMarkContentLabel.frame) + LeftPadding, TipLabelWidth, 13)];
    [self.lawyerMarkContentLabel setFrame:RECT(CGRectGetMaxX(self.lawyerMarkTipLabel.frame) + 5, CGRectGetMaxY(self.customMarkContentLabel.frame) + 10, SCREENWIDTH - 90, self.model.lawyerFeedBackHeight)];
    
    self.customMarkContentLabel.text = self.model.remarks?self.model.remarks:@"无";
    self.lawyerMarkContentLabel.text = self.model.lawFeedback?self.model.lawFeedback:@"无";

    [self.customCommonTipLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.lawyerMarkContentLabel.frame) + LeftPadding, TipLabelWidth, 13)];
    
    [self.customCommonLabel setFrame:RECT(CGRectGetMaxX(self.customCommonTipLabel.frame) + 5, CGRectGetMaxY(self.lawyerMarkContentLabel.frame) + 10, SCREENWIDTH - 90, self.model.customCommonHeight)];

    self.customCommonLabel.text = self.model.comment?self.model.comment:@"无";
    
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
        _customMarkContentLabel.numberOfLines = 0;
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
        _lawyerMarkContentLabel.numberOfLines = 0;
    }
    return _lawyerMarkContentLabel;
}



-(UILabel *)customCommonTipLabel
{
    if (!_customCommonTipLabel) {
        _customCommonTipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, LeftPadding, TipLabelWidth, 13)];
        _customCommonTipLabel.font = SystemFont(14.0f);
        _customCommonTipLabel.textColor = KColorGray666;
        _customCommonTipLabel.text = @"用户评论：";
    }
    return _customCommonTipLabel;
}


-(UILabel *)customCommonLabel
{
    if (!_customCommonLabel) {
        _customCommonLabel = [[UILabel alloc] initWithFrame:RECT(CGRectGetMaxX(self.customMarkTipLabel.frame) + 5, LeftPadding, TipLabelWidth, 13)];
        _customCommonLabel.font = SystemFont(14.0f);
        _customCommonLabel.textColor = KColorGray999;
        _customCommonLabel.numberOfLines = 0;
    }
    return _customCommonLabel;
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
