//
//  YingShowFirstViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/13.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "YingShowHorSelectScrollView.h"
#import "BorderTextFieldView.h"
#import "XWMoneyTextField.h"


@interface YingShowFirstViewController : BaseViewController

@property (nonatomic,strong) YingShowHorSelectScrollView *typeScrollView;

@property (nonatomic,strong) YingShowHorSelectScrollView *statusScrollView;

@property (nonatomic,strong) YingShowHorSelectScrollView *pingzhengScrollView;

@property (nonatomic,strong) YingShowHorSelectScrollView *panjueTypeScrollView;

@property (nonatomic,strong) UITextView *descTextView;

@property (nonatomic,strong) XWMoneyTextField *moneyTextField;


@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIImage *selectImage;

@property (nonatomic,strong) UIImage *selectPanjueImage;


@property (nonatomic,strong) UIImageView *addImageView;

@property (nonatomic,strong) UIImageView *addPanjueImageView;

@end
