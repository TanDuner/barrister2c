//
//  MyBankCardController.m
//  barrister
//
//  Created by 徐书传 on 16/6/4.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyBankCardController.h"
#import "AddBankCardViewController.h"

@interface MyBankCardController ()

@property (nonatomic,strong) UIView *addBankCardView;

@end

@implementation MyBankCardController

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

-(void)configView
{
    self.title  = @"我的银行卡";
    [self.view addSubview:self.addBankCardView];
}

#pragma -mark ---Getter---

-(UIView *)addBankCardView
{
    if (!_addBankCardView) {
        _addBankCardView = [[UIView alloc] initWithFrame:RECT(10, 15, SCREENWIDTH - 20, 100)];
        _addBankCardView.backgroundColor = [UIColor whiteColor];
        _addBankCardView.userInteractionEnabled = YES;
        _addBankCardView.layer.cornerRadius = 5.0f;
        _addBankCardView.layer.masksToBounds = YES;
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn addTarget:self action:@selector(addCardAction) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setImage:[UIImage imageNamed:@"addBankCard.png"] forState:UIControlStateNormal];
        [addBtn setFrame:RECT((SCREENWIDTH - 20 - 30)/2.0, (100 - 30)/2.0 - 15, 30, 30)];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(0, addBtn.y + addBtn.height, SCREENWIDTH - 20, 15)];
        tipLabel.text = @"添加银行卡";
        tipLabel.userInteractionEnabled = YES;
        tipLabel.font = SystemFont(14.0f);
        tipLabel.textColor = kFontColorNormal;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        
        [_addBankCardView addSubview:tipLabel];
        [_addBankCardView addSubview:addBtn];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:RECT(0, 0, _addBankCardView.width, _addBankCardView.height)];
        [btn addTarget:self action:@selector(addCardAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_addBankCardView addSubview:btn];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCardAction)];
//        [_addBankCardView addGestureRecognizer:tap];
//        
//        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCardAction)];
//        [tipLabel addGestureRecognizer:tap1];
        

    }
    return _addBankCardView;
}



-(void)addCardAction
{
    NSLog(@"点击添加银行卡");
    
    AddBankCardViewController *addVC = [[AddBankCardViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];

}

@end
