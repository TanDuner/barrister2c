//
//  BarristerLoginVC.m
//  barrister
//
//  Created by 徐书传 on 16/3/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BarristerLoginVC.h"
#import "BorderTextFieldView.h"
#import "TFSButton.h"
#import "LoginProxy.h"
#import "BarristerUserModel.h"
#import "BarristerLoginManager.h"

const float MidViewHeight = 190 / 2.0;

@interface BarristerLoginVC ()<UITextFieldDelegate>
{
    UIButton *loginBtn;
    BorderTextFieldView *accountTextField;
    BorderTextFieldView *passwordTextField;
    
    UIButton *getValidCodeBtn;
}

@property (nonatomic,strong)TFSButton *validBtn;

@property (nonatomic,strong) LoginProxy *proxy;

@end



@implementation BarristerLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}


#pragma -mark ------Data-----
-(void)initData
{
    self.proxy = [[LoginProxy alloc] init];
}


#pragma -mark ----UI-------

-(void)createView
{
    [self createBaseView];
    
    [self createMidView];
    
    
    [self addBackButton];
}

-(void)addBackButton
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:kNavigationTitleColor forState:UIControlStateNormal];
    [backBtn setTitleColor:kButtonColor1Highlight forState:UIControlStateHighlighted];
    [backBtn.titleLabel setFont:SystemFont(16.0f)];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_icon"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_icon_hl"] forState:UIControlStateHighlighted];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, -10, 0, 0)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, -5, 0, 0)];
    
    UIBarButtonItem * backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBar;

}

-(void)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createBaseView
{
    
    self.navigationItem.title = @"登录";
    
}

-(void)createMidView
{
    UIView *inputBgView = [[UIView alloc] initWithFrame:RECT(0, 15, SCREENWIDTH, MidViewHeight)];
    inputBgView.backgroundColor = [UIColor whiteColor];
    
    accountTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, (MidViewHeight - 0.5)/2.0)];
    accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    accountTextField.textColor = kFormTextColor;
    accountTextField.cleanBtnOffset_x = accountTextField.width - 100;
    accountTextField.delegate = self;
    accountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    
    
    UIView *sepView = [self getLineViewWithFrame:RECT(0, accountTextField.height, SCREENWIDTH, .5)];
    
    passwordTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, sepView.size.height + sepView.y, SCREENWIDTH - 190, (MidViewHeight - 0.5)/2.0)];
    passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    passwordTextField.delegate = self;
    passwordTextField.textColor = kFormTextColor;
    passwordTextField.keyboardAppearance = UIKeyboardTypeNumberPad;
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    passwordTextField.cleanBtnOffset_x = passwordTextField.width - 100;
    
    [inputBgView addSubview:accountTextField];
    [inputBgView addSubview:sepView];
    [inputBgView addSubview:passwordTextField];
    
    [self.view addSubview:inputBgView];
    
    
    
    self.validBtn  = [[TFSButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 100, inputBgView.height - passwordTextField.height, 100, passwordTextField.height)];
    [self.validBtn addTarget:self action:@selector(requestValidCode:) forControlEvents:UIControlEventTouchUpInside];

    
    [inputBgView addSubview:self.validBtn];

    
    
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:kNavigationBarColor];
    [loginBtn.layer setCornerRadius:4.0f];
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn.titleLabel setFont:SystemFont(14.0)];
    [loginBtn setTitleColor:kNavigationTitleColor forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setFrame:RECT(15, inputBgView.y + inputBgView.height + 48, SCREENWIDTH - 30, 45)];
    [self.view addSubview:loginBtn];
    
    
    
}

#pragma -mark ------TextField Delegate Methods--------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == accountTextField) {
        if (textField.text.length > 11)
        {
            return NO;
        }
        else
        {
            return [XuUtlity validateNumber:string];
        }
    }
    else
    {
        return YES;
        
    }

}






#pragma -mark ---------Action--------




-(void)loginAction:(UIButton *)button
{
    [self.view endEditing:YES];
    
    if (accountTextField.text.length == 0 ) {
        [XuUItlity showFailedHint:@"请输入手机号" completionBlock:nil];
        return;
    }
    else if(passwordTextField.text.length == 0)
    {
        [XuUItlity showFailedHint:@"请输入验证码" completionBlock:nil];
        return;
    }
    
    if ([XuUtlity validateMobile:accountTextField.text]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:accountTextField.text,@"phone",passwordTextField.text,@"verifyCode", nil];
        [XuUItlity showLoading:@"正在登录"];
        [self.proxy loginWithParams:params Block:^(id returnData, BOOL success) {
            [XuUItlity hideLoading];
            if (success) {
                NSDictionary *dict = (NSDictionary *)returnData;
                NSDictionary *userDict = [dict objectForKey:@"user"];
                BarristerUserModel *user = [[BarristerUserModel alloc] initWithDictionary:userDict];
                [BaseDataSingleton shareInstance].userModel = user;
                
                [[BaseDataSingleton shareInstance] setLoginStateWithValidCode:user.verifyCode Phone:user.phone];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESS object:nil];

                [XuUItlity showSucceedHint:@"登录成功" completionBlock:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                
            }
            else
            {
                
                [BaseDataSingleton shareInstance].userModel.verifyCode = nil;
                [BaseDataSingleton shareInstance].userModel = nil;
                [XuUItlity showFailedHint:@"登录失败" completionBlock:nil];
            }
        }];

    }
    else
    {
        [XuUItlity showFailedHint:@"手机号不合法" completionBlock:nil];
    }
}

-(void)requestValidCode:(TFSButton *)btn
{
    if ([XuUtlity validateMobile:accountTextField.text]) {
        [btn clickSelfBtn:btn];
        [accountTextField resignFirstResponder];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:accountTextField.text,@"phone", nil];
        [XuUItlity showLoading:@"正在发送验证码..."];
        [self.proxy getValidCodeWithParams:params Block:^(id returnData, BOOL success) {
            [XuUItlity hideLoading];
            if (success) {
                [XuUItlity showSucceedHint:@"验证码已发送" completionBlock:nil];
            }
            else
            {
                [XuUItlity showFailedHint:@"发送失败" completionBlock:nil];
            
            }
        }];
    }
    else
    {
        [XuUItlity showFailedHint:@"请输入合法手机号" completionBlock:nil];
    }
}




@end
