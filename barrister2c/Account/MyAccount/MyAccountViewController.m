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

@property (nonatomic,strong) UITableView *detailTableView;

/**
 *  明细的数组
 */
@property (nonatomic,strong) NSMutableArray *detailArray;

@property (nonatomic,strong) AccountProxy *proxy;


@end

@implementation MyAccountViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
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
    
    [self.view addSubview:self.detailTableView];
    
    [XuUItlity clearTableViewEmptyCellWithTableView:self.detailTableView];

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

-(UITableView *)detailTableView
{
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        _detailTableView.tableHeaderView = self.headView;
        _detailTableView.backgroundColor = [UIColor clearColor];
        _detailTableView.backgroundView = nil;
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.showsVerticalScrollIndicator = NO;
        
    }
    return _detailTableView;
}

-(AccountProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[AccountProxy alloc] init];
    }
    return _proxy;
}

@end
