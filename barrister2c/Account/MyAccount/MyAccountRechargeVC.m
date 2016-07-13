//
//  MyAccountRechargeVC.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyAccountRechargeVC.h"
#import "MeNetProxy.h"
#import "UIButton+EnlargeEdge.h"
#import "UIImage+Additions.h"
#import "AppMethod.h"
#import "WXApi.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "XWMoneyTextField.h"


@interface MyAccountRechargeVC ()<UITextFieldDelegate,XWMoneyTextFieldLimitDelegate>

@property (nonatomic,strong) XWMoneyTextField *rechargeNumTextField;

@property (nonatomic,strong) UIView *reChargeView;
@property (nonatomic,strong) UIButton *confirmButton;
@property (nonatomic,strong) MeNetProxy *proxy;

@property (nonatomic,strong) NSString *rechargeType;//wx zfb

@property (nonatomic,strong) XuURLSessionTask *task;
@end

@implementation MyAccountRechargeVC

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPayState:) name:NOTIFICATION_WXPAY_RESULT object:nil];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    
//    self.rechargeNumTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftPadding, tipLabel.y + tipLabel.height + 10, SCREENWIDTH  -LeftPadding - LeftPadding, 44)];
//    self.rechargeNumTextField.delegate = self;
//    self.rechargeNumTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;

    self.rechargeNumTextField = [[XWMoneyTextField alloc] initWithFrame:RECT(LeftPadding, tipLabel.y + tipLabel.height + 10, SCREENWIDTH  -LeftPadding - LeftPadding, 44)];
    self.rechargeNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.rechargeNumTextField.placeholder = @"请输入金额";
    self.rechargeNumTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.rechargeNumTextField.limit.delegate = self;
    self.rechargeNumTextField.limit.max = @"999999.99";
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
    [self.confirmButton setBackgroundImage:[UIImage createImageWithColor:kNavigationBarColor] forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(rechargeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.layer.cornerRadius = 2.0f;
    self.confirmButton.layer.masksToBounds = YES;
    
    [self.view addSubview:self.confirmButton];
}

#pragma mark - XWMoneyTextFieldLimitDelegate
- (void)valueChange:(id)sender{
    
    if ([sender isKindOfClass:[XWMoneyTextField class]]) {
        
        XWMoneyTextField *tf = (XWMoneyTextField *)sender;
        NSLog(@"XWMoneyTextField ChangedValue: %@",tf.text);
    }
}

#pragma -mark --Custom Methods-----

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
    [self.rechargeNumTextField resignFirstResponder];
    

    
    if ([self.rechargeType isEqualToString:@"wx"]) {
        __weak typeof(*& self)weakSelf = self;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"CN.DLS.APP2C" forKey:@"goodsInfo"];
        [params setObject:@"CN.DLS.APP2C" forKey:@"goodsName"];
        CGFloat value = self.rechargeNumTextField.text.floatValue *100;
        NSString *valueStr = [NSString stringWithFormat:@"%.0f",value];
        [params setObject:valueStr forKey:@"money"];

        [XuUItlity showLoading:@"加载中..."];
        [self.proxy getWeChatPrePayOrderWithParams:params block:^(id returnData, BOOL success) {
            if (success) {
                NSDictionary *dict = (NSDictionary *)returnData;
                
                [weakSelf weChatPayWithDict:dict];

            }
            else
            {
                [XuUItlity showFailedHint:@"支付失败" completionBlock:nil];
            }
        }];
    }
    else if ([self.rechargeType isEqualToString:@"zfb"])
    {
        __weak typeof(*& self)weakSelf = self;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"CN.DLS.APP2C" forKey:@"goodsInfo"];
        [params setObject:@"CN.DLS.APP2C" forKey:@"goodsName"];
        double value = self.rechargeNumTextField.text.doubleValue;
        NSString *valueStr = [NSString stringWithFormat:@"%.2f",value];
        [params setObject:valueStr forKey:@"money"];

     self.task =  [self.proxy getAliaPaytPrePayOrderWithParams:params block:^(id returnData, BOOL success) {
            if (success) {
                NSDictionary  *dict = (NSDictionary *)returnData;
                NSString *aliPrepayInfo = [dict objectForKey:@"aliPrepayInfo"];
                [weakSelf handleAlipayInfoWithString:aliPrepayInfo];
            }
            else
            {
                [XuUItlity showFailedHint:@"支付失败" completionBlock:nil];
            }
        }];
    }
}


-(void)handleAlipayInfoWithString:(NSString *)alipayInfo
{
//    NSArray *array = [alipayInfo componentsSeparatedByString:@"&"];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    for ( int i = 0; i < array.count; i ++) {
//        NSString *str = [array objectAtIndex:i];
//        NSRange range = [str rangeOfString:@"="];
//        if (range.location != 0) {
//            NSString *key = [str substringToIndex:range.location];
//            NSString *value = [str substringFromIndex:range.location + 1];
//            [params setValue:value forKey:key];
//        }
//    }
//    
//    if (params.allKeys.count > 0) {
//        Order *order = [[Order alloc] initWithDictionary:params];
//        if (!order.partner || !order.seller || !order.p) {
//            
//        }
//    }
    if (!alipayInfo) {
        [XuUItlity showFailedHint:@"数据错误" completionBlock:nil];
    }
    
    NSString *appScheme = @"barrister2c";

    
    
    [[AlipaySDK defaultService] payOrder:alipayInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);

        
    }];
    
}


/**
 *  从服务端获取预付订单  调起微信支付
 *
 *  @param dict
 */
-(void)weChatPayWithDict:(NSDictionary *)dict
{
    [XuUItlity hideLoading];
    NSDictionary *wxInfoDict = [dict objectForKey:@"wxPrepayInfo"];
    
    if (![wxInfoDict respondsToSelector:@selector(objectForKey:)]||wxInfoDict.allKeys.count == 0) {
        [XuUItlity showFailedHint:@"支付失败" completionBlock:nil];
        return;
    }
    
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [wxInfoDict objectForKey:@"partnerid"];
    req.prepayId            = [wxInfoDict objectForKey:@"prepayid"];
    req.package             = [wxInfoDict objectForKey:@"packageValue"];
    req.nonceStr            = [wxInfoDict objectForKey:@"noncestr"];
    NSString  *timeStr = [NSString stringWithFormat:@"%@",[wxInfoDict objectForKey:@"timestamp"]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue/1000];
    req.timeStamp           = [[NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]] intValue];
    
    // 添加签名数据并生成签名
    BOOL paramsWrong  = NO;
    NSMutableDictionary *rdict = [NSMutableDictionary dictionary];
    [rdict setObject:WeChatAppID forKey:@"appid"];
    if (req.partnerId && req.partnerId.length > 0) {
        [rdict setObject:req.partnerId forKey:@"partnerid"];
    }
    else
    {
        paramsWrong = YES;
    }
    if (req.prepayId && req.prepayId.length > 0) {
        [rdict setObject:req.prepayId forKey:@"prepayid"];
    }
    else
    {
        paramsWrong = YES;
    }
    
    if (req.nonceStr && req.nonceStr.length > 0) {
        [rdict setObject:req.nonceStr forKey:@"noncestr"];
    }
    else
    {
        paramsWrong = YES;
    }
    
    if (req.timeStamp != 0) {
        [rdict setObject:[NSString stringWithFormat:@"%u",(unsigned int)req.timeStamp] forKey:@"timestamp"];
    }
    else
    {
        paramsWrong = YES;
    }
    
    if (req.package && req.package.length > 0) {
        [rdict setObject:req.package forKey:@"package"];
    }
    else
    {
        paramsWrong = YES;
    }
    
    if (paramsWrong) {
        [XuUItlity showFailedHint:@"支付失败" completionBlock:nil];
        return;
    }



    NSDictionary *result = [AppMethod partnerSignOrder:rdict];
    req.sign                = [result objectForKey:@"sign"];
    
    // 调起客户端
    [WXApi sendReq:req];
}


-(void)refreshPayState:(NSNotification *)nsnotifi
{
    NSDictionary *dict = (NSDictionary *)nsnotifi.object;
    NSArray *array = [dict allKeys];
    if (array.count > 0) {
        NSString *key = [array safeObjectAtIndex:0];
        if (key.integerValue != 0) {
            NSString *string = [dict objectForKey:key];
            [XuUItlity showFailedHint:string completionBlock:nil];
        }
        else
        {
            [XuUItlity showSucceedHint:@"支付成功" completionBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];

        }

    }
}

#define MAX_LENTH 3
#define limited 2

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
