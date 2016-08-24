//
//  WebAuthViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "WebAuthViewController.h"

@interface WebAuthViewController ()

@end

@implementation WebAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Web登录授权";
    [self addBackButtonOnRootWithTarget:self action:@selector(closeAction:) btnText:@"关闭"];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:RECT((SCREENWIDTH -  100)/2.0, 100, 100, 100)];
    logo.layer.cornerRadius = 5.0f;
    logo.layer.masksToBounds = YES;
    logo.image = [UIImage imageNamed:@"logo.png"];
    
    [self.view addSubview:logo];
    
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(0, CGRectGetMaxY(logo.frame) + 30, SCREENWIDTH, 15)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"web授权登录确认";
    tipLabel.font = SystemFont(17.0);
    tipLabel.textColor = KColorGray666;
    
    [self.view addSubview:tipLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:kNavigationBarColor];
    [btn setFrame:RECT((SCREENWIDTH - 200)/2, SCREENHEIGHT - 250, 200, 40)];
    [btn addTarget:self action:@selector(cofirmAuth) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3.0f;
    [self.view addSubview:btn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setFrame:RECT((SCREENWIDTH - 200)/2, SCREENHEIGHT - 180, 200, 40)];
    [cancelBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    
}


-(void)cofirmAuth
{

}

- (void)addBackButtonOnRootWithTarget:(id)target action:(SEL)action btnText:(NSString *)btnText
{
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:btnText forState:UIControlStateNormal];
    [backBtn setTitleColor:kNavigationTitleColor forState:UIControlStateNormal];
    [backBtn setTitleColor:kButtonColor1Highlight forState:UIControlStateHighlighted];
    [backBtn.titleLabel setFont:SystemFont(16.0f)];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, -10, 0, 0)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, -5, 0, 0)];
    
    UIBarButtonItem * backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBar;
}

-(void)closeAction:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
