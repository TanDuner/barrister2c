//
//  MyAccountViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyAccountViewController.h"
#import "AccountProxy.h"
#import "MyAccountHeadView.h"
#import "MyAccountDetailViewController.h"
#import "MyAccountHomeCell.h"
#import "MyAccountRechargeVC.h"

#import "TiXianViewControlleer.h"

#define HeadViewHeight 115

@interface MyAccountViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  顶部headView
 */
@property (nonatomic,strong) MyAccountHeadView *headView;



@property (nonatomic,strong) AccountProxy *proxy;


@end

@implementation MyAccountViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];
    [self requestAccountData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}


-(void)requestAccountData
{
    __weak typeof(*&self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self.proxy getMyAccountDataWithParams:params Block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            if ([dict respondsToSelector:@selector(objectForKey:)]) {
                [weakSelf handleMyAccountDataWithDict:dict];
            }

        }
        else
        {
            [XuUItlity showFailedHint:@"加载账户信息失败" completionBlock:nil];
        }
    }];
}

-(void)handleMyAccountDataWithDict:(NSDictionary *)dict
{
    
    NSDictionary *accountDict = [dict objectForKey:@"account"];
    [BaseDataSingleton shareInstance].bankCardDict = [accountDict objectForKey:@"bankCard"];
    [BaseDataSingleton shareInstance].bankCardBindStatus = [accountDict objectForKey:@"bankCardBindStatus"];
    [BaseDataSingleton shareInstance].remainingBalance = [accountDict objectForKey:@"remainingBalance"];
    [BaseDataSingleton shareInstance].totalConsume = [accountDict objectForKey:@"totalIncome"];
    
    [self.headView setNeedsLayout];
    
}


#pragma -mark ----UI----

-(void)configView
{
    [self initTableView];
    self.title = @"我的账户";
    [self initNavigationRightTextButton:@"交易明细" action:@selector(toDetialAction:)];
}


/**
 *  tableView
 */
- (void)initTableView
{
    
    self.tableView.tableHeaderView = self.headView;
    
    [XuUItlity clearTableViewEmptyCellWithTableView:self.tableView];

}

#pragma -mark -Aciton--

-(void)toDetialAction:(id)sender
{
    MyAccountDetailViewController *detialVC = [[MyAccountDetailViewController alloc] init];
    [self.navigationController pushViewController:detialVC animated:YES];
}

#pragma -mark --Table Delegate 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MyAccountHomeCell *cell = [[MyAccountHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.leftImageView.image = [UIImage imageNamed:@""];
        cell.titleLabel.text = @"充值";
        return cell;
    }
    else
    {
        MyAccountHomeCell *cell = [[MyAccountHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.leftImageView.image = [UIImage imageNamed:@""];
        cell.titleLabel.text = @"提现";
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        MyAccountRechargeVC *rechargeVC = [[MyAccountRechargeVC alloc] init];
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }
    else
    {
        TiXianViewControlleer *tixian = [[TiXianViewControlleer alloc] init];
        [self.navigationController pushViewController:tixian animated:YES];
    }
}




#pragma -mark ---Getter----

-(MyAccountHeadView *)headView
{
    if (!_headView) {
        _headView = [[MyAccountHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, HeadViewHeight)];
    }
    return _headView;
}



-(AccountProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[AccountProxy alloc] init];
    }
    return _proxy;
}

@end
