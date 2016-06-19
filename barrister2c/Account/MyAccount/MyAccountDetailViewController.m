//
//  MyAccountDetailViewController.m
//  barrister
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyAccountDetailViewController.h"
#import "MyAccountDetailModel.h"
#import "AccountProxy.h"
#import "MyAccountDetailCell.h"

@interface MyAccountDetailViewController ()

@property (nonatomic,strong) AccountProxy *proxy;

@end

@implementation MyAccountDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self confgiView];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}


#pragma -mark --UI --

-(void)confgiView
{
    self.title  = @"交易明细";
    [self.tableView setFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT)];
    [self addRefreshHeader];
    [self addLoadMoreFooter];
}

-(void)loadItems
{
    MyAccountDetailModel *model1 = [[MyAccountDetailModel alloc] init];
    model1.titleStr = @"2014443043053";
    model1.dateStr = @"2016-05-25";
    model1.handleType = 0;
    model1.numStr = @"140";
    
    MyAccountDetailModel *model2 = [[MyAccountDetailModel alloc] init];
    model2.titleStr = @"2014443043053";
    model2.dateStr = @"2016-05-25";
    model2.handleType = 0;
    model2.numStr = @"30";
    
    MyAccountDetailModel *model3 = [[MyAccountDetailModel alloc] init];
    model3.titleStr = @"提现";
    model3.dateStr = @"2016-05-28";
    model3.handleType = 1;
    model3.numStr = @"1000";
    
    MyAccountDetailModel *model4 = [[MyAccountDetailModel alloc] init];
    model4.titleStr = @"2014443043053";
    model4.dateStr = @"2016-05-15";
    model4.handleType = 0;
    model4.numStr = @"200";
    
    [self.items addObject:model1];
    [self.items addObject:model2];
    [self.items addObject:model3];
    [self.items addObject:model4];
    
    [self.tableView reloadData];
    
    [self endRefreshing];

}

-(void)loadMoreData
{
    
    MyAccountDetailModel *model1 = [[MyAccountDetailModel alloc] init];
    model1.titleStr = @"2014443043053";
    model1.dateStr = @"2016-05-25";
    model1.handleType = 0;
    model1.numStr = @"140";
    
    MyAccountDetailModel *model2 = [[MyAccountDetailModel alloc] init];
    model2.titleStr = @"2014443043053";
    model2.dateStr = @"2016-05-25";
    model2.handleType = 0;
    model2.numStr = @"30";
    
    MyAccountDetailModel *model3 = [[MyAccountDetailModel alloc] init];
    model3.titleStr = @"提现";
    model3.dateStr = @"2016-05-28";
    model3.handleType = 1;
    model3.numStr = @"1000";
    
    MyAccountDetailModel *model4 = [[MyAccountDetailModel alloc] init];
    model4.titleStr = @"2014443043053";
    model4.dateStr = @"2016-05-15";
    model4.handleType = 0;
    model4.numStr = @"200";
    
    [self.items addObject:model1];
    [self.items addObject:model2];
    [self.items addObject:model3];
    [self.items addObject:model4];
    
    [self.tableView reloadData];
    
    [self endLoadMoreWithNoMoreData:NO];
    
    [self.proxy getAccountDetailDataWithParams:nil Block:^(id returnData, BOOL success) {
        if (success) {
            
        }
    }];
}

#pragma -mark ----Table Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifi = @"identif";
    MyAccountDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifi];
    if (!cell) {
        cell = [[MyAccountDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.items.count > indexPath.row) {
        MyAccountDetailModel *model = [self.items objectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}



#pragma -mark --Getter--
-(AccountProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[AccountProxy alloc] init];
    }
    return _proxy;
}


@end
