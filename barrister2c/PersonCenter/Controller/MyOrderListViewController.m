//
//  MyOrderListViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/24.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "BarristerOrderModel.h"
#import "OrderViewCell.h"
#import "OrderDetailViewController.h"
#import "MeNetProxy.h"
#import "RefreshTableView.h"

@interface MyOrderListViewController ()<UITableViewDataSource,UITableViewDelegate,RefreshTableViewDelegate>

@property (nonatomic,strong) MeNetProxy *proxy;

@property (nonatomic,strong) RefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation MyOrderListViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];
    [self configData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(void)configData
{
    
    __weak typeof(*& self) weakSelf  = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[BaseDataSingleton shareInstance].userModel.userId forKey:@"userId"];
    [params setObject:[BaseDataSingleton shareInstance].userModel.verifyCode forKey:@"verifyCode"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageNum] forKey:@"page"];
    
    
    [self.proxy getOrderListWithParams:params block:^(id returnData, BOOL success) {
        if (success) {
            [weakSelf hideNoContentView];
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"list"];
            if ([XuUtlity isValidArray:array]) {
                [weakSelf handleListDataWithArray:array];
            }
            else
            {
                [weakSelf handleListDataWithArray:@[]];
            }
        }
        else
        {
            [weakSelf showNoContentView];
        }
    }];
}

-(void)handleListDataWithArray:(NSArray *)array
{
    
    __weak typeof(*&self) weakSelf = self;

    [self handleTableRefreshOrLoadMoreWithTableView:self.tableView array:array aBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.items removeAllObjects];
    }];
    
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = [array objectAtIndex:i];
        BarristerOrderModel *model = [[BarristerOrderModel alloc] initWithDictionary:dict];
        [self.items addObject:model];
    }
    [self.tableView reloadData];

    
}


-(void)configView
{
    self.title = @"我的订单";
    self.tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - TABBAR_HEIGHT) style:UITableViewStylePlain];
    [self.tableView setFootLoadMoreControl];
    self.tableView.pageSize = 10;
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
    self.tableView.refreshDelegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma -mark ---RefreshDelegate Methods ----

-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView
{
    [self configData];

}

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView
{
    [self configData];
    
}


#pragma -mark --UITableVIew Delegate Methods---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"orderList";
    OrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[OrderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    
    BarristerOrderModel *modelTemp = [self.items objectAtIndex:indexPath.row];
    cell.model = modelTemp;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BarristerOrderModel *model = [self.items objectAtIndex:indexPath.row];
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:detailVC animated:YES];

}
#pragma -mark ---

-(MeNetProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[MeNetProxy alloc] init];
    }
    return _proxy;
}

-(NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray arrayWithCapacity:10];
    }
    return _items;
}

@end