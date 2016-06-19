//
//  ModifyInfoViewController.m
//  barrister
//
//  Created by 徐书传 on 16/6/8.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "ModifyInfoViewController.h"
#import "BorderTextFieldView.h"


#define RowHeight 44
#define LeftSpace 10
#define CleanBtnLessSpace 40
#define LeftViewWidth 60


@interface ModifyInfoViewController ()<UITextFieldDelegate>
{
    PersonCenterModel *modifyModel;
}
@property (nonatomic,strong)  BorderTextFieldView *modifyTextField;

@property (nonatomic,strong) UITextView *modifyTextView;


@end

@implementation ModifyInfoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(id)initWithModel:(PersonCenterModel *)model
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        modifyModel = model;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];

}

-(void)configView
{
    NSString *titleStr = modifyModel.titleStr;
    self.title = [NSString stringWithFormat:@"修改%@",titleStr];
    
    
    if ([modifyModel.titleStr isEqualToString:@"个人简介"]) {
        [self.view addSubview:self.modifyTextView];
    }
    else
    {
        [self.view addSubview:[self getModifyView]];
    }
    
    
    [self initNavigationRightTextButton:@"确认" action:@selector(confirmModify)];

    
}


#pragma -mark -----UITableView Delegate Methods------

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}



#pragma -mark --------Action-------

-(void)confirmModify
{
    if (![modifyModel.titleStr isEqualToString:@"个人简介"]) {
        modifyModel.subtitleStr = self.modifyTextField.text;
    }
    else
    {
        modifyModel.subtitleStr = _modifyTextView.text;
    }

    if (self.modifyBlock) {
        self.modifyBlock(modifyModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark ----getter------

-(UIView *)getModifyView
{
    UIView *inputBgView = [[UIView alloc] initWithFrame:RECT(0, 15, SCREENWIDTH, RowHeight  + 1)];
    inputBgView.backgroundColor = [UIColor whiteColor];
    
    self.modifyTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftSpace, 0, SCREENWIDTH - 60 - .5 - LeftSpace, RowHeight)];
    self.modifyTextField.textColor = kFormTextColor;
    self.modifyTextField.row = 1;
    self.modifyTextField.cleanBtnOffset_x = self.modifyTextField.width - CleanBtnLessSpace;
    self.modifyTextField.delegate = self;
    self.modifyTextField.textLeftOffset = 0;
    self.modifyTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"请填写%@",modifyModel.titleStr] attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    if (modifyModel.subtitleStr.length > 0 && ![modifyModel.subtitleStr isEqualToString:@"未填写"]) {
        self.modifyTextField.text =  modifyModel.subtitleStr;
    }
    
    [inputBgView addSubview:self.modifyTextField];

    return inputBgView;
}

-(UITextView *)modifyTextView
{
    if (!_modifyTextView) {
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10, 200, 12)];
        tipLabel.text = @"请填写个人简介";
        tipLabel.font = SystemFont(14.0f);
        tipLabel.textColor = KColorGray666;
        
        [self.view addSubview:tipLabel];
        _modifyTextView = [[UITextView alloc] initWithFrame:RECT(LeftPadding, 35, SCREENWIDTH - LeftPadding *2, 200)];

        
    }
    return _modifyTextView;
}


@end
