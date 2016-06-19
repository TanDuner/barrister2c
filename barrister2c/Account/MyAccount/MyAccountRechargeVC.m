//
//  MyAccountRechargeVC.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyAccountRechargeVC.h"
#import "BorderTextFieldView.h"

@interface MyAccountRechargeVC ()

@property (nonatomic,strong) BorderTextFieldView *rechargeNumTextField;

@property (nonatomic,strong) UIView *reChargeView;
@property (nonatomic,strong) UIButton *confirmButton;

@end

@implementation MyAccountRechargeVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

#pragma -mark --UI --

-(void)configView
{
    self.title = @"充值";
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, LeftPadding, 200, 14)];
    tipLabel.textColor = KColorGray666;
    tipLabel.text = @"充值金额";
    tipLabel.font = SystemFont(14.0f);
    [self.view addSubview:tipLabel];
    
    
    self.rechargeNumTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftPadding, tipLabel.y + tipLabel.height + 10, SCREENWIDTH  -LeftPadding - LeftPadding, 44)];
    self.rechargeNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.rechargeNumTextField];
    
    
    UILabel *wayTipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.rechargeNumTextField.y + self.rechargeNumTextField.height + 20, 200, 14)];
    wayTipLabel.text = @"选择支付方式";
    wayTipLabel.textColor = KColorGray666;
    wayTipLabel.font = SystemFont(14.0f);
    [self.view addSubview:wayTipLabel];
    
    
    self.reChargeView = [[UIView alloc] initWithFrame:RECT(0, wayTipLabel.y + wayTipLabel.height + 10, SCREENWIDTH, 88)];
    self.reChargeView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *zhifubaoView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, (44 - 28)/2.0, 28, 28)];
    zhifubaoView.image = [UIImage imageNamed:@""];
    zhifubaoView.backgroundColor = [UIColor redColor];
    
    UILabel *zhifubaoLabel = [[UILabel alloc] initWithFrame:RECT(zhifubaoView.x + zhifubaoView.width + 12, (44 - 15)/2.0, 200, 15)];
    zhifubaoLabel.font = SystemFont(14.0f);
    zhifubaoLabel.text = @"支付宝支付";
    zhifubaoLabel.textColor = KColorGray333;
    zhifubaoLabel.textAlignment = NSTextAlignmentLeft;
    
    UIButton *zhifubaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zhifubaoButton.backgroundColor = [UIColor redColor];
    [zhifubaoButton setFrame:RECT(SCREENWIDTH - 10 - 35,  (44 - 35)/2.0, 35, 35)];
    [zhifubaoButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    zhifubaoButton.tag = 888;
    [zhifubaoButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.reChargeView addSubview:zhifubaoView];
    [self.reChargeView addSubview:zhifubaoLabel];
    [self.reChargeView addSubview:zhifubaoButton];
    
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, 43.5, SCREENWIDTH - LeftPadding, .5)];
    lineView.backgroundColor = kSeparatorColor;
    [self.reChargeView addSubview:lineView];

    
    UIImageView *weizinImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, (44 - 28)/2.0 + 44, 28, 28)];
    weizinImageView.image = [UIImage imageNamed:@""];
    weizinImageView.backgroundColor = [UIColor redColor];
    [self.reChargeView addSubview:weizinImageView];
    
    UILabel *weixinLabel = [[UILabel alloc] initWithFrame:RECT(zhifubaoView.x + zhifubaoView.width + 12,  44 + (44 - 15)/2.0, 200, 15)];
    weixinLabel.font = SystemFont(14.0f);
    weixinLabel.text = @"微信支付";
    weixinLabel.textColor = KColorGray333;
    weixinLabel.textAlignment = NSTextAlignmentLeft;
    
    UIButton *weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weixinButton setFrame:RECT(SCREENWIDTH - 10 - 35,  44 + (44 - 35)/2.0, 35, 35)];
    [weixinButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    weixinButton.backgroundColor = [UIColor redColor];
    weixinButton.tag = 999;
    [weixinButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.reChargeView addSubview:weizinImageView];
    [self.reChargeView addSubview:weixinLabel];
    [self.reChargeView addSubview:weixinButton];
    
    [self.view addSubview:self.reChargeView];
    
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton.backgroundColor = kNavigationBarColor;
    [self.confirmButton setTitle:@"充值" forState:UIControlStateNormal];
    [self.confirmButton setFrame:RECT(LeftPadding, self.reChargeView.y + self.reChargeView.height + 30, SCREENWIDTH - LeftPadding - LeftPadding, 44)];
    self.confirmButton.layer.cornerRadius = 2.0f;
    self.confirmButton.layer.masksToBounds = YES;
    
    [self.view addSubview:self.confirmButton];
}

-(void)selectAction:(UIButton *)button
{
    if (button.tag == 999) {
        UIButton *btnTemp = [self.reChargeView viewWithTag:888];
    }
    else
    {
        UIButton *btnTemp = [self.reChargeView viewWithTag:999];
    }
}

@end
