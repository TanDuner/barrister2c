//
//  YingShowListCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowListCell.h"
#define VerSpace 5



@interface YingShowListCell ()
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *addTimeLabel;
@property (nonatomic,strong) UILabel *updateTimeLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@end

@implementation YingShowListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.typeLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.addTimeLabel];
        [self addSubview:self.updateTimeLabel];
        [self addSubview:self.statusLabel];
    }
    return self;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.model) {
        return;
    }
    
    [self.typeLabel setFrame:RECT(LeftPadding, LeftPadding, 200, 13)];
    [self.moneyLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.typeLabel.frame) + VerSpace, 200, 13)];
    [self.addTimeLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.moneyLabel.frame) + VerSpace, 200, 13)];
    [self.updateTimeLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.addTimeLabel.frame) + VerSpace, 200, 13)];
    
    [self.statusLabel setFrame:RECT(SCREENWIDTH - LeftPadding - 100, LeftPadding, 100, 13)];
}


-(void)configData
{
    
    
    if ([self.model.type isEqualToString:TYPE_CONTRACT] || [self.model.type isEqualToString:@"合同欠款"]) {
        self.typeLabel.text = [NSString stringWithFormat:@"类型：合同欠款"];
    }
    else if ([self.model.type isEqualToString:TYPE_BORROW_MONEY]||[self.model.type isEqualToString:@"借款"])
    {
        self.typeLabel.text = [NSString stringWithFormat:@"类型：借款"];
    }
    else if ([self.model.type isEqualToString:TYPE_TORT]||[self.model.type isEqualToString:@"侵权"])
    {
        self.typeLabel.text = [NSString stringWithFormat:@"类型：侵权"];
    }
    else if ([self.model.type isEqualToString:TYPE_LABOR_DISPUTES]||[self.model.type isEqualToString:@"劳动与劳务"])
    {
        self.typeLabel.text = [NSString stringWithFormat:@"类型：劳动与劳务"];
    }
    else if ([self.model.type isEqualToString:TYPE_OTHER]||[self.model.type isEqualToString:@"其他"])
    {
        self.typeLabel.text = [NSString stringWithFormat:@"类型：其他"];
    }
    
    
    
    self.moneyLabel.text = [NSString stringWithFormat:@"金额: %@",self.model.money];
    self.addTimeLabel.text = [NSString stringWithFormat:@"形成时间:%@",self.model.addTime];
    self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间:%@",self.model.updateTime];
    if ([self.model.creditDebtStatus isEqualToString:CREDIT_DEBT_STATUS_NOT_SUE]) {
        self.statusLabel.text = @"状态：未起诉";
    }else if ([self.model.creditDebtStatus isEqualToString:CREDIT_DEBT_STATUS_SUING])
    {
        self.statusLabel.text = @"状态：起诉中";
    }
    else if ([self.model.creditDebtStatus isEqualToString:CREDIT_DEBT_STATUS_JUDGING])
    {
        self.statusLabel.text = @"状态：判决中";
    }
    else if ([self.model.creditDebtStatus isEqualToString:CREDIT_DEBT_STATUS_OUT_OF_DATE])
    {
        self.statusLabel.text = @"状态：已过期";
    }
}



-(UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = SystemFont(13.0f);
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.textColor = KColorGray333;
    }
    return _typeLabel;
}


-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = SystemFont(13.0f);
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.textColor = KColorGray666;
    }
    return _moneyLabel;
}

-(UILabel *)addTimeLabel
{
    if (!_addTimeLabel) {
        _addTimeLabel = [[UILabel alloc] init];
        _addTimeLabel.font = SystemFont(13.0f);
        _addTimeLabel.textAlignment = NSTextAlignmentLeft;
        _addTimeLabel.textColor = KColorGray666;
    }
    return _addTimeLabel;
}

-(UILabel *)updateTimeLabel
{
    if (!_updateTimeLabel) {
        _updateTimeLabel = [[UILabel alloc] init];
        _updateTimeLabel.font = SystemFont(13.0f);
        _updateTimeLabel.textAlignment = NSTextAlignmentLeft;
        _updateTimeLabel.textColor = KColorGray666;
    }
    return _updateTimeLabel;
}

-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = SystemFont(13.0f);
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.textColor = KColorGray666;

    }
    return _statusLabel;
}

@end
