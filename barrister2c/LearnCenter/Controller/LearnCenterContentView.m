//
//  LearnCenterContentView.m
//  barrister
//
//  Created by 徐书传 on 16/6/28.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LearnCenterContentView.h"
#import "LearnCenterProxy.h"
#import "RefreshTableView.h"
#import "LearnCenterModel.h"
#import "LearnCenterCell.h"

@interface LearnCenterContentView ()<UITableViewDataSource,UITableViewDelegate,RefreshTableViewDelegate>

@property (nonatomic,strong) LearnCenterProxy *proxy;

@property (nonatomic,strong) RefreshTableView *tableView;


@end

@implementation LearnCenterContentView

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self initView];
    [XuUItlity showLoadingInView:self.view hintText:@"正在加载"];
    [self loadItems];
}


#pragma -mark ----Data-----

-(void)loadItems
{
//    page,pageSize,channelId
    __weak typeof(*&self) weakSelf = self;
    NSMutableDictionary *aParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.chanelId,@"channelId",[NSString stringWithFormat:@"%ld",self.tableView.pageSize],@"pageSize",[NSString stringWithFormat:@"%ld",self.tableView.pageNum],@"page", nil];
    
    [self.proxy getLearnCenterListWithParams:aParams block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"items"];
            if ([XuUtlity isValidArray:array]) {
                [weakSelf handleLearnListDataWithArray:array];
            }
            else
            {
                [weakSelf handleLearnListDataWithArray:@[]];
            }
        }
        else
        {
        
        }
    }];
}

-(void)handleLearnListDataWithArray:(NSArray *)array
{
    if (array.count == 0) {
        [self showNoContentView];
    }
    else
    {
        [self hideNoContentView];
    }
    
    if (self.tableView.pageNum == 1 ) {
        [self.tableView endRefreshing];
        [self.items removeAllObjects];
        
    }else{
        if (array.count < self.tableView.pageSize) {
            [self.tableView endLoadMoreWithNoMoreData:YES];
        }
        else
        {
            [self.tableView endLoadMoreWithNoMoreData:NO];
        }
    }
    
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = [array safeObjectAtIndex:i];
        LearnCenterModel *model = [[LearnCenterModel alloc] initWithDictionary:dict];
        [self.items addObject:model];
    }
    [self.tableView reloadData];
    
    
}


#pragma -mark ----Refresh Delegate methods----
-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView
{
    [self loadItems];
}

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView
{
    [self loadItems];
}



#pragma -mark ----UI-----

-(void)initView
{
    self.tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - 49 - 49- NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
    self.tableView.delegate = self;
    [self.tableView setFootLoadMoreControl];
    self.tableView.dataSource = self;
    self.tableView.refreshDelegate = self;
    
    [self.view addSubview:self.tableView];
}


#pragma -mark -----UITableVIewDelegate Methods------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"learnCenterCell";

    LearnCenterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        cell = [[LearnCenterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    LearnCenterModel *model =  (LearnCenterModel *)[self.items safeObjectAtIndex:indexPath.row];
    cell.model = model;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.items.count > indexPath.row) {
        LearnCenterModel *model = (LearnCenterModel *)[self.items safeObjectAtIndex:indexPath.row];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
    }

}

#pragma -mark --Getter--

-(LearnCenterProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[LearnCenterProxy alloc] init];
    }
    return _proxy;
}


-(NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray arrayWithCapacity:0];
    }
    return _items;
}

@end
