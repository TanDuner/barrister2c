//
//  RewardSelectViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/7/5.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "RewardSelectViewController.h"
#import "OrderProxy.h"


#define CommonViewWidth SCREENWIDTH - 30
#define SelectViewHeight 360

@interface RewardSelectViewController ()

@property (nonatomic,strong) UIView *selectBgView;

@property (nonatomic,strong) UILabel *tipLabel;

@property (nonatomic,strong) UIButton *cancelButton;

@property (nonatomic,strong) UIButton *confrimButton;

@property (nonatomic,strong) NSArray *monenyArray;

@property (nonatomic,strong) OrderProxy *proxy;

@property (nonatomic,strong) NSString *moneny;

@property (nonatomic,strong) NSMutableArray *btnArray;

@end





@implementation RewardSelectViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.monenyArray = [NSArray arrayWithObjects:@"1元",@"3元",@"5元",@"10元",@"15元",@"50元", nil];

    
    [self initSubViews];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    

}

#define BtnWidth (SCREENWIDTH - 30 - 4 *20)/3.0
#define BtnHeight 30
-(void)initSubViews
{
    
    self.selectBgView = [[UIView alloc] init];
    self.selectBgView.layer.cornerRadius = 8.0f;
    self.selectBgView.layer.masksToBounds = YES;
    
    
    self.tipLabel = [[UILabel alloc] initWithFrame:RECT((CommonViewWidth - 200)/2.0, 10, 200, 20)];
    self.tipLabel.font = [UIFont systemFontOfSize:14.0f];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = kNavigationBarColor;
    self.tipLabel.text = @"选择打赏金额";
    
    [self.selectBgView addSubview:[self getLineViewWithFrame:RECT(0, 40, SCREENWIDTH - 30, .5)]];
    
    [self.selectBgView addSubview:self.tipLabel];
    self.selectBgView.frame = CGRectMake(15, 100, CommonViewWidth, 220);
    self.selectBgView.backgroundColor = [UIColor whiteColor];
    
    
    
    for (int i = 0; i < self.monenyArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      
        btn.backgroundColor = [UIColor whiteColor];
        [btn setFrame:RECT(20 + (i%3)*(BtnWidth + 20), 50 + (i/3)*(BtnHeight + 20), BtnWidth, BtnHeight)];
        btn.layer.cornerRadius  = 2.0f;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = .2f;
        [btn setTitle:[self.monenyArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:KColorGray999 forState:UIControlStateNormal];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 2) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:kNavigationBarColor];
            self.moneny =[ self.monenyArray objectAtIndex:i];
        }
        [self.btnArray addObject:btn];
        [self.selectBgView addSubview:btn];
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgViewAciton)];
    [self.selectBgView addGestureRecognizer:tap];
    
    
    [self.selectBgView addSubview:[self getLineViewWithFrame:RECT(0, self.selectBgView.height - 40, SCREENWIDTH - 30, .5)]];

    
    [self.selectBgView addSubview:self.cancelButton];
    
    [self.selectBgView addSubview:[self getLineViewWithFrame:RECT((CommonViewWidth - 20 - 1)/2.0, self.selectBgView.height - 32.5, .5, 30)]];
    
    
    [self.selectBgView addSubview:self.confrimButton];
    
    [self.view addSubview:self.selectBgView];
}


-(void)show
{
    
    [self.view setCenter:CGPointMake(self.view.center.x, 1000)];
    
    [UIView animateWithDuration:.5 animations:^{
        
        [self.view setCenter:CGPointMake(self.view.center.x, SCREENHEIGHT /2)];
        self.selectBgView.hidden = NO;
    } completion:^(BOOL finished) {
        if (finished) {
            self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
            
        }
    }];

}


-(void)dismiss
{
    self.moneny = nil;
    self.view.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:.5 animations:^{
        self.view.center = CGPointMake(SCREENWIDTH / 2.0, 1000);
        self.selectBgView.hidden = YES;
        
    } completion:nil];
    
}


-(void)btnAction:(UIButton *)btn
{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:kNavigationBarColor];


    for ( int i = 0; i < self.btnArray.count; i ++) {
        UIButton *btnTmep = [self.btnArray objectAtIndex:i];
        if (btnTmep != btn) {
            [btnTmep setTitleColor:KColorGray999 forState:UIControlStateNormal];
            btnTmep.backgroundColor = [UIColor whiteColor];
        }
        
    }
    if (self.monenyArray.count > btn.tag - 1000) {
        NSString *moneny = [self.monenyArray objectAtIndex:btn.tag  -1000];
        self.moneny = moneny;
    }
}


-(void)selectConfirmAciton
{
    if (IS_NOT_EMPTY(self.moneny)) {
        __weak typeof(*&self) weakSelf = self;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.detailModel.orderId forKey:@"orderId"];
        [params setObject:[self.moneny substringToIndex:self.moneny.length - 1] forKey:@"money"];
        [self.proxy rewardOrderWithParams:params Block:^(id returnData, BOOL success) {
            if (success) {
                [XuUItlity showSucceedHint:@"打赏成功" completionBlock:^{
                    [weakSelf dismiss];
                }];
            }
            else
            {
                [XuUItlity showFailedHint:@"打赏失败" completionBlock:nil];
            }
        }];

    }
    else
    {
        [XuUItlity showFailedHint:@"数据异常" completionBlock:nil];
    }

    
}

-(void)tapBgViewAciton
{

}

-(void)cancelAciton
{
    [self dismiss];
}

-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = SystemFont(15.0f);
        [_cancelButton setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
        [_cancelButton setFrame:RECT(10, self.selectBgView.height - 40, (CommonViewWidth - 20 - 1)/2.0, 40)];
        [_cancelButton addTarget:self action:@selector(cancelAciton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

-(UIButton *)confrimButton
{
    if (!_confrimButton) {
        _confrimButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confrimButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confrimButton setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
        _confrimButton.titleLabel.font = SystemFont(15.0f);
        [_confrimButton setFrame:RECT(10 + (CommonViewWidth - 20 - 1)/2.0 + .5 , self.selectBgView.height - 40, (CommonViewWidth - 20)/2.0, 40)];
        [_confrimButton addTarget:self action:@selector(selectConfirmAciton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confrimButton;
}

-(OrderProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[OrderProxy alloc] init];
    }
    return _proxy;
}

-(NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _btnArray;
}



@end
