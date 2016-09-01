//
//  NeedHelpViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "NeedHelpViewController.h"
#import "BorderTextFieldView.h"
#import "MeNetProxy.h"

#define TextHeight 40

@interface NeedHelpViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) BorderTextFieldView *nameTextField;

@property (nonatomic,strong) BorderTextFieldView *phoneTextField;

@property (nonatomic,strong) BorderTextFieldView *emailTextField;

@property (nonatomic,strong) BorderTextFieldView *companyTextField;

@property (nonatomic,strong) BorderTextFieldView *areaTextField;

@property (nonatomic,strong) UITextView *introTextView;

@property (nonatomic,assign) CGFloat keyBoardHeight;

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) MeNetProxy *proxy;

@end

@implementation NeedHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要求助";
    
    [self createView];
    
    [self initNavigationRightTextButton:@"发布" action:@selector(publishCaseSource)];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardwillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardwillhide:) name:UIKeyboardWillHideNotification object:nil];
    
}


-(void)createView
{
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, self.view.height)];
    
    
    _nameTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, 10, SCREENWIDTH, TextHeight)];
    _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _nameTextField.textColor = kFormTextColor;
    _nameTextField.cleanBtnOffset_x = _nameTextField.width - 100;
    _nameTextField.delegate = self;
    _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入当事人姓名" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];

    [self.contentScrollView addSubview:_nameTextField];
    
    
    _phoneTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_nameTextField.frame) + 10, SCREENWIDTH, TextHeight)];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.textColor = kFormTextColor;
    _phoneTextField.cleanBtnOffset_x = _phoneTextField.width - 100;
    _phoneTextField.delegate = self;
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    
    [self.contentScrollView addSubview:_phoneTextField];
    
    
    _emailTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_phoneTextField.frame) + 10, SCREENWIDTH, TextHeight)];
    _emailTextField.keyboardType = UIKeyboardTypeNumberPad;
    _emailTextField.textColor = kFormTextColor;
    _emailTextField.cleanBtnOffset_x = _emailTextField.width - 100;
    _emailTextField.delegate = self;
    _emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邮箱" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    
    [self.contentScrollView addSubview:_emailTextField];
    
    _companyTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_emailTextField.frame) + 10, SCREENWIDTH, TextHeight)];
    _companyTextField.keyboardType = UIKeyboardTypeNumberPad;
    _companyTextField.textColor = kFormTextColor;
    _companyTextField.cleanBtnOffset_x = _companyTextField.width - 100;
    _companyTextField.delegate = self;
    _companyTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入公司（个人不填写）" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    
    [self.contentScrollView addSubview:_companyTextField];
    
    _areaTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_companyTextField.frame) + 10, SCREENWIDTH, TextHeight)];
    _areaTextField.keyboardType = UIKeyboardTypeNumberPad;
    _areaTextField.textColor = kFormTextColor;
    _areaTextField.cleanBtnOffset_x = _companyTextField.width - 100;
    _areaTextField.delegate = self;
    _areaTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入地区" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    
    [self.contentScrollView addSubview:_areaTextField];
    
    
    _introTextView = [[UITextView alloc] initWithFrame:RECT(0, CGRectGetMaxY(_areaTextField.frame) + 10, SCREENWIDTH, 180)];
    _introTextView.delegate = self;
    _introTextView.text = @"请输入案情描述";
    _introTextView.textColor = KColorGray999;
    
    [self.contentScrollView addSubview:_introTextView];
    
    self.contentScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_introTextView.frame) + 216 + 30);
    
    
    [self.view addSubview:self.contentScrollView];
}


-(void)publishCaseSource
{
    
    
    if (IS_EMPTY(_nameTextField.text)) {
        [XuUItlity showFailedHint:@"请输入当事人姓名" completionBlock:nil];
        return;
    }
    
    if (![XuUtlity validateMobile:_phoneTextField.text]) {
        [XuUItlity showFailedHint:@"请输入正确的手机号" completionBlock:nil];
        return;
    }
    
    if (IS_EMPTY(_emailTextField.text)) {
        [XuUItlity showFailedHint:@"请输入邮箱" completionBlock:nil];
        return;
    }
    
 
    
    if (IS_EMPTY(_areaTextField.text)) {
        [XuUItlity showFailedHint:@"请输入地区" completionBlock:nil];
        return;
    }
    
    if (IS_EMPTY(_introTextView.text)) {
        [XuUItlity showFailedHint:@"请输入案情描述" completionBlock:nil];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_nameTextField.text forKey:@"contact"];
    [params setObject:_phoneTextField.text forKey:@"contactPhone"];

    [params setObject:_emailTextField.text forKey:@"email"];
    [params setObject:_introTextView forKey:@"caseInfo"];
    
    if (!IS_EMPTY(_companyTextField.text)) {
        [params setObject:_companyTextField.text forKey:@"company"];
    }
    if ([XuUtlity validateEmail:_emailTextField.text]) {
        [params setObject:_emailTextField.text forKey:@"email"];
        
    }
    
    [self.proxy publishCaseSourceWithParams:params block:^(id returnData, BOOL success) {
        if (success) {
            [XuUItlity showFailedHint:@"发布成功" completionBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [XuUItlity showFailedHint:@"发布失败" completionBlock:nil];
        }
    }];
    
   
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
    
}


-(MeNetProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[MeNetProxy alloc] init];
    }
    return _proxy;
}


@end
