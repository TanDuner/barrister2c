//
//  OrderDetailOrderCell.m
//  barrister
//
//  Created by 徐书传 on 16/6/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderDetailOrderCell.h"

#define DaiBanColor RGBCOLOR(253, 167, 41)

@interface OrderDetailOrderCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *stateLabel;

@property (nonatomic,strong) UILabel *orderNoLabel;
@property (nonatomic,strong) UILabel *orderTypeLabel;
@property (nonatomic,strong) UILabel *orderTimeLabel;
@property (nonatomic,strong) UILabel *orderPriceLabel;
//@property (nonatomic,strong) UILabel *markLabel;



@end

@implementation OrderDetailOrderCell

+(CGFloat)getHeightWithModel:(BarristerOrderDetailModel *)model
{
    return   150;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.stateLabel];
        
        [self addSubview:[self getLineViewWithRect:RECT(0, 39.5, SCREENWIDTH, .5)]];

        [self addSubview:self.orderNoLabel];
        [self addSubview:self.orderTypeLabel];
        [self addSubview:self.orderTimeLabel];
        [self addSubview:self.orderPriceLabel];
        
        [self addSubview:[self getLineViewWithRect:RECT(LeftPadding, self.orderPriceLabel.y + self.orderPriceLabel.height + 9.5, SCREENWIDTH - 10, .5)]];
        
//        [self addSubview:self.markLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self.separteView setFrame:RECT(0, self.height - 10, SCREENWIDTH, 10)];
    
    
//    [self.markLabel setFrame:RECT(LeftPadding, self.orderPriceLabel.y + self.orderPriceLabel.height + 10 + 15, SCREENWIDTH - 20, self.model.markHeight)];
//    self.orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",self.model.orderNo?self.model.orderNo:@""];
    self.orderTypeLabel.text = [NSString stringWithFormat:@"订单类型：%@",self.model.caseType?self.model.caseType:@"无"];
    self.orderTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",self.model.payTime?self.model.payTime:@""];
    self.orderPriceLabel.text = [NSString stringWithFormat:@"订单金额：%@",self.model.paymentAmount?self.model.paymentAmount:@""];
//    self.markLabel.text = [NSString stringWithFormat:@"备注：%@",self.model.remarks?self.model.remarks:@"无"];
    
    if ([self.model.status isEqualToString:STATUS_WAITING]) {
        self.stateLabel.text = @"待处理";
    }
    else if ([self.model.status  isEqualToString:STATUS_DONE])
    {
        self.stateLabel.text = @"已完成";
    }
    else if ([self.model.status isEqualToString:STATUS_REFUND])
    {
        self.stateLabel.text = @"退款中";
    }
    else if ([self.model.status isEqualToString:STATUS_DOING])
    {
        self.stateLabel.text = @"进行中";
    }
    else if ([self.model.status isEqualToString:STATUS_CANCELED])
    {
        self.stateLabel.text = @"已取消";
    }
    
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

-(UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:RECT(SCREENWIDTH - 10 - 150, 13, 150, 13)];
        _stateLabel.textAlignment = NSTextAlignmentRight;
        _stateLabel.textColor = DaiBanColor;
        _stateLabel.font = SystemFont(14.0f);
    }
    return _stateLabel;
}


//-(UILabel *)markLabel
//{
//    if (!_markLabel) {
//        _markLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.orderPriceLabel.y + self.orderPriceLabel.height + 10 + 15, SCREENWIDTH - 20, self.model.markHeight)];
//        _markLabel.textAlignment = NSTextAlignmentLeft;
//        _markLabel.textColor = KColorGray666;
//        _markLabel.font = SystemFont(14.0f);
//    }
//    return _markLabel;
//}


-(UILabel *)orderNoLabel
{
    if (!_orderNoLabel) {
        _orderNoLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10 + 13 + 1 + self.titleLabel.y + self.titleLabel.height, SCREENWIDTH - 20, 13)];
        _orderNoLabel.textAlignment = NSTextAlignmentLeft;
        _orderNoLabel.textColor = KColorGray666;
        _orderNoLabel.text = [NSString stringWithFormat:@"订单号："];
        _orderNoLabel.font = SystemFont(14.0f);
    }
    return _orderNoLabel;
}

-(UILabel *)orderPriceLabel
{
    if (!_orderPriceLabel) {
        _orderPriceLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.orderTimeLabel.y + self.orderTimeLabel.height + 13, SCREENWIDTH - 20, 13)];
        _orderPriceLabel.textColor = KColorGray666;
        _orderPriceLabel.textAlignment = NSTextAlignmentLeft;
        _orderPriceLabel.text = [NSString stringWithFormat:@"支付金额："];
        _orderPriceLabel.font = SystemFont(14.0f);
    }
    return _orderPriceLabel;
}

-(UILabel *)orderTimeLabel
{
    if (!_orderTimeLabel) {
        _orderTimeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.orderTypeLabel.y + self.orderTypeLabel.height + 13, SCREENWIDTH - 20, 13)];
        _orderTimeLabel.textAlignment = NSTextAlignmentLeft;
        _orderTimeLabel.textColor = KColorGray666;
        _orderTimeLabel.text = [NSString stringWithFormat:@"下单时间："];
        _orderTimeLabel.font = SystemFont(14.0f);
    }
    return _orderTimeLabel;
}

-(UILabel *)orderTypeLabel
{
    if (!_orderTypeLabel) {
        _orderTypeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.orderNoLabel.y + self.orderNoLabel.height + 13, SCREENWIDTH  - 20, 13)];
        _orderTypeLabel.textAlignment = NSTextAlignmentLeft;
        _orderTypeLabel.text = [NSString stringWithFormat:@"订单类型："];
        _orderTypeLabel.textColor = KColorGray666;
        _orderTypeLabel.font = SystemFont(14.0f);
    }
    return _orderTypeLabel;
}

//-(UIView *)separteView
//{
//    if (!_separteView) {
//        _separteView = [[UIView alloc] init];
//        _separteView.backgroundColor = kBaseViewBackgroundColor;
//        
//    }
//    return _separteView;
//}

@end
