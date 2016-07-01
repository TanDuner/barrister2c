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
    [super loadItems];
    
    [self requestData];
}

-(void)loadMoreData
{
    [super loadMoreData];
    [self requestData];
}


-(void)requestData
{
    __weak typeof(*&self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%ld",self.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.pageNum] forKey:@"page"];
    [self.proxy getAccountDetailDataWithParams:nil Block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"list"];
            if ([XuUtlity isValidArray:array]) {
                [weakSelf handleDetailDataWithArray:array];
            }
            else
            {
                [weakSelf handleDetailDataWithArray:@[]];
            }
            
        }
        else
        {
            [XuUItlity showFailedHint:@"加载明细失败" completionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}


-(void)handleDetailDataWithArray:(NSArray*)array
{
    if (self.pageNum == 1) {
        [self.items removeAllObjects];
        [self endRefreshing];
    }
    if (array.count == 0) {
        [self showNoContentView];
    }
    else
    {
        if (array.count < self.pageSize) {
            [self endLoadMoreWithNoMoreData:YES];
        }
        else
        {
            [self endLoadMoreWithNoMoreData:NO];
        }
    }
    
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = [array objectAtIndex:i];
        MyAccountDetailModel *model = [[MyAccountDetailModel alloc] initWithDictionary:dict];
        [self.items addObject:model];
    }
    
    [self.tableView reloadData];
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
