//
//  MyAccountRechargeVC.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyAccountRechargeVC.h"
#import "BorderTextFieldView.h"
#import "MeNetProxy.h"
#import "UIButton+EnlargeEdge.h"
#import "UIImage+Additions.h"
@interface MyAccountRechargeVC ()<UITextFieldDelegate>

@property (nonatomic,strong) BorderTextFieldView *rechargeNumTextField;

@property (nonatomic,strong) UIView *reChargeView;
@property (nonatomic,strong) UIButton *confirmButton;
@property (nonatomic,strong) MeNetProxy *proxy;

@property (nonatomic,strong) NSString *rechargeType;//wx zfb

@property (nonatomic,strong) XuURLSessionTask *task;
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.task) {
        [self.task cancel];
    }
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
    zhifubaoView.image = [UIImage imageNamed:@"zhifubao"];
    
    UILabel *zhifubaoLabel = [[UILabel alloc] initWithFrame:RECT(zhifubaoView.x + zhifubaoView.width + 12, (44 - 15)/2.0, 200, 15)];
    zhifubaoLabel.font = SystemFont(14.0f);
    zhifubaoLabel.text = @"支付宝支付";
    zhifubaoLabel.textColor = KColorGray333;
    zhifubaoLabel.textAlignment = NSTextAlignmentLeft;
    
    UIButton *zhifubaoButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [zhifubaoButton setFrame:RECT(SCREENWIDTH - 10 - 35,  (44 - 35)/2.0, 35, 35)];
    [zhifubaoButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
    [zhifubaoButton setEnlargeEdgeWithTop:0 right:0 bottom:0 left:300];
    zhifubaoButton.tag = 888;
    [zhifubaoButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rechargeType = @"zfb";
    
    [self.reChargeView addSubview:zhifubaoView];
    [self.reChargeView addSubview:zhifubaoLabel];
    [self.reChargeView addSubview:zhifubaoButton];
    
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, 43.5, SCREENWIDTH - LeftPadding, .5)];
    lineView.backgroundColor = kSeparatorColor;
    [self.reChargeView addSubview:lineView];

    
    UIImageView *weizinImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, (44 - 28)/2.0 + 44, 28, 28)];
    weizinImageView.image = [UIImage imageNamed:@"weixin"];
    [self.reChargeView addSubview:weizinImageView];
    
    UILabel *weixinLabel = [[UILabel alloc] initWithFrame:RECT(zhifubaoView.x + zhifubaoView.width + 12,  44 + (44 - 15)/2.0, 200, 15)];
    weixinLabel.font = SystemFont(14.0f);
    weixinLabel.text = @"微信支付";
    weixinLabel.textColor = KColorGray333;
    weixinLabel.textAlignment = NSTextAlignmentLeft;
    
    UIButton *weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weixinButton setFrame:RECT(SCREENWIDTH - 10 - 35,  44 + (44 - 35)/2.0, 35, 35)];
    [weixinButton setEnlargeEdgeWithTop:0 right:0 bottom:0 left:300];
    [weixinButton setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    weixinButton.tag = 999;
    [weixinButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.reChargeView addSubview:weizinImageView];
    [self.reChargeView addSubview:weixinLabel];
    [self.reChargeView addSubview:weixinButton];
    
    [self.view addSubview:self.reChargeView];
    
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setTitle:@"充值" forState:UIControlStateNormal];
    [self.confirmButton setFrame:RECT(LeftPadding, self.reChargeView.y + self.reChargeView.height + 30, SCREENWIDTH - LeftPadding - LeftPadding, 44)];
    [self.confirmButton setImage:[UIImage createImageWithColor:kNavigationBarColor] forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(rechargeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.layer.cornerRadius = 2.0f;
    self.confirmButton.layer.masksToBounds = YES;
    
    [self.view addSubview:self.confirmButton];
}

-(void)selectAction:(UIButton *)button
{
    if (button.tag == 999) {
        UIButton *btnTemp = [self.reChargeView viewWithTag:888];
        [btnTemp setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
        self.rechargeType = @"wx";
    }
    else
    {
        UIButton *btnTemp = [self.reChargeView viewWithTag:999];
        [btnTemp setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
        self.rechargeType = @"zfb";
    }
}


-(void)rechargeAction:(UIButton *)btn
{
    if ([self.rechargeType isEqualToString:@"wx"]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        __weak typeof(*& self)weakSelf = self;
        [self.proxy getWeChatPrePayOrderWithParams:nil block:^(id returnData, BOOL success) {
            if (success) {
                NSLog(@"%@",returnData);
            }
            else
            {
                
            }
        }];
    }
    else if ([self.rechargeType isEqualToString:@"zfb"])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        __weak typeof(*& self)weakSelf = self;

     self.task =  [self.proxy getAliaPaytPrePayOrderWithParams:params block:^(id returnData, BOOL success) {
            if (success) {
                NSLog(@"%@",returnData);
            }
            else
            {
                
            }
        }];
    }
}


#pragma -mark ---UITextField Delegate Methods---
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}


#pragma -mark ----Getter----

-(MeNetProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[MeNetProxy alloc] init];
    }
    return _proxy;
}


@end
