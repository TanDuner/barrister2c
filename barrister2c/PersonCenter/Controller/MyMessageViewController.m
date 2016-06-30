//
//  MyMessageViewController.m
//  barrister
//
//  Created by 徐书传 on 16/6/14.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyMessageViewController.h"
#import "RefreshTableView.h"
#import "MeNetProxy.h"
#import "MyMessageModel.h"
#import "MyMessgeCell.h"


@interface MyMessageViewController () <UITableViewDataSource,UITableViewDelegate,RefreshTableViewDelegate>

@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) RefreshTableView *tableView;
@property (nonatomic,strong) MeNetProxy *proxy;
@end

@implementation MyMessageViewController

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

-(void)configView
{
    self.title = @"我的消息";
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.refreshDelegate = self;
    
    [self.view addSubview:self.tableView];
}

-(void)configData
{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[BaseDataSingleton shareInstance].userModel.userId forKey:@"userId"];
    [params setObject:[BaseDataSingleton shareInstance].userModel.verifyCode forKey:@"verifyCode"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageNum] forKey:@"page"];
    
    __weak typeof(*&self) weakSelf = self;
    [self.proxy getMyMessageWithParams:params block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *msg = (NSDictionary *)returnData;
            NSArray *array = [msg objectForKey:@"msg"];
            if ([XuUtlity isValidArray:array]) {
                [weakSelf praiseDataWithArray:array];
            }
            else
            {
                [weakSelf praiseDataWithArray:@[]];
            }
            

        }
        else
        {
            [XuUItlity showFailedHint:@"加载失败" completionBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}




-(void)praiseDataWithArray:(NSArray *)array
{
    if (self.tableView.pageNum == 1) {
        [self.tableView endRefreshing];
        [self.items removeAllObjects];
    }
    else{
        if (array.count < self.tableView.pageSize) {
            [self.tableView endLoadMoreWithNoMoreData:YES];
        }
        else
        {
            [self.tableView endLoadMoreWithNoMoreData:NO];
        }
    }
    if (array.count == 0) {
        [self showNoContentView];
    }
    else
    {
        [self hideNoContentView];
        for (int i = 0; i < array.count; i ++ ) {
            NSDictionary *dict = [array objectAtIndex:i];
            MyMessageModel *model = [[MyMessageModel alloc] initWithDictionary:dict];
            [self.items addObject:model];
        }
        [self.tableView reloadData];

    }
    
}

#pragma  -mark Delegate Methods---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenfiti  = @"messageIdentifi";
    MyMessgeCell *cell = [tableView dequeueReusableCellWithIdentifier:idenfiti];
    if (!cell) {
        cell = [[MyMessgeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfiti];
    }
    if (self.items.count > indexPath.row) {
        MyMessageModel *modelTemp = [self.items  objectAtIndex:indexPath.row];
        cell.model = modelTemp;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma -mark -----Refresh&LoadMore-----

-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView
{
    [self configData];
}

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView
{
    [self configData];
}

#pragma -mark --Getter--

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
