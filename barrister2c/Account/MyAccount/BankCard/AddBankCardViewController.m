//
//  AddBankCardViewController.m
//  barrister
//
//  Created by 徐书传 on 16/6/4.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "BorderTextFieldView.h"
#import "BankCardModel.h"
#import "AccountProxy.h"

#define RowHeight 44
#define LeftSpace 10
#define CleanBtnLessSpace 40
#define LeftViewWidth 60

@interface AddBankCardViewController ()<UITextFieldDelegate>

{
    UIView *inputBgView;
}

@property (nonatomic,strong) BorderTextFieldView *nameTextField;
@property (nonatomic,strong) BorderTextFieldView *bankNameTextField;
@property (nonatomic,strong) BorderTextFieldView *openBankNameTextField;
@property (nonatomic,strong) BorderTextFieldView *phoneTextField;
@property (nonatomic,strong) BorderTextFieldView *bankCardNumTextField;

@property (nonatomic,strong) UITextField *responderTextField;//当前焦点的textField

@property (nonatomic,strong) UIButton *confirmButton;

@property (nonatomic,strong) AccountProxy *proxy;

@end

@implementation AddBankCardViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init
{
    if (self = [super init]) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChangeFrame:) name:UIKeyboardWillHideNotification object:nil];
    };
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加银行卡";
    [self configView];
}


#pragma -mark ---UI-----

-(void)configView
{
    inputBgView = [[UIView alloc] initWithFrame:RECT(0, 15, SCREENWIDTH, RowHeight * 5 + 1)];
    inputBgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:RECT(0, 0, LeftViewWidth, RowHeight)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"姓名";
    label1.font = SystemFont(14.0f);
    
    
    _nameTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftSpace, 0, SCREENWIDTH - 100 - .5 - LeftSpace, RowHeight)];
    _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _nameTextField.textColor = kFormTextColor;
    _nameTextField.row = 1;
    _nameTextField.cleanBtnOffset_x = _nameTextField.width - CleanBtnLessSpace;
    _nameTextField.delegate = self;
    _nameTextField.textLeftOffset = LeftViewWidth + 20;
    _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入姓名" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    _nameTextField.leftView = label1;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *sepView1 = [self getLineViewWithFrame:RECT(0, _nameTextField.height, SCREENWIDTH, .5)];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:RECT(LeftSpace, 0, LeftViewWidth, RowHeight)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"银行类型";
    label2.font = SystemFont(14.0f);
    
    
    _bankNameTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftSpace, sepView1.y + sepView1.height, SCREENWIDTH - LeftSpace, RowHeight)];
    
    _bankNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _bankNameTextField.textColor = kFormTextColor;
    _bankNameTextField.cleanBtnOffset_x = _bankNameTextField.width - CleanBtnLessSpace;
    _bankNameTextField.delegate = self;
    _bankNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入银行类型" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    _bankNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _bankNameTextField.leftView = label2;
    _bankNameTextField.textLeftOffset = LeftViewWidth + 20;
    
    UIView *sepView2 = [self getLineViewWithFrame:RECT(0, _bankNameTextField.height + _bankNameTextField.y, SCREENWIDTH, .5)];

    
    UILabel *label3 = [[UILabel alloc] initWithFrame:RECT(0, 0, LeftViewWidth, RowHeight)];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.text = @"开户行";
    label3.font = SystemFont(14.0f);
    
    
    _openBankNameTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftSpace, sepView2.size.height + sepView2.y, SCREENWIDTH - LeftSpace, RowHeight)];
    _openBankNameTextField.delegate = self;
    _openBankNameTextField.cleanBtnOffset_x = _openBankNameTextField.width - CleanBtnLessSpace;
    _openBankNameTextField.textColor = kFormTextColor;
    _openBankNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入开户行" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    _openBankNameTextField.leftView = label3;
    _openBankNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _openBankNameTextField.textLeftOffset = LeftViewWidth + 20;
    
    UIView *sepView3 = [self getLineViewWithFrame:RECT(0, _openBankNameTextField.height + _openBankNameTextField.y, SCREENWIDTH, .5)];

    
    UILabel *label4 = [[UILabel alloc] initWithFrame:RECT(0, 0, LeftViewWidth, RowHeight)];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.text = @"手机号";
    label4.font = SystemFont(14.0f);


    _phoneTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftSpace, sepView3.size.height + sepView3.y, SCREENWIDTH - LeftSpace, RowHeight)];
    _phoneTextField.delegate = self;
    _phoneTextField.cleanBtnOffset_x = _phoneTextField.width - CleanBtnLessSpace;
    _phoneTextField.textColor = kFormTextColor;
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    _phoneTextField.leftView = label4;
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    _phoneTextField.textLeftOffset = LeftViewWidth + 20;

    
    UIView *sepView4 = [self getLineViewWithFrame:RECT(0, _phoneTextField.height + _phoneTextField.y, SCREENWIDTH, .5)];
    

    UILabel *label5 = [[UILabel alloc] initWithFrame:RECT(0, 0, LeftViewWidth, RowHeight)];
    label5.textAlignment = NSTextAlignmentLeft;
    label5.text = @"卡号";
    label5.font = SystemFont(14.0f);
    
    
    _bankCardNumTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftSpace, sepView4.size.height + sepView4.y, SCREENWIDTH - LeftSpace, RowHeight)];
    _bankCardNumTextField.delegate = self;
    _bankCardNumTextField.cleanBtnOffset_x = _bankCardNumTextField.width - CleanBtnLessSpace;
    _bankCardNumTextField.textColor = kFormTextColor;
    _bankCardNumTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入卡号" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    _bankCardNumTextField.leftView = label5;
    _bankCardNumTextField.leftViewMode = UITextFieldViewModeAlways;
    _bankCardNumTextField.textLeftOffset = LeftViewWidth + 20;
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [scanBtn setFrame:RECT(SCREENWIDTH - 30 - 20, 7, 30, RowHeight - 14)];
    [scanBtn setImage:[UIImage imageNamed:@"canCard.png"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(sacnCardAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bankCardNumTextField addSubview:scanBtn];
    
    
    
    [inputBgView addSubview:_nameTextField];
    [inputBgView addSubview:sepView1];

    [inputBgView addSubview:_bankNameTextField];
    [inputBgView addSubview:sepView2];

    [inputBgView addSubview:_openBankNameTextField];
    [inputBgView addSubview:sepView3];

    [inputBgView addSubview:_phoneTextField];
    [inputBgView addSubview:sepView4];

    [inputBgView addSubview:_bankCardNumTextField];
    
    [self.view addSubview:inputBgView];
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton setBackgroundColor:kNavigationBarColor];
    [_confirmButton.layer setCornerRadius:4.0f];
    [_confirmButton.layer setMasksToBounds:YES];
    [_confirmButton.titleLabel setFont:SystemFont(14.0f)];
    [_confirmButton setTitleColor:kNavigationTitleColor forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmButton setFrame:RECT(15, RowHeight *5 + 10 + 48, SCREENWIDTH - 30, 45)];
    [self.view addSubview:_confirmButton];

}

-(void)confirmAction:(UIButton *)btn
{
    if (_nameTextField.text.length > 0 &&_bankCardNumTextField.text.length > 0 && _bankNameTextField.text.length > 0 && _phoneTextField.text.length > 0 && _openBankNameTextField.text.length > 0) {
        
        if (![XuUtlity validateMobile:_phoneTextField.text]) {
            [XuUItlity showFailedHint:@"手机号不合法" completionBlock:nil];
        }
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[BaseDataSingleton shareInstance].userModel.userId,@"userId",[BaseDataSingleton shareInstance].userModel.verifyCode,@"verifyCode",_bankCardNumTextField.text,@"cardNum",_nameTextField.text,@"cardholderName",_openBankNameTextField.text,@"bankAddress",_bankNameTextField.text,@"bankName", nil];
        [self.proxy bindCarkWithParams:params block:^(id returnData, BOOL success) {
            if (success) {
                [XuUItlity showSucceedHint:@"绑定成功" completionBlock:nil];
            }
            else
            {
                [XuUItlity showFailedHint:@"绑定失败" completionBlock:nil];
            }
        }];

    }
    else
    {
        [XuUItlity showFailedHint:@"请补充完整信息" completionBlock:nil];
    }
}


#pragma -mark ----UITextField Methods-----

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat offset = self.view.height - (textField.y + textField.height + 216 + 200);
    if (offset <= 0) {
        CGRect rect = self.view.frame;
        rect.origin.y = offset;
        [UIView animateWithDuration:.5 animations:^{
            self.view.frame = rect;
        }];
    }
    
    return YES;
}



-(void)keyBoardChangeFrame:(NSNotification *)aNotification
{
    [UIView animateWithDuration:.5 animations:^{
        self.view.frame = RECT(0, NAVBAR_HIGHTIOS_7, SCREENWIDTH, SCREENHEIGHT - NAVBAR_HIGHTIOS_7);
    }];
    
}

-(void)sacnCardAction:(UIButton *)btn
{
    
//    __weak typeof(*&self) weakSelf = self;
    
    //"cardtype": "贷记卡",
    //"cardlength": 16,
    //"cardprefixnum": "518710",
    //"cardname": "MASTER信用卡",
    //"bankname": "招商银行信用卡中心",
    //"banknum": "03080010"

//    ScanCardViewController *svc = [[ScanCardViewController alloc] init];
//    svc.cardBlock = ^(BankCardModel *model)
//    {
//        [XuUItlity hideLoading];
//        weakSelf.bankNameTextField.text = model.bankname;
//        weakSelf.bankCardNumTextField.text = model.cardNum;
//    };
//    [self.navigationController pushViewController:svc animated:YES];

}

/**
 *  根据卡号识别卡的信息
 */

-(void)requestCardInfoWithCardNum:(NSString *)cardNo
{
    

}

//NSString *httpUrl = @"http://apis.baidu.com/datatiny/cardinfo/cardinfo";
//NSString *httpArg = @"cardnum=5187102112341234";
//[self request: httpUrl withHttpArg: httpArg];
//
//-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
//    NSURL *url = [NSURL URLWithString: urlStr];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
//    [request setHTTPMethod: @"GET"];
//    [request addValue: @"您自己的apikey" forHTTPHeaderField: @"apikey"];
//    [NSURLConnection sendAsynchronousRequest: request
//                                       queue: [NSOperationQueue mainQueue]
//                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
//                               if (error) {
//                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
//                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
//                               }
//                           }];
//}


@end
