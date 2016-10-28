//
//  YingShowListCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowListCell.h"
#define VerSpace 5

#define LabelHeight 13

@interface YingShowListCell ()

@property (nonatomic,strong) UILabel *zhaiwu1Label;//公司名 联系人
@property (nonatomic,strong) UILabel *zhaiwu2Label;//电话
@property (nonatomic,strong) UILabel *zhaiwu3Label;//信用代码 身份证


@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *addTimeLabel;
@property (nonatomic,strong) UILabel *updateTimeLabel;
@property (nonatomic,strong) UILabel *statusLabel;

@property (nonatomic,strong) UIImageView *separtView;

@end

@implementation YingShowListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.zhaiwu1Label];
        [self addSubview:self.zhaiwu2Label];
        [self addSubview:self.zhaiwu3Label];
        
        [self addSubview:self.typeLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.addTimeLabel];
        [self addSubview:self.updateTimeLabel];
        [self addSubview:self.statusLabel];
        
        [self addSubview:self.separtView];
    }
    return self;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.model) {
        return;
    }
    
    [self.zhaiwu1Label setFrame:RECT(LeftPadding, LeftPadding, SCREENWIDTH - 20, LabelHeight)];
    [self.zhaiwu2Label setFrame:RECT(LeftPadding, CGRectGetMaxY(self.zhaiwu1Label.frame) + VerSpace, SCREENWIDTH - 20, LabelHeight)];
    [self.zhaiwu3Label setFrame:RECT(LeftPadding, CGRectGetMaxY(self.zhaiwu2Label.frame) + VerSpace, SCREENWIDTH - 20, LabelHeight)];
    
    [self.typeLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.zhaiwu3Label.frame) + VerSpace, SCREENWIDTH - 20, LabelHeight)];
    [self.statusLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.typeLabel.frame) + VerSpace, SCREENWIDTH - 20, LabelHeight)];
    [self.moneyLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.statusLabel.frame) + VerSpace, SCREENWIDTH - 20, LabelHeight)];
    [self.addTimeLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.moneyLabel.frame) + VerSpace, SCREENWIDTH - 20, LabelHeight)];
    [self.updateTimeLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.addTimeLabel.frame) + VerSpace, SCREENWIDTH - 20, LabelHeight)];
    
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
    
    
    
    NSString *countStr = [NSString stringWithFormat:@"金额: %@",self.model.money];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:countStr];
    NSRange range = [countStr rangeOfString:@"金额:"];
    
    
    [attributeStr setAttributes:@{NSFontAttributeName : SystemFont(13.0f), NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, countStr.length)];
    [attributeStr setAttributes:@{NSFontAttributeName : SystemFont(13.0f), NSForegroundColorAttributeName:[UIColor colorWithString:@"#666666" colorAlpha:1]} range:range];

    self.moneyLabel.attributedText = attributeStr;
    
    
    
    self.addTimeLabel.text = [NSString stringWithFormat:@"形成时间:%@",self.model.addTime?self.model.addTime:@"-"];
    self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间:%@",self.model.updateTime?self.model.updateTime:@"-"];
     self.statusLabel.text = @"状态：未知";
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
    
   
    NSString *string1;
    NSString *string2;
    NSString *string3;
    
    NSRange range1;
    NSRange range2;
    NSRange range3;
    
    if (IS_NOT_EMPTY(self.model.debtUser.licenseNuber)) {
       
        string1 = [NSString stringWithFormat:@"债务公司:%@",self.model.debtUser.company?self.model.debtUser.company:@"-"];
        string2 = [NSString stringWithFormat:@"债务公司电话:%@",self.model.debtUser.companyPhone?self.model.debtUser.companyPhone:@"-"];
        string3 = [NSString stringWithFormat:@"债务公司信用代码:%@",self.model.debtUser.licenseNuber?self.model.debtUser.licenseNuber:@"-"];
        
        range1 = [string1 rangeOfString:@"债务公司:"];
        range2 = [string2 rangeOfString:@"债务公司电话:"];
        range3 = [string3 rangeOfString:@"债务公司信用代码:"];
        
        
    }
    
    else{
        string1 = [NSString stringWithFormat:@"债务人:%@",self.model.debtUser.name?self.model.debtUser.name:@"-"];
        string2 = [NSString stringWithFormat:@"债务人电话:%@",self.model.debtUser.phone?self.model.debtUser.phone:@"-"];
        string3 = [NSString stringWithFormat:@"债务人身份证:%@",self.model.debtUser.ID_number?self.model.debtUser.ID_number:@"-"];
        
        range1 = [string1 rangeOfString:@"债务人:"];
        range2 = [string2 rangeOfString:@"债务人电话:"];
        range3 = [string3 rangeOfString:@"债务人身份证:"];

        
    }
    
    NSMutableAttributedString *attributeStr1 = [[NSMutableAttributedString alloc] initWithString:string1];
    
    [attributeStr1 setAttributes:@{NSFontAttributeName : SystemFont(13.0f), NSForegroundColorAttributeName:kNavigationBarColor} range:NSMakeRange(0, string1.length)];
    [attributeStr1 setAttributes:@{NSFontAttributeName : SystemFont(13.0f), NSForegroundColorAttributeName:[UIColor colorWithString:@"#666666" colorAlpha:1]} range:range1];
    
    
    NSMutableAttributedString *attributeStr2 = [[NSMutableAttributedString alloc] initWithString:string2];
    
    [attributeStr2 setAttributes:@{NSFontAttributeName : SystemFont(13.0f), NSForegroundColorAttributeName:kNavigationBarColor} range:NSMakeRange(0, string2.length)];
    [attributeStr2 setAttributes:@{NSFontAttributeName : SystemFont(13.0f), NSForegroundColorAttributeName:[UIColor colorWithString:@"#666666" colorAlpha:1]} range:range2];
    
    
    NSMutableAttributedString *attributeStr3 = [[NSMutableAttributedString alloc] initWithString:string3];
    
    [attributeStr3 setAttributes:@{NSFontAttributeName : SystemFont(13.0f), NSForegroundColorAttributeName:kNavigationBarColor} range:NSMakeRange(0, string3.length)];
    [attributeStr3 setAttributes:@{NSFontAttributeName : SystemFont(13.0f), NSForegroundColorAttributeName:[UIColor colorWithString:@"#666666" colorAlpha:1]} range:range3];
    
    self.zhaiwu1Label.attributedText = attributeStr1;
    self.zhaiwu2Label.attributedText = attributeStr2;
    self.zhaiwu3Label.attributedText = attributeStr3;

    
    [self.separtView setFrame:RECT(0, self.height - .5, SCREENWIDTH, .5)];
    
}



-(UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = SystemFont(13.0f);
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.textColor = KColorGray666;
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
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.textColor = KColorGray666;

    }
    return _statusLabel;
}

-(UILabel *)zhaiwu1Label
{
    if (!_zhaiwu1Label) {
        _zhaiwu1Label = [[UILabel alloc] init];
        _zhaiwu1Label.font = SystemFont(13.0f);
        _zhaiwu1Label.textAlignment = NSTextAlignmentLeft;
        _zhaiwu1Label.textColor = KColorGray666;
    }
    return _zhaiwu1Label;
}


-(UILabel *)zhaiwu2Label
{
    if (!_zhaiwu2Label) {
        _zhaiwu2Label = [[UILabel alloc] init];
        _zhaiwu2Label.font = SystemFont(13.0f);
        _zhaiwu2Label.textAlignment = NSTextAlignmentLeft;
        _zhaiwu2Label.textColor = KColorGray666;
    }
    return _zhaiwu2Label;
}


-(UILabel *)zhaiwu3Label
{
    if (!_zhaiwu3Label) {
        _zhaiwu3Label = [[UILabel alloc] init];
        _zhaiwu3Label.font = SystemFont(13.0f);
        _zhaiwu3Label.textAlignment = NSTextAlignmentLeft;
        _zhaiwu3Label.textColor = KColorGray666;
    }
    return _zhaiwu3Label;
}


-(UIImageView *)separtView
{
    if (!_separtView) {
        _separtView = [[UIImageView alloc] init];
        _separtView.backgroundColor = kSeparatorColor;
    }
    return _separtView;
}

@end
