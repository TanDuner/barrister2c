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
#import "AppointmentManager.h"
#import "AppointmentMoel.h"

#define CommonViewWidth SCREENWIDTH - 30
#define SelectViewHeight 280
#define ConfirmViewHeight 245

@interface LawerSelectTimeViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *tipLabel;

@property (nonatomic,strong) UIView *selectBgView; //第一个框 选时间

@property (nonatomic,strong) UIView *confirmBgView; //第二个框 确认选择时间

@property (nonatomic,strong) UIView *confirmCostView; //第三个框 确认消费



@property (nonatomic,strong) UIView *tipBgView;

@property (nonatomic,strong) NinaPagerView *ninaPagerView;

@property (nonatomic,strong) UIButton *cancelButton;

@property (nonatomic,strong) UIButton *confrimButton;

@property (nonatomic,strong) NSMutableArray *vcArray;

@property (nonatomic,strong) NSMutableArray *selectModelArray; //有选择的model的数组

@property (nonatomic,strong) NSString *totalPrice;

@property (nonatomic,strong) NSString *type;//即时咨询还是预约咨询

@property (nonatomic,strong) UITextView *contentTextView;

@end

@implementation LawerSelectTimeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAciton)];
//    
//    [self.view addGestureRecognizer:tap];
    
    self.view.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark -------UI-------


-(void)initSelectTimeViews
{
    
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
    
    
    [self prepareData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgViewAciton)];
    [self.selectBgView addGestureRecognizer:tap];

    
    [self.selectBgView addSubview:self.cancelButton];
    
    [self.selectBgView addSubview:[self getLineViewWithFrame:RECT((CommonViewWidth - 20 - 1)/2.0, self.selectBgView.height - 32.5, .5, 30)]];
    
    
    [self.selectBgView addSubview:self.confrimButton];
    
    [self.view addSubview:self.selectBgView];
    
}

-(void)prepareData
{
    if ([AppointmentManager shareInstance].modelArray.count != 7) {
        return;
    }
    
    
    self.vcArray = [NSMutableArray arrayWithCapacity:7];
    NSMutableArray *titleArray  = [NSMutableArray arrayWithCapacity:7];
    
    for (int i = 0; i < [AppointmentManager shareInstance].modelArray.count; i ++) {
        
        AppointmentMoel *modelTemp = (AppointmentMoel *)[[AppointmentManager shareInstance].modelArray safeObjectAtIndex:i];
        LawerSelectContentViewController *contentVC = [[LawerSelectContentViewController alloc] initWithArray:nil];
        contentVC.model = modelTemp;
        [titleArray addObject:modelTemp.date];
        [self.vcArray addObject:contentVC];
        
    }
    
    NSArray *colorArray = @[
                            kNavigationBarColor, /**< 选中的标题颜色 Title SelectColor  **/
                            KColorGray666, /**< 未选中的标题颜色  Title UnselectColor **/
                            kNavigationBarColor, /**< 下划线颜色 Underline Color   **/
                            [UIColor whiteColor], /**<  上方菜单栏的背景颜色 TopTab Background Color   **/
                            ];
    
    _ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:self.vcArray WithColorArrays:colorArray isAlertShow:YES];
    [self.selectBgView addSubview:_ninaPagerView];
    
    [self.selectBgView addSubview:[self getLineViewWithFrame:RECT(0, self.selectBgView.height - 40 , CommonViewWidth, .5)]];
    
}


//显示 Appointment 预约  IM 即时
-(void)showWithType:(NSString *)type
{
    _type = type;
    if ([type isEqualToString:APPOINTMENT]) {
        [self initSelectTimeViews];
    }
    else
    {
        if ([BaseDataSingleton shareInstance].isClosePay) {
            [XuUItlity showSucceedHint:@"请等待律师跟您联系" completionBlock:nil];
            return;
        }
        [self.view addSubview:self.confirmCostView];
    }
    
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
    [[AppointmentManager shareInstance] resetData];
    
    [self.contentTextView resignFirstResponder];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:.5 animations:^{
        self.view.center = CGPointMake(SCREENWIDTH / 2.0, 1000);
        self.selectBgView.hidden = NO;
        self.confirmBgView.hidden = YES;

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

-(void)tapConfirmAciton:(UITapGestureRecognizer *)tap
{
    
}


-(BOOL)handleSelectTime
{

    for ( int i = 0; i < self.vcArray.count; i ++) {
        LawerSelectContentViewController *vc = (LawerSelectContentViewController *)[self.vcArray safeObjectAtIndex:i];
        if ([vc.commitModel.settingArray containsObject:@"2"]) {
            if (![self.selectModelArray containsObject:vc.commitModel]) {
                [self.selectModelArray addObject:vc.commitModel];
            }
            else
            {
                NSInteger index = [self.selectModelArray indexOfObject:vc.commitModel];
                [self.selectModelArray replaceObjectAtIndex:index withObject:vc.commitModel];
            }

        }
    }
    
    if (self.selectModelArray.count == 0) {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)selectConfirmAciton
{
    if (![self handleSelectTime]) {
        [XuUItlity showFailedHint:@"请选择时间" completionBlock:nil];
        return;
    }
    
    self.selectBgView.hidden = YES;
    self.confirmBgView.hidden = NO;
    
    if ([BaseDataSingleton shareInstance].isClosePay) {
        [XuUItlity showSucceedHint:@"预约成功,请联系当地律师事务所" completionBlock:nil];
        [self dismiss];
        return;
    }
    
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
        _confirmBgView.layer.cornerRadius  = 8.0f;
        _confirmBgView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapConfirmAciton:)];
        [_confirmBgView addGestureRecognizer:tap];
        UILabel *confirmTitleLabel = [[UILabel alloc] initWithFrame:RECT(15, 15, SCREENWIDTH - 30 - 30, 15)];
        confirmTitleLabel.text = @"确定要购买以下时间的服务?";
        confirmTitleLabel.textAlignment = NSTextAlignmentCenter;
        confirmTitleLabel.font = SystemFont(16.0f);
        confirmTitleLabel.textColor = KColorGray333;
        [_confirmBgView addSubview:confirmTitleLabel];
        
        [_confirmBgView addSubview:[self getLineViewWithFrame:RECT(0, 45, _confirmBgView.width, .5)]];
        
        UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        bgScrollView.tag = 1001;
        [_confirmBgView addSubview:bgScrollView];
        
        NSInteger origin_y = 5;
        NSInteger totalHeight = 0;
        NSInteger totalTimes = 0;
        for (int i = 0; i < self.selectModelArray.count; i ++ ) {
            AppointmentMoel *model = [self.selectModelArray safeObjectAtIndex:i];
            NSString *timeStr = [AppointmentMoel getStringWithModel:model];
            
            NSArray *times = [timeStr componentsSeparatedByString:@","];
            totalTimes += times.count;
            
            CGFloat height = [XuUtlity textHeightWithString:timeStr withFont:SystemFont(14.0) sizeWidth:SCREENWIDTH - LeftPadding *2 - 30];
            UILabel *label = [[UILabel alloc] initWithFrame:RECT(LeftPadding, origin_y, SCREENWIDTH - 30 - 20, height)];
            label.numberOfLines = 0;
            label.font = SystemFont(14.0f);
            label.text = timeStr;
            label.textColor = KColorGray666;
            [bgScrollView addSubview:label];
            totalHeight += 8;
            totalHeight += height;
            origin_y += height;
            origin_y += 8;
        }
        
        [bgScrollView setContentSize:CGSizeMake(0, totalHeight + 20)];
        if (totalHeight > 100) {
            totalHeight = 100;
        }
        if (totalHeight < 50) {
            totalHeight = 50;
        }
        
        [bgScrollView setFrame:RECT(0, 45, SCREENWIDTH - 30, totalHeight)];
        
        [_confirmBgView setFrame:CGRectMake(15, 100, CommonViewWidth, totalHeight + 45 + 30 + 40)];
        
        UILabel *totalCostLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, _confirmBgView.height - 70, SCREENWIDTH - 30 - 20, 15)];
        self.totalPrice = [NSString stringWithFormat:@"%f",self.lawerModel.priceAppointment.floatValue *totalTimes];
        NSString *str = [NSString stringWithFormat:@"总计：%.0f.00 元", self.totalPrice.floatValue];
        totalCostLabel.text = str;
        totalCostLabel.textColor = KColorGray333;
        totalCostLabel.font = SystemFont(14.0f);
        [_confirmBgView addSubview:totalCostLabel];
        
        [_confirmBgView addSubview:[self getLineViewWithFrame:RECT(0, _confirmBgView.height - 40, _confirmBgView.width, .5)]];

        
        UIButton *reChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reChooseBtn setTitle:@"重新选择" forState:UIControlStateNormal];
        reChooseBtn.titleLabel.font = SystemFont(15.0f);
        [reChooseBtn setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
        [reChooseBtn setFrame:RECT(10, _confirmBgView.height - 40, (CommonViewWidth - 20 - 1)/2.0, 40)];
        [reChooseBtn addTarget:self action:@selector(reChooseAciton) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBgView addSubview:reChooseBtn];
        
        [_confirmBgView addSubview:[self getLineViewWithFrame:RECT((CommonViewWidth - 20 - 1)/2.0 + 10, _confirmBgView.height - 40, .5, 40)]];

        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = SystemFont(15.0f);
        [confirmBtn setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
        [confirmBtn setFrame:RECT(10 + (CommonViewWidth - 20 - 1)/2.0, _confirmBgView.height - 40, (CommonViewWidth - 20 - 1)/2.0, 40)];
        [confirmBtn addTarget:self action:@selector(confirmTimeAction) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBgView addSubview:confirmBtn];

        
    }
    return _confirmBgView;
}

-(void)reChooseAciton
{
    
    self.selectBgView.hidden = NO;
    self.confirmBgView.hidden = YES;
    for (UIScrollView *bgScrollView in self.confirmBgView.subviews) {
        if (bgScrollView.tag == 1001) {
            [bgScrollView removeFromSuperview];
        }
    }
    self.confirmBgView = nil;
}

-(void)confirmTimeAction
{
    self.confirmBgView.hidden = YES;
    self.confirmCostView.hidden = NO;
    
    [self.view addSubview:self.confirmCostView];
}



-(UIView *)confirmCostView
{
   
    if (!_confirmCostView) {
        _confirmCostView = [[UIView alloc] initWithFrame:RECT(15, 100, SCREENWIDTH - 30, 190)];
        _confirmCostView.backgroundColor = [UIColor whiteColor];
        _confirmCostView.layer.cornerRadius = 8.0f;
        _confirmCostView.layer.masksToBounds = YES;
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(15, 15, _confirmCostView.width - 30, 15)];
        
        if ([self.type isEqualToString:IM]) {
            self.totalPrice = [NSString stringWithFormat:@"%@",self.lawerModel.priceIM];
        }
        
        tipLabel.text = [NSString stringWithFormat:@"系统将从你的账户扣除%.0f元",self.totalPrice.floatValue];
        tipLabel.font = SystemFont(14.0f);
        tipLabel.textColor = KColorGray333;
        
        [_confirmCostView addSubview:tipLabel];
        
        UILabel *describeLabel = [[UILabel alloc] initWithFrame:RECT(15, tipLabel.y + tipLabel.height + 10, _confirmCostView.width - 30, 15)];
        describeLabel.text = @"请简单描述您要咨询的问题";
        describeLabel.textColor = kNavigationBarColor;
        describeLabel.font = SystemFont(12.0f);
        
        [_confirmCostView addSubview:describeLabel];
        
        self.contentTextView = [[UITextView alloc] initWithFrame:RECT(15, describeLabel.y + describeLabel.height + 10, SCREENWIDTH - 30 - 30, 80)];
        self.contentTextView.font = SystemFont(14.0f);
        self.contentTextView.layer.cornerRadius = 2.0f;
        self.contentTextView.delegate = self;
        self.contentTextView.layer.masksToBounds = YES;
        self.contentTextView.layer.borderColor = [UIColor colorWithString:@"#cccccc" colorAlpha:.5].CGColor;
        self.contentTextView.layer.borderWidth = .5;
        self.contentTextView.textColor = KColorGray666;
        
        [_confirmCostView addSubview:self.contentTextView];
        
        
        UIButton *reChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reChooseBtn setTitle:@"取消" forState:UIControlStateNormal];
        reChooseBtn.titleLabel.font = SystemFont(15.0f);
        [reChooseBtn setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
        [reChooseBtn setFrame:RECT(10, _confirmCostView.height - 40, (CommonViewWidth - 20 - 1)/2.0, 40)];
        [reChooseBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_confirmCostView addSubview:reChooseBtn];
        
        [_confirmCostView addSubview:[self getLineViewWithFrame:RECT((CommonViewWidth - 20 - 1)/2.0 + 10, _confirmCostView.height - 40, .5, 35)]];
        
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = SystemFont(15.0f);
        [confirmBtn setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
        [confirmBtn setFrame:RECT(10 + (CommonViewWidth - 20 - 1)/2.0, _confirmCostView.height - 40, (CommonViewWidth - 20 - 1)/2.0, 40)];
        [confirmBtn addTarget:self action:@selector(confirmCostAction) forControlEvents:UIControlEventTouchUpInside];
        [_confirmCostView addSubview:confirmBtn];
        

    }
    return _confirmCostView;
}

#pragma -mark ----TextView Delegate Methods-----

- (void)textViewDidEndEditing:(UITextView *)textView;
{
    [UIView animateWithDuration:.3 animations:^{
        [self.confirmCostView setFrame:RECT(15, 100, SCREENWIDTH - 30, 190)];
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:.3 animations:^{
        [self.confirmCostView setFrame:RECT(15, 100 - 40, SCREENWIDTH - 30, 190)];
    }];


}



-(void)confirmCostAction
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishChooseAppoinmentWithMoneny:PerPrice:appointmentDateArray:Ordercontent:)]) {
        [self.delegate didFinishChooseAppoinmentWithMoneny:self.totalPrice PerPrice:self.lawerModel.priceAppointment appointmentDateArray:self.selectModelArray Ordercontent:self.contentTextView.text];
        [self dismiss];
    }
}

#pragma -mark ---Getter-----


-(NSMutableArray *)selectModelArray
{
    if (!_selectModelArray) {
        _selectModelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectModelArray;
}


@end
