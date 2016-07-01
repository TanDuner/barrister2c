//
//  FeedBackViewController.m
//  barrister
//
//  Created by 徐书传 on 16/6/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "FeedBackViewController.h"
#import "MeNetProxy.h"
#import "BorderTextFieldView.h"

@interface FeedBackViewController ()

@property (nonatomic,strong) UITextField *phoneTextField;

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) MeNetProxy *proxy;
@end

@implementation FeedBackViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];
}

-(void)configView
{
    
    
    self.title = @"意见反馈";
    
    [self.view addSubview:self.phoneTextField];
    
    [self.phoneTextField setFrame:RECT(LeftPadding, LeftPadding, SCREENWIDTH - LeftPadding *2, 40)];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.phoneTextField.frame) + 10, 200, 15)];
    tipLabel.font = SystemFont(14.0f);
    tipLabel.textColor = KColorGray999;
    tipLabel.text = @"请填写您的反馈内容";
    [self.view addSubview:tipLabel];
    
    [self.view addSubview:self.textView];
    
    [self.textView setFrame:RECT(LeftPadding, CGRectGetMaxY(tipLabel.frame) + 10, SCREENWIDTH - LeftPadding *2, 150)];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = SystemFont(14.0f);
    btn.backgroundColor = kNavigationBarColor;
    btn.layer.cornerRadius = 3.0f;
    btn.layer.masksToBounds = YES;
    [btn setFrame:RECT(LeftPadding, CGRectGetMaxY(self.textView.frame) + 10, SCREENWIDTH - LeftPadding *2, 44)];
    [btn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

-(void)commitAction
{
    if (self.textView.text == nil || self.textView.text.length == 0) {
        [XuUItlity showFailedHint:@"请填写反馈信息" completionBlock:nil];
        return;
    }
    if (self.phoneTextField.text == nil || self.textView.text.length == 0) {
        [XuUItlity showFailedHint:@"请填写联系方式" completionBlock:nil];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[BaseDataSingleton shareInstance].userModel.userId,@"userId",[BaseDataSingleton shareInstance].userModel.verifyCode,@"verifyCode",self.textView.text,@"content",self.phoneTextField.text,@"contact", nil];
    
    [XuUItlity showLoadingInView:self.view hintText:@"正在提交"];
    [self.proxy feedBackWithParams:params block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        if (success) {
            [XuUItlity showSucceedHint:@"提交成功" completionBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }
        else
        {
            [XuUItlity showFailedHint:@"提交失败" completionBlock:nil];
        }
    }];
    
}


#pragma -mark --- Getter----
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.layer.cornerRadius  = 5.0f;
        _textView.layer.borderColor = KColorGray999.CGColor;
        _textView.layer.borderWidth =  .1;
        _textView.textColor = KColorGray666;
        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}

-(UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.font = SystemFont(14.0f);
        _phoneTextField.textColor = KColorGray666;
        _phoneTextField.placeholder = @"请留下联系方式";
    }
    return _phoneTextField;
}

-(MeNetProxy *)proxy
{
    if(!_proxy)
    {
        _proxy = [[MeNetProxy alloc] init];
    }
    return _proxy;
}

@end
