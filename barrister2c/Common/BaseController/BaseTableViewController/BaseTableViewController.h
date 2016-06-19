//
//  BaseTableViewController.h
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,strong) BaseTableView *tableView;

-(void)addRefreshHeader;

-(void)addLoadMoreFooter;

-(void)loadItems;

-(void)loadMoreData;

-(void)endRefreshing;

-(void)endLoadMoreWithNoMoreData:(BOOL)noMoreData;

@end
