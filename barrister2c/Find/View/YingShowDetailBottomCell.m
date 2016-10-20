//
//  YingShowDetailBottomCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowDetailBottomCell.h"

#define VSpace 5


@interface YingShowDetailBottomCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *creaditCardLabel;
@property (nonatomic,strong) UILabel *companyLabel;
@property (nonatomic,strong) UILabel *companyPhoneLabel;
@property (nonatomic,strong) UILabel *codeLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@end

@implementation YingShowDetailBottomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.creaditCardLabel];
        [self addSubview:self.companyLabel];
        [self addSubview:self.companyPhoneLabel];
        [self addSubview:self.codeLabel];
        [self addSubview:self.addressLabel];
        
    }
    return self;
}


+(CGFloat)getCellHeightWithModel:(YingShowInfoModel *)model
{
    return model.cellHeight;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.model) {
        return;
    }
    
    [self.nameLabel setFrame:RECT(LeftPadding, LeftPadding, 200, 13)];
    [self.phoneLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.nameLabel.frame) + VSpace, 200, 13)];
    [self.creaditCardLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.phoneLabel.frame) + VSpace, 200, 13)];
//    [self.companyLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.creaditCardLabel.frame) + VSpace, 200, self.model.companyNameHeight)];
    [self.companyPhoneLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.companyLabel.frame) + VSpace, 200, 13)];
    [self.codeLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.companyPhoneLabel.frame) + VSpace, 200, 13)];
//    [self.addressLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.codeLabel.frame) + VSpace, 200, self.model.addressHeight)];

}


-(void)configData
{
    self.nameLabel.text = [NSString stringWithFormat:@"姓名: %@",self.model.creditUser.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"个人电话: %@",self.model.creditUser.phone];
    self.creaditCardLabel.text = [NSString stringWithFormat:@"身份证: %@",self.model.creditUser.ID_number];
    self.companyLabel.text = [NSString stringWithFormat:@"单位名称: %@",self.model.creditUser.company];
    self.companyPhoneLabel.text = [NSString stringWithFormat:@"公司电话: %@",self.model.creditUser.companyPhone];
    self.codeLabel.text = [NSString stringWithFormat:@"信用代码: %@",self.model.creditUser.liceseeNuber];
    self.addressLabel.text = [NSString stringWithFormat:@"联系地址: %@",self.model.creditUser.address];
}


#pragma -mark ---Getter--

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = YingShowDetailTextFont;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = KColorGray333;
    }
    return _nameLabel;
}


-(UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = YingShowDetailTextFont;
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.textColor = KColorGray333;
    }
    return _phoneLabel;
}


-(UILabel *)creaditCardLabel
{
    if (!_creaditCardLabel) {
        _creaditCardLabel = [[UILabel alloc] init];
        _creaditCardLabel.font = YingShowDetailTextFont;
        _creaditCardLabel.textAlignment = NSTextAlignmentLeft;
        _creaditCardLabel.textColor = KColorGray333;
    }
    return _creaditCardLabel;

}



-(UILabel *)companyLabel
{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = YingShowDetailTextFont;
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        _companyLabel.textColor = KColorGray333;
    }
    return _companyLabel;
    
}

-(UILabel *)companyPhoneLabel
{
    if (!_companyPhoneLabel) {
        _companyPhoneLabel = [[UILabel alloc] init];
        _companyPhoneLabel.font = YingShowDetailTextFont;
        _companyPhoneLabel.textAlignment = NSTextAlignmentLeft;
        _companyPhoneLabel.textColor = KColorGray333;
    }
    return _companyPhoneLabel;
    
}


-(UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] init];
        _codeLabel.font = YingShowDetailTextFont;
        _codeLabel.textAlignment = NSTextAlignmentLeft;
        _codeLabel.textColor = KColorGray333;
    }
    return _codeLabel;
}

-(UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = YingShowDetailTextFont;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.textColor = KColorGray333;
    }
    return _addressLabel;
}



@end
