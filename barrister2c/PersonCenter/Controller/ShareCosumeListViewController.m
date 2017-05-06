//
//  ShareCosumeListViewController.m
//  barrister2c
//
//  Created by 徐书传 on 17/5/6.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "ShareCosumeListViewController.h"
#import "MeNetProxy.h"
#import "RefreshTableView.h"
#import "ShareCosumeModel.h"
#import "ShareCosumeListCell.h"

#define topTipViewHeight 20

@interface ShareCosumeListViewController ()<UITableViewDataSource,UITableViewDelegate,RefreshTableViewDelegate>

@property (nonatomic,strong) MeNetProxy *proxy;

@property (nonatomic,strong) RefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray *items;

@property (strong, nonatomic) NSString *totalMoney;

@property (strong, nonatomic) UIView * topTipView;

@property (strong, nonatomic) UILabel *topTipLabel;

@end

//{"items":[{"consumeTime":"2016-12-01 10:08:03","consumerId":202,"consumerName":null,"consumerPhone":"17301249544","money":25.0,"registerTime":"2016-11-08 15:43:47"}],"page":1,"pageSize":20,"resultCode":200,"resultMsg":"成功","total":1,"totalMoney":25.0,"userId":3,"verifyCode":"273698"}


@implementation ShareCosumeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configView];

    
}

-(void)configView
{
    self.title = @"分享消费记录";
    
    [self.view addSubview:self.topTipView];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, topTipViewHeight, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - topTipViewHeight) style:UITableViewStylePlain];
    [self.tableView setFootLoadMoreControl];
    self.tableView.pageSize = 10;
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
    self.tableView.refreshDelegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}

-(void)configData
{
    
    __weak typeof(*& self) weakSelf  = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageNum] forKey:@"page"];
    
    [XuUItlity showLoadingInView:self.view hintText:@"加载中..."];
    [self.proxy getShareCosumeListDataWithParmas:params block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        if (success) {
            [weakSelf hideNoContentView];
            NSDictionary *dict = (NSDictionary *)returnData;
            
            NSString *totalStr = [dict objectForKey:@"totalMoney"];
            self.topTipLabel.text = totalStr;
            
            NSArray *array = [dict objectForKey:@"items"];
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
            if (weakSelf.items.count == 0) {
                [weakSelf showNoContentView];
            }
            else
            {
                [XuUItlity showFailedHint:@"加载失败" completionBlock:nil];
                [weakSelf.tableView endLoadMoreWithNoMoreData:NO];
            }
            
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
        NSDictionary *dict = [array safeObjectAtIndex:i];
        ShareCosumeModel *model = [[ShareCosumeModel alloc] initWithDictionary:dict];
        [self.items addObject:model];
    }
    [self.tableView reloadData];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
 
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
    ShareCosumeListCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[ShareCosumeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    
    ShareCosumeModel *modelTemp = [self.items safeObjectAtIndex:indexPath.row];
    cell.model = modelTemp;
    
    
    return cell;
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


-(UIView *)topTipView
{
    if (!_topTipView) {
        _topTipView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, topTipViewHeight)];
        _topTipView.backgroundColor = KColorGray999;
        
        _topTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, topTipViewHeight)];
        _topTipLabel.textColor = kNavigationBarColor;
        _topTipLabel.font = SystemFont(14.0f);
        
        [_topTipView addSubview:_topTipLabel];
        
        
    }
    return _topTipView;

}

@end
