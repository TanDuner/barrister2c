//
//  YingShowSecAndThirdViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/13.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowSecAndThirdViewController.h"
#import "YingShowUserModel.h"
#import "YingShowHorSelectScrollView.h"
#import "YingShowHorSelectModel.h"

#define TextHeight 40

@interface YingShowSecAndThirdViewController ()<UITextFieldDelegate,YingShowHorScrollViewDelegate>


@property (nonatomic,strong) YingShowHorSelectScrollView *typeSelectScrollView;


@property (nonatomic,strong) UIScrollView *contentScrollView;


@property (nonatomic,strong) UIScrollView *companyContentScrollView;





@end

@implementation YingShowSecAndThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configView];
}

-(void)configView
{
    
    [self.view addSubview:self.typeSelectScrollView];
    
    [self.view addSubview:self.companyContentScrollView];

    [self.view addSubview:self.contentScrollView];
    
    self.companyContentScrollView.hidden = YES;
    
}


-(UIScrollView *)companyContentScrollView{
    if (!_companyContentScrollView) {
        _companyContentScrollView = [[UIScrollView alloc] initWithFrame:RECT(0, CGRectGetMaxY(self.typeSelectScrollView.frame) + 10, SCREENWIDTH, SCREENHEIGHT - NAVBAR_HIGHTIOS_7 - 40)];
        
        
        _contactTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, 10, SCREENWIDTH, TextHeight)];
        _contactTextField.keyboardType = UIKeyboardTypeDefault;
        _contactTextField.textColor = kFormTextColor;
        _contactTextField.cleanBtnOffset_x = _contactTextField.width - 100;
        _contactTextField.delegate = self;
        _contactTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"联系人" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_companyContentScrollView addSubview:_contactTextField];
        
        
        _companyNameTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_contactTextField.frame) + 10, SCREENWIDTH, TextHeight)];
        _companyNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _companyNameTextField.textColor = kFormTextColor;
        _companyNameTextField.cleanBtnOffset_x = _companyNameTextField.width - 100;
        _companyNameTextField.delegate = self;
        _companyNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"公司名称" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_companyContentScrollView  addSubview:_companyNameTextField];
        
        
        _companyPhoneTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_companyNameTextField.frame) + 10, SCREENWIDTH, TextHeight)];
        _companyPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _companyPhoneTextField.textColor = kFormTextColor;
        _companyPhoneTextField.cleanBtnOffset_x = _companyPhoneTextField.width - 100;
        _companyPhoneTextField.delegate = self;
        _companyPhoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"公司电话" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_companyContentScrollView addSubview:_companyPhoneTextField];
        
        
        _licenseCodeTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_companyPhoneTextField.frame) + 10, SCREENWIDTH, TextHeight)];
        _licenseCodeTextField.keyboardType = UIKeyboardTypeDefault;
        _licenseCodeTextField.textColor = kFormTextColor;
        _licenseCodeTextField.cleanBtnOffset_x = _licenseCodeTextField.width - 100;
        _licenseCodeTextField.delegate = self;
        _licenseCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"信用代码" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_companyContentScrollView addSubview:_licenseCodeTextField];
        
        
        _companyAddressTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_licenseCodeTextField.frame) + 10, SCREENWIDTH, TextHeight)];
        _companyAddressTextField.keyboardType = UIKeyboardTypeDefault;
        _companyAddressTextField.textColor = kFormTextColor;
        _companyAddressTextField.cleanBtnOffset_x = _companyAddressTextField.width - 100;
        _companyAddressTextField.delegate = self;
        _companyAddressTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"公司地址" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_companyContentScrollView addSubview:_companyAddressTextField];
        
        self.companyContentScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_addressTextField.frame) + 216 + 400);
        

    }
    return _companyContentScrollView;
}


-(UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:RECT(0, CGRectGetMaxY(self.typeSelectScrollView.frame) + 10, SCREENWIDTH, SCREENHEIGHT - NAVBAR_HIGHTIOS_7 - 40)];
    
        
        _nameTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, 10, SCREENWIDTH, TextHeight)];
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.textColor = kFormTextColor;
        _nameTextField.cleanBtnOffset_x = _nameTextField.width - 100;
        _nameTextField.delegate = self;
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"联系人" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_contentScrollView addSubview:_nameTextField];
        
        
        _phoneTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_nameTextField.frame) + 10, SCREENWIDTH, TextHeight)];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.textColor = kFormTextColor;
        _phoneTextField.cleanBtnOffset_x = _phoneTextField.width - 100;
        _phoneTextField.delegate = self;
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"电话" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_contentScrollView addSubview:_phoneTextField];
        
        
        _ID_NumberTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_phoneTextField.frame) + 10, SCREENWIDTH, TextHeight)];
        _ID_NumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _ID_NumberTextField.textColor = kFormTextColor;
        _ID_NumberTextField.cleanBtnOffset_x = _ID_NumberTextField.width - 100;
        _ID_NumberTextField.delegate = self;
        _ID_NumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"身份证" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_contentScrollView addSubview:_ID_NumberTextField];
        
        
        
        _addressTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_ID_NumberTextField.frame) + 10, SCREENWIDTH, TextHeight)];
        _addressTextField.keyboardType = UIKeyboardTypeDefault;
        _addressTextField.textColor = kFormTextColor;
        _addressTextField.cleanBtnOffset_x = _addressTextField.width - 100;
        _addressTextField.delegate = self;
        _addressTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"地址" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
        [_contentScrollView addSubview:_addressTextField];
        
        _contentScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_addressTextField.frame) + 216 + 40);
        
        
    }
    return _contentScrollView;
}



-(YingShowHorSelectScrollView *)typeSelectScrollView
{
    if (!_typeSelectScrollView) {
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(LeftPadding, LeftPadding, 200, 15)];
        label.text = @"类型";
        label.font = SystemFont(14.0f);
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = KColorGray333;
        [self.view addSubview:label];
        
        YingShowHorSelectModel *gerenModel = [[YingShowHorSelectModel alloc] init];
        gerenModel.titleStr = @"个人";
        gerenModel.isSelected = YES;
        
        YingShowHorSelectModel *companyModel = [[YingShowHorSelectModel alloc] init];
        companyModel.titleStr = @"公司";
        
        _typeSelectScrollView = [[YingShowHorSelectScrollView alloc] initWithFrame:RECT(10, CGRectGetMaxY(label.frame) + 10, SCREENWIDTH - 20, 15) items:[NSMutableArray arrayWithObjects:gerenModel,companyModel, nil]];
        _typeSelectScrollView.horScrollDelegate = self;
        
    }
    return _typeSelectScrollView;
}



-(void)didSelectItemWithSelectObject:(NSString *)selectObject ScrollView:(YingShowHorSelectScrollView *)horScrollView
{
    if ([selectObject isEqualToString:@"个人"]) {
        self.contentScrollView.hidden = NO;
        self.companyContentScrollView.hidden = YES;
        self.type  = @"0";
    }
    else{
        
        self.contentScrollView.hidden = YES;
        self.companyContentScrollView.hidden = NO;
        self.type  = @"1";
    }
}


@end
