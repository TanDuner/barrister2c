//
//  BaseTableViewController.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"

@interface BaseTableViewController ()


@end

@implementation BaseTableViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.items = [NSMutableArray arrayWithCapacity:1];
        self.pageSize = 20;
        self.pageNum = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    
    [self loadItems];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma -mark --------UI------------

-(void)configTableView
{
    self.tableView = [[BaseTableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)addRefreshHeader
{
    MJRefreshNormalHeader *headerTemp = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadItems)];
    self.tableView.mj_header = headerTemp;
    
}

-(void)addLoadMoreFooter
{
    MJRefreshAutoNormalFooter *footerTemp = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footerTemp;
}


-(void)endRefreshing
{
    [self.tableView.mj_header endRefreshing];
}

-(void)endLoadMoreWithNoMoreData:(BOOL)noMoreData
{
    if (noMoreData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }

}

#pragma -mark -----UITableView Delegate Methods-----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma 
#pragma -mark -----Custom Methods-----

- (void)scrollToFirstRow {
    if (self.tableView.contentOffset.y<0) {
        return;
    }
    
    
    if (self.items && self.items.count > 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

#pragma -mark -------RefreshMethods--------

-(void)loadMoreData
{
    self.pageNum += 1;
}


-(void)loadItems
{
    self.pageNum = 1;
}
@end
