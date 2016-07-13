//
//  TiXianViewControlleer.m
//  barrister
//
//  Created by 徐书传 on 16/5/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "TiXianViewControlleer.h"
#import "BorderTextFieldView.h"
#import "UIButton+EnlargeEdge.h"
#import "AccountProxy.h"
#import "MyBankCardController.h"
#import "XWMoneyTextField.h"

#define RowHeight 45
#define LeftSpace 10
#define CleanBtnLessSpace 40
#define LeftViewWidth 60

@interface TiXianViewControlleer ()<UITextFieldDelegate,XWMoneyTextFieldLimitDelegate>

@property (nonatomic,strong) XWMoneyTextField *tixianTextField;
@property (nonatomic,strong) UIButton *checkButton;

@property (nonatomic,strong) UIButton *tixianButton;

@property (nonatomic,assign) BOOL isCheched;//是否勾选同意按钮

@property (nonatomic,strong) AccountProxy *proxy;
@end

@implementation TiXianViewControlleer

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"提现";
    [self confiView];
    [self initNavigationRightTextButton:@"银行卡" action:@selector(toBankCardVCAction:)];
    
}

-(void)confiView
{
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftSpace, 10, SCREENHEIGHT - 30, 15)];
    tipLabel.font = SystemFont(14.0f);
    tipLabel.textColor = kFontColorNormal;
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.text = [NSString stringWithFormat:@"本次最大提现金额:%@",[BaseDataSingleton shareInstance].remainingBalance?[BaseDataSingleton shareInstance].remainingBalance:@"0"];
    
    [self.view addSubview:tipLabel];

    
    UIView *inputBgView = [[UIView alloc] initWithFrame:RECT(0, tipLabel.y + tipLabel.height + 15, SCREENWIDTH, RowHeight + 1)];
    inputBgView.backgroundColor = [UIColor whiteColor];

    
    UILabel *label1 = [[UILabel alloc] initWithFrame:RECT(0, 0, LeftViewWidth, RowHeight)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"金额:";
    label1.font = SystemFont(14.0f);
    
    
    self.tixianTextField = [[XWMoneyTextField alloc] initWithFrame:RECT(LeftSpace, 0, SCREENWIDTH - 100 - .5 - LeftSpace, RowHeight)];
    self.tixianTextField.borderStyle = UITextBorderStyleNone;
    self.tixianTextField.placeholder = @"请输入金额";
    self.tixianTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.tixianTextField.limit.delegate = self;
    self.tixianTextField.limit.max = @"99999.99";

    
    [inputBgView addSubview:self.tixianTextField];
    [self.view addSubview:inputBgView];
    
    
    
    self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkButton setFrame:RECT(LeftSpace, inputBgView.y + inputBgView.height + 10, 20, 20)];
    [self.checkButton setEnlargeEdgeWithTop:0 right:100 bottom:100 left:0];
    [self.checkButton setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    [self.checkButton addTarget:self action:@selector(checkAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkButton];
    
    UILabel *xieyiLabel = [[UILabel alloc] initWithFrame:RECT(self.checkButton.x + self.checkButton.width + 15, self.checkButton.y, 200, 20)];
    xieyiLabel.textAlignment = NSTextAlignmentLeft;
    xieyiLabel.text = @"我同意大律师提现协议";
    xieyiLabel.font = SystemFont(14.0f);
    [self.view addSubview:xieyiLabel];
    
    
    self.tixianButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tixianButton setTitle:@"提现" forState:UIControlStateNormal];
    [self.tixianButton setBackgroundColor:kNavigationBarColor];
    [self.tixianButton.layer setCornerRadius:4.0f];
    [self.tixianButton.layer setMasksToBounds:YES];
    [self.tixianButton.titleLabel setFont:SystemFont(14.0f)];
    [self.tixianButton setTitleColor:kNavigationTitleColor forState:UIControlStateNormal];
    [self.tixianButton addTarget:self action:@selector(tixianAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tixianButton setFrame:RECT(15, RowHeight *3 + 10 + 48, SCREENWIDTH - 30, 45)];
    [self.view addSubview:self.tixianButton];

}

#pragma mark - XWMoneyTextFieldLimitDelegate
- (void)valueChange:(id)sender{
    
    if ([sender isKindOfClass:[XWMoneyTextField class]]) {
        
        XWMoneyTextField *tf = (XWMoneyTextField *)sender;
        NSLog(@"XWMoneyTextField ChangedValue: %@",tf.text);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([XuUtlity validateNumber:textField.text]) {
        //不能大于余额
        if (textField.text.floatValue <= [BaseDataSingleton shareInstance].remainingBalance.floatValue) {
            return YES;
        }
        else
        {
            [XuUItlity showSucceedHint:@"提现金额大于余额" completionBlock:nil];
            return NO;
        }
        
        return YES;
    }
    return NO;
}



-(void)toBankCardVCAction:(UIButton *)btn
{
    MyBankCardController *myBankCardController = [[MyBankCardController alloc] init];
    [self.navigationController pushViewController:myBankCardController animated:YES];
}

-(void)tixianAction:(UIButton *)button
{
    if (!self.isCheched) {
        [XuUItlity showFailedHint:@"请同意大律师提现协议" completionBlock:nil];
        return;
    }
    if (self.tixianTextField.text.length == 0 || self.tixianTextField.text.floatValue > [BaseDataSingleton shareInstance].remainingBalance.floatValue) {
        [XuUItlity showFailedHint:@"请输入正确的提现金额" completionBlock:nil];
        return;
    }
    
    if ([XuUtlity validateNumber:self.tixianTextField.text]) {
        if (self.tixianTextField.text.floatValue <= [BaseDataSingleton shareInstance].remainingBalance.floatValue) {
            
            [XuUItlity showLoading:@"正在提交"];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[BaseDataSingleton shareInstance].userModel.userId,@"userId",[BaseDataSingleton shareInstance].userModel.verifyCode,@"verifyCode",self.tixianTextField.text,@"moneny", nil];
            
            [self.proxy tiXianActionWithMoney:params Block:^(id returnData, BOOL success) {
                [XuUItlity hideLoading];
                if (success) {
                    [XuUItlity showSucceedHint:@"提交成功" completionBlock:nil];
                }
                else
                {
                    [XuUItlity showFailedHint:@"提交失败" completionBlock:nil];
                }
            }];
        }
        
        
    }
    else
    {
        [XuUItlity showFailedHint:@"金额错误" completionBlock:nil];
    }
    
}

-(void)checkAciton:(UIButton *)checkAciton
{
    self.isCheched = !self.isCheched;
    if (self.isCheched) {
        [self.checkButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
    }
    else
    {
        [self.checkButton setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    }
}


#pragma -mark ---Proxy-----
-(AccountProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[AccountProxy alloc] init];
    }
    return _proxy;
}


@end
