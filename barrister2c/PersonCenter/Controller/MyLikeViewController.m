//
//  MyLikeViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyLikeViewController.h"
#import "BarristerLawerModel.h"
#import "LawerListCell.h"
#import "MeNetProxy.h"

@interface MyLikeViewController ()

@property (nonatomic,strong) MeNetProxy *proxy;

@end

@implementation MyLikeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configView];
    
    
}

#pragma -mark ---ConfigData-----

-(void)configData
{
    __weak typeof(*&self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%ld",self.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.pageNum] forKey:@"page"];
    [params setObject:[BaseDataSingleton shareInstance].userModel.userId forKey:@"userId"];
    [params setObject:[BaseDataSingleton shareInstance].userModel.verifyCode forKey:@"verifyCode"];
    [self.proxy getMyLikeListWithParams:params block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"favoriteItemList"];
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
            [XuUItlity showFailedHint:@"加载失败" completionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];

}

-(void)handleDetailDataWithArray:(NSArray *)array
{
    if (self.pageNum == 1) {
        [self.items removeAllObjects];
        [self endRefreshing];
    }
    if (array.count == 0) {
        [self showNoContentView];
        [self endLoadMoreWithNoMoreData:YES];
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
        BarristerLawerModel *model = [[BarristerLawerModel alloc] initWithDictionary:dict];
        [self.items addObject:model];
    }
    
    [self.tableView reloadData];

}

#pragma -mark --UI--



-(void)configView
{
    self.title  = @"我的收藏";
    
    [self addRefreshHeader];
    [self addLoadMoreFooter];
}

#pragma -mark --ConfigData

-(void)loadItems
{
    [super loadItems];
    [self configData];
}


-(void)loadMoreData
{
    [super loadMoreData];
    [self configData];
}


#pragma -mark --UITableView Delegate 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"identif";
    LawerListCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[LawerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    if (self.items.count > indexPath.row) {
        BarristerLawerModel *model = [self.items objectAtIndex:indexPath.row];
        cell.model = model;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LawerListCell getCellHeight];
}


#pragma -mark --Getter--

-(MeNetProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[MeNetProxy alloc] init];
    }
    return _proxy;
}

@end
