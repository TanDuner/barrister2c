//
//  YingShowDetailViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowDetailViewController.h"
#import "YingShowDetailBottomCell.h"
#import "YingShowDetailListCell.h"
#import "YingShowProxy.h"


@interface YingShowDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) YingShowProxy *proxy;

@property (nonatomic,assign) BOOL isBuy;

@property (nonatomic,strong) UIBarButtonItem *payButton;

@end

@implementation YingShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
    
}


-(void)initView
{
    [self initNavigationRightTextButton:@"支付" action:@selector(payAction)];
    
    [self.view addSubview:self.tableView];
}


- (void)initNavigationRightTextButton:(NSString *)btnText action:(SEL)action
{
    NSDictionary  *attributes = @{ NSFontAttributeName : SystemFont(16.0f), NSForegroundColorAttributeName : [UIColor whiteColor] } ;
    NSDictionary  *disableAttributes = @{ NSFontAttributeName : SystemFont(16.0f), NSForegroundColorAttributeName : kButtonColor1Highlight } ;
    self.payButton = [[UIBarButtonItem alloc]initWithTitle:btnText
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:action];
    [self.payButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.payButton setTitleTextAttributes:disableAttributes forState:UIControlStateDisabled];
    self.navigationItem.rightBarButtonItem = self.payButton;
}

-(void)payAction
{
    
    [XuUItlity showYesOrNoAlertView:@"" noText:@"取消" title:@"提示" mesage:@"查看债权详细信息，系统将从余额扣除16元" callback:^(NSInteger buttonIndex, NSString *inputString) {
        if (buttonIndex == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.model.yingShowInfoId,@"id", nil];
            
            __weak typeof(*& self) weakSelf = self;
            self.payButton.enabled = NO;
            
            [XuUItlity showLoading:@"正在支付..."];
            [self.proxy buyYingShowInfoWithParams:params block:^(id returnData, BOOL success) {
                [XuUItlity hideLoading];
                if (success) {
                    NSDictionary *dict = (NSDictionary *)returnData;
                    NSDictionary *infoDict = [dict objectForKey:@"detail"];
                    if (infoDict) {
                        YingShowInfoModel *model = [[YingShowInfoModel alloc] initWithDictionary:infoDict];
                        self.model = model;
                        [weakSelf HandleDetailInfoWithisBuy:YES];
                    }
                    
                }
                else{
                    
                    self.payButton.enabled = YES;
                }
            }];

        }
        else
        {
        
            
        }
    }];
    
    
    
}


-(void)initData
{
    __weak typeof(*&self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.model.yingShowInfoId,@"id", nil];
    [self.proxy getYingShowInfoDetailWithParams:params block:^(id returnData, BOOL success) {
        if (success) {
            if ([returnData isKindOfClass:[NSString class]] && [returnData isEqualToString:@"未购买"]) {
                [weakSelf HandleDetailInfoWithisBuy:NO];
            }
            else{
                
                NSDictionary *dict = (NSDictionary *)returnData;
                NSDictionary *infoDict = [dict objectForKey:@"detail"];
                if (infoDict) {
                    YingShowInfoModel *model = [[YingShowInfoModel alloc] initWithDictionary:infoDict];
                    self.model = model;
                }
                self.payButton.enabled = NO;
                
                [weakSelf HandleDetailInfoWithisBuy:YES];

            }
        }
        else{
            
        }
    }];
   
}



-(void)HandleDetailInfoWithisBuy:(BOOL)isBuy
{
    
    _isBuy = isBuy;
    [self.tableView reloadData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showTabbar:YES];
    
}

#pragma -mark ---UITableView Delegate Methods---

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 87;
    }
    else if (indexPath.section == 1)
    {
       return [YingShowDetailBottomCell getCellHeightWithModel:self.model.creditUser];
    }
    else if (indexPath.section == 2)
    {
       return [YingShowDetailBottomCell getCellHeightWithModel:self.model.debtUser];
    }
    else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YingShowDetailListCell *cell = [[YingShowDetailListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section == 1)
    {
        YingShowDetailBottomCell *cell = [[YingShowDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil isBuy:self.isBuy];
        cell.model = self.model.creditUser;
        cell.isCreadit = YES;
        return cell;
    }
    else if (indexPath.section == 2)
    {
        YingShowDetailBottomCell *cell = [[YingShowDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil isBuy:self.isBuy];
        cell.isCreadit = NO;
        cell.model = self.model.debtUser;
        return cell;
    }
    return nil;
}


#pragma -mark ---Getter----

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_HIGHTIOS_7) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


-(YingShowProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[YingShowProxy alloc] init];
    }
    return _proxy;
}


@end
