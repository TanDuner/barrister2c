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
    BarristerOrderModel *model1 = [[BarristerOrderModel alloc] init];
    model1.name = @"张振华律师";
    model1.userIcon = @"http://img4.duitang.com/uploads/item/201508/26/20150826212734_ST5BC.thumb.224_0.jpeg";
    model1.startTime = @"2016/04/24 13:00";
    model1.endTime = @"2016/03/24 14:00";
    model1.date = @"2015 - 06- 08";
    model1.caseType = @"债务纠纷";
    model1.orderType = BarristerOrderTypeYYZX;
    model1.orderState = BarristerOrderStateFinished;
 
    [self.items addObject:model1];
}

-(void)configView
{
    self.title = @"我的订单";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma -mark --UITableVIew Delegate Methods---

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

@end
