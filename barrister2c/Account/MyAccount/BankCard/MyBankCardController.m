//
//  MyBankCardController.m
//  barrister
//
//  Created by 徐书传 on 16/6/4.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyBankCardController.h"
#import "AddBankCardViewController.h"
#import "BankCardModel.h"

@interface MyBankCardController ()

@property (nonatomic,strong) UIView *addBankCardView;

@property (nonatomic,strong) UIView *showBankCardView;

@property (nonatomic,strong) UIImageView *bankLogoImageView;

@property (nonatomic,strong) UILabel *bankNameLabel;

@property (nonatomic,strong) UILabel *phoneLabel;

@property (nonatomic,strong) UILabel *cardNumLabel;


@end

@implementation MyBankCardController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self configView];
}

-(void)configView
{
    self.title  = @"我的银行卡";
    if ([[BaseDataSingleton shareInstance].bankCardBindStatus isEqualToString:@"0"]) {
        [self.view addSubview:self.addBankCardView];
    }
    else
    {
        [self.view addSubview:self.showBankCardView];
        [self initNavigationRightTextButton:@"修改" action:@selector(toAddBankCardAction)];
        [self setBankCardDatas];
    }

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self judgeShowBankView];

}

-(void)judgeShowBankView
{
    if ([[BaseDataSingleton shareInstance].bankCardBindStatus isEqualToString:@"0"]) {
        self.addBankCardView.hidden = NO;
        self.showBankCardView.hidden = YES;
    }
    else
    {
        [self setBankCardDatas];
        self.addBankCardView.hidden = YES;
        self.showBankCardView.hidden = NO;
    }

}

-(void)setBankCardDatas
{
    
//    bankCardAddress = "<null>";
//    bankCardName = "<null>";
//    bankCardNum = "<null>";
//    bankPhone = "<null>";
//    cardType = "<null>";
//    logoName = "<null>";

    
    NSString *cardName = [[BaseDataSingleton shareInstance].bankCardDict objectForKey:@"bankCardName"];
    NSString *cardPhone = [[BaseDataSingleton shareInstance].bankCardDict objectForKey:@"cardPhone"];
    NSString *cardNum = [[BaseDataSingleton shareInstance].bankCardDict objectForKey:@"bankCardNum"];
//    NSString *cardType = [[BaseDataSingleton shareInstance].bankCardDict objectForKey:@"cardType"];
    NSString *logoName = [[BaseDataSingleton shareInstance].bankCardDict objectForKey:@"logoName"]?[[BaseDataSingleton shareInstance].bankCardDict objectForKey:@"logoName"]:@"";
    
    if (IS_NOT_EMPTY(logoName)) {
        self.bankLogoImageView.image = [UIImage imageNamed:logoName];
        if (logoName.length > 0) {
            UIColor *color = [BankCardModel getColorWithIconName:logoName];
            self.showBankCardView.backgroundColor = color;
        }
    }

   


    self.phoneLabel.text = [NSString stringWithFormat:@"%@",cardPhone?[NSString stringWithFormat:@"尾号 %@",[cardPhone substringFromIndex:cardPhone.length - 4]]:@""];
    self.bankNameLabel.text = cardName?cardName:@"";
    self.cardNumLabel.text = cardNum?[NSString stringWithFormat:@"****   ****   ****   %@", [cardNum substringFromIndex:cardNum.length - 4]]:@"";
   
    
}



#pragma -mark ---Getter---


-(UIView *)showBankCardView
{
    if (!_showBankCardView) {
        _showBankCardView = [[UIView alloc] initWithFrame:RECT(10, 15, SCREENWIDTH - 20, 100)];
        _showBankCardView.backgroundColor = RGBCOLOR(196, 81, 87);
        _showBankCardView.userInteractionEnabled = YES;
        _showBankCardView.layer.cornerRadius = 5.0f;
        _showBankCardView.layer.masksToBounds = YES;
        
        _bankLogoImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, LeftPadding, 35, 35)];
        _bankLogoImageView.image = [UIImage imageNamed:@""];
        
        _bankNameLabel = [[UILabel alloc] initWithFrame:RECT(_bankLogoImageView.x  + _bankLogoImageView.width + 10, 20, 150, 15)];
        _bankNameLabel.textColor = [UIColor whiteColor];
        _bankNameLabel.font = SystemFont(14.0f);
        
        _phoneLabel = [[UILabel alloc] initWithFrame:RECT(_showBankCardView.width - 100, 20, 100, 15)];
        _phoneLabel.textColor = KColorGray999;
        _phoneLabel.font = SystemFont(14.0f);

        _cardNumLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 100 - 50, SCREENWIDTH - 20 - 20, 25)];
        _cardNumLabel.textColor = [UIColor whiteColor];
        _cardNumLabel.font = SystemFont(25.0f);

        [_showBankCardView addSubview:_bankLogoImageView];
        [_showBankCardView addSubview:_bankNameLabel];
        [_showBankCardView addSubview:_phoneLabel];
        [_showBankCardView addSubview:_cardNumLabel];
        
        
    }
    return _showBankCardView;
}


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
    }
    return _addBankCardView;
}



-(void)toAddBankCardAction
{
    [self addCardAction];
}

-(void)addCardAction
{
    
    AddBankCardViewController *addVC = [[AddBankCardViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];

}

@end
