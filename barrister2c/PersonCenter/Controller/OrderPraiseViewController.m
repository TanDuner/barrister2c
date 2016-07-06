//
//  OrderPraiseViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/7/2.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderPraiseViewController.h"
#import "OrderProxy.h"
#import "CWStarRateView.h"

@interface OrderPraiseViewController ()<CWStarRateViewDelegate>

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) OrderProxy *proxy;

@property (nonatomic,strong) CWStarRateView *starView;

@property (nonatomic,strong) UILabel *scroeLabel;

@property (nonatomic,strong) NSString *star;

@end

@implementation OrderPraiseViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];
}

-(void)configView
{
    
    
    self.title = @"订单评价";
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10, 200, 15)];
    tipLabel.font = SystemFont(14.0f);
    tipLabel.textColor = KColorGray999;
    tipLabel.text = @"请为此订单评分";
    [self.view addSubview:tipLabel];
    
    [self.view addSubview:self.textView];
    
    [self.view addSubview:self.starView];
    
    [self.view addSubview:self.scroeLabel];
    
    [self.textView setFrame:RECT(LeftPadding, CGRectGetMaxY(self.starView.frame) + 10, SCREENWIDTH - LeftPadding *2, 150)];
    
    
    
    
    
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
        [XuUItlity showFailedHint:@"请填评价内容" completionBlock:nil];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.textView.text,@"content",self.orderId,@"orderId", self.star,@"star",nil];
    
    [XuUItlity showLoadingInView:self.view hintText:@"正在提交"];
    
    [self.proxy appriseOrderWithParams:params Block:^(id returnData, BOOL success) {
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

#pragma -mark ----StarView Delegate Methods----

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    self.scroeLabel.text = [NSString stringWithFormat:@"%.1f分",newScorePercent *5];
    self.star = [NSString stringWithFormat:@"%.1f",newScorePercent *5];
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

-(OrderProxy *)proxy
{
    if(!_proxy)
    {
        _proxy = [[OrderProxy alloc] init];
    }
    return _proxy;
}

-(CWStarRateView *)starView
{
    if (!_starView) {
        _starView = [[CWStarRateView alloc] initWithFrame:RECT(LeftPadding, LeftPadding + 20, 150, 25) numberOfStars:5];
        [_starView setScorePercent:1];
        _starView.delegate = self;
        _starView.isAllowTap = YES;
        _starView.hasAnimation = YES;
        _starView.allowIncompleteStar = YES;
    }
    return _starView;
}

-(UILabel *)scroeLabel
{
    if (!_scroeLabel) {
        _scroeLabel = [[UILabel alloc ] initWithFrame:RECT(CGRectGetMaxX(self.starView.frame) + 10, LeftPadding + 20, 100, 25)];
        _scroeLabel.font = SystemFont(16.0f);
        _scroeLabel.text = @"5.0分";
        self.star = @"5";
        _scroeLabel.textColor = KColorGray999;
    }
    return _scroeLabel;
}

@end
