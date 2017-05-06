//
//  ZLFGXSearchListCell.m
//  barrister2c
//
//  Created by 徐书传 on 17/5/6.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "ZLFGXSearchListCell.h"
#define VSpace 5
#import "YingShowInfoModel.h"
#define XingHao @"***********************"


@interface ZLFGXSearchListCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *creaditCardLabel;
@property (nonatomic,strong) UILabel *companyLabel;
@property (nonatomic,strong) UILabel *companyPhoneLabel;
@property (nonatomic,strong) UILabel *codeLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@property (nonatomic,assign) BOOL isBuy;

@property (nonatomic,strong) UILabel *zhaiTypeLabel;


@end


@implementation ZLFGXSearchListCell

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


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [kSeparatorColor setStroke];
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [linePath stroke];
    
}

+(CGFloat)getCellHeightWithModel:(YingShowUserModel *)model
{
    return 100;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //    [self.nameLabel setFrame:RECT(LeftPadding, LeftPadding, 200, 13)];
    //    [self.phoneLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.nameLabel.frame) + VSpace, 200, 13)];
    //    [self.creaditCardLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.phoneLabel.frame) + VSpace, 200, 13)];
    ////    [self.companyLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.creaditCardLabel.frame) + VSpace, 200, self.model.companyNameHeight)];
    //    [self.companyPhoneLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.companyLabel.frame) + VSpace, 200, 13)];
    //    [self.codeLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.companyPhoneLabel.frame) + VSpace, 200, 13)];
    ////    [self.addressLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.codeLabel.frame) + VSpace, 200, self.model.addressHeight)];
    
    [self.zhaiTypeLabel setFrame:RECT(LeftPadding, LeftPadding, SCREENWIDTH - 20, 15)];
    
    
    //是公司
    if (IS_NOT_EMPTY(self.model.licenseNuber)) {
        
        [self.nameLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.zhaiTypeLabel.frame) + 10, SCREENWIDTH - 20, 13)];
        [self.companyLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.nameLabel.frame) + VSpace, SCREENWIDTH - 20, self.model.companyNameHeight)];
        [self.companyPhoneLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.companyLabel.frame) + VSpace, SCREENWIDTH - 20, 13)];
        [self.codeLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.companyPhoneLabel.frame) + VSpace, SCREENWIDTH - 20, 13)];
        [self.addressLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.codeLabel.frame) + VSpace, SCREENWIDTH - 20, self.model.addressHeight)];
    }
    else{
        [self.nameLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.zhaiTypeLabel.frame) + 10, SCREENWIDTH - 20, 13)];
        [self.phoneLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.nameLabel.frame) + VSpace, SCREENWIDTH - 20, 13)];
        [self.creaditCardLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.phoneLabel.frame) + VSpace, SCREENWIDTH - 20, 13)];
        [self.addressLabel setFrame:RECT(LeftPadding, CGRectGetMaxY(self.creaditCardLabel.frame) + VSpace, SCREENWIDTH - 20, self.model.addressHeight)];
    }
    
}


-(void)configData
{
    
    
    
    //是公司
    if (IS_NOT_EMPTY(self.model.licenseNuber)) {
        self.nameLabel.text = [NSString stringWithFormat:@"姓名: %@",self.model.name?self.model.name:@"-"];
        self.companyLabel.text = [NSString stringWithFormat:@"公司: %@",self.model.company?self.model.company:@"-"];
        self.companyPhoneLabel.text = [NSString stringWithFormat:@"公司电话: %@",self.model.companyPhone?self.model.companyPhone:@"-"];
        self.codeLabel.text = [NSString stringWithFormat:@"公司信用代码: %@",self.model.licenseNuber?self.model.licenseNuber:@"-"];
        self.addressLabel.text = [NSString stringWithFormat:@"公司地址: %@",self.model.address?self.model.address:@"-"];
    }
    
    else{
        self.nameLabel.text = [NSString stringWithFormat:@"姓名: %@",self.model.name?self.model.name:@"-"];
        self.phoneLabel.text = [NSString stringWithFormat:@"联系电话: %@",self.model.phone?self.model.phone:@"-"];
        self.creaditCardLabel.text = [NSString stringWithFormat:@"身份证: %@",self.model.ID_number?self.model.ID_number:@"-"];
        self.addressLabel.text = [NSString stringWithFormat:@"联系地址: %@",self.model.address?self.model.address:@"-"];
    }

   
    
    
    
}


#pragma -mark ---Getter--

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = YingShowDetailTextFont;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = KColorGray666;
    }
    return _nameLabel;
}


-(UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = YingShowDetailTextFont;
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.textColor = KColorGray666;
    }
    return _phoneLabel;
}


-(UILabel *)creaditCardLabel
{
    if (!_creaditCardLabel) {
        _creaditCardLabel = [[UILabel alloc] init];
        _creaditCardLabel.font = YingShowDetailTextFont;
        _creaditCardLabel.textAlignment = NSTextAlignmentLeft;
        _creaditCardLabel.textColor = KColorGray666;
    }
    return _creaditCardLabel;
    
}



-(UILabel *)companyLabel
{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = YingShowDetailTextFont;
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        _companyLabel.textColor = KColorGray666;
    }
    return _companyLabel;
    
}

-(UILabel *)companyPhoneLabel
{
    if (!_companyPhoneLabel) {
        _companyPhoneLabel = [[UILabel alloc] init];
        _companyPhoneLabel.font = YingShowDetailTextFont;
        _companyPhoneLabel.textAlignment = NSTextAlignmentLeft;
        _companyPhoneLabel.textColor = KColorGray666;
    }
    return _companyPhoneLabel;
    
}


-(UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] init];
        _codeLabel.font = YingShowDetailTextFont;
        _codeLabel.textAlignment = NSTextAlignmentLeft;
        _codeLabel.textColor = KColorGray666;
    }
    return _codeLabel;
}

-(UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = YingShowDetailTextFont;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.textColor = KColorGray666;
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}


-(UILabel *)zhaiTypeLabel
{
    
    if (!_zhaiTypeLabel) {
        _zhaiTypeLabel = [[UILabel alloc] init];
        _zhaiTypeLabel.font = SystemFont(16.0f);
        _zhaiTypeLabel.textAlignment = NSTextAlignmentLeft;
        _zhaiTypeLabel.textColor = kNavigationBarColor;
    }
    return _zhaiTypeLabel;
}


@end
