//
//  LawerSelectTimeViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerSelectTimeViewController.h"
#import "NinaPagerView.h"
#import "LawerSelectContentViewController.h"


#define CommonViewWidth SCREENWIDTH - 30
#define SelectViewHeight 360


@interface LawerSelectTimeViewController ()

@property (nonatomic,strong) UILabel *tipLabel;

@property (nonatomic,strong) UIView *selectBgView;

@property (nonatomic,strong) UIView *confirmBgView;

@property (nonatomic,strong) UIView *tipBgView;

@property (nonatomic,strong) NinaPagerView *ninaPagerView;

@property (nonatomic,strong) UIButton *cancelButton;

@property (nonatomic,strong) UIButton *confrimButton;

@property (nonatomic,strong) NSMutableArray *selectTimeArray;

@end

@implementation LawerSelectTimeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAciton)];
    
    [self.view addGestureRecognizer:tap];
    
    [self initViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark -------UI-------


-(void)initViews
{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.selectBgView = [[UIView alloc] init];
    self.selectBgView.layer.cornerRadius = 8.0f;
    self.selectBgView.layer.masksToBounds = YES;
    
    
    self.tipLabel = [[UILabel alloc] initWithFrame:RECT(5, 5, 200, 20)];
    self.tipLabel.font = [UIFont systemFontOfSize:14.0f];
    self.tipLabel.textColor = kNavigationBarColor;
    self.tipLabel.text = @"选择预约时间";
    
    [self.selectBgView addSubview:[self getLineViewWithFrame:RECT(0, 30, CommonViewWidth, .5)]];
    
    [self.selectBgView addSubview:self.tipLabel];
    self.selectBgView.frame = CGRectMake(15, 100, CommonViewWidth, SelectViewHeight);
    self.selectBgView.backgroundColor = [UIColor whiteColor];
    
    
    [self createSlideView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgViewAciton)];
    [self.selectBgView addGestureRecognizer:tap];

    
    [self.selectBgView addSubview:self.cancelButton];
    
    [self.selectBgView addSubview:[self getLineViewWithFrame:RECT((CommonViewWidth - 20 - 1)/2.0, self.selectBgView.height - 32.5, .5, 30)]];
    
    
    [self.selectBgView addSubview:self.confrimButton];
    
    [self.view addSubview:self.selectBgView];
    

    
}


-(void)createSlideView
{
    NSArray *titleArray = [NSArray arrayWithObjects:@"2016-05-01",@"2016-05-02",@"2016-05-03",@"2016-05-04",@"2016-05-05",@"2016-05-06",@"2016-05-07", nil];
    
    NSMutableArray *vcArray = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < titleArray.count; i ++) {
        LawerSelectContentViewController *contentVC = [[LawerSelectContentViewController alloc] initWithArray:nil];
        [vcArray addObject:contentVC];
    }
    
    NSArray *colorArray = @[
                            [UIColor brownColor], /**< 选中的标题颜色 Title SelectColor  **/
                            [UIColor grayColor], /**< 未选中的标题颜色  Title UnselectColor **/
                            [UIColor redColor], /**< 下划线颜色 Underline Color   **/
                            [UIColor whiteColor], /**<  上方菜单栏的背景颜色 TopTab Background Color   **/
                            ];
    
    _ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:vcArray WithColorArrays:colorArray];
    [self.selectBgView addSubview:_ninaPagerView];

    
    [self.selectBgView addSubview:[self getLineViewWithFrame:RECT(0, self.selectBgView.height - 35 , CommonViewWidth, .5)]];
}



-(void)initComfirmView
{
    self.confirmBgView = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 15 * 2)/2, 100, CommonViewWidth, SelectViewHeight)];
}



-(void)show
{
    [self.view setCenter:CGPointMake(self.view.center.x, 1000)];
    
    [UIView animateWithDuration:.5 animations:^{
        
        [self.view setCenter:CGPointMake(self.view.center.x, SCREENHEIGHT /2)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
            
        }
    }];
    
}


-(void)dismiss
{
    self.view.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:.5 animations:^{
        self.view.center = CGPointMake(SCREENWIDTH / 2.0, 1000);
    } completion:nil];
    
}

-(void)tapAciton
{
    [self dismiss];
}


-(void)tapBgViewAciton
{
    
}

-(void)cancelAciton
{
    [self dismiss];
}

-(void)selectConfirmAciton
{
    if (self.selectTimeArray.count == 0) {
        [XuUItlity showFailedHint:@"请选择预约时间" completionBlock:nil];
        return;
    }
    
    self.selectBgView.hidden = YES;
    
    [self.view addSubview:self.confirmBgView];
    
}

#pragma -mark ----getter---

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


-(UIView *)confirmBgView
{
    if (!_confirmBgView) {
        _confirmBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _confirmBgView.backgroundColor = [UIColor whiteColor];
        
        UILabel *confirmTitleLabel = [[UILabel alloc] initWithFrame:RECT(0, LeftPadding, 200, 15)];
        confirmTitleLabel.text = @"确定要购买以下时间的服务?";
        [_confirmBgView addSubview:confirmTitleLabel];
        
        
        for (int i = 0; i < self.selectTimeArray.count; i ++ ) {
            UILabel *label = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 15 + LeftPadding + 15, CommonViewWidth - LeftPadding *2, 15)];

            label.text = [NSString stringWithFormat:@"%@:%@",@"",@""];
            [self.selectTimeArray objectAtIndex:i];
        }
        
        
    }
    return _confirmBgView;
}

-(NSMutableArray *)selectTimeArray
{
    if (!_selectTimeArray) {
        _selectTimeArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectTimeArray;
}


@end
