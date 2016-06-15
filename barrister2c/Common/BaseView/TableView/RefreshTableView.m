//
//  RefreshTableView.m
//  barrister
//
//  Created by 徐书传 on 16/4/12.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "RefreshTableView.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefresh.h"

@implementation RefreshTableView



-(void)initBaseProprety
{
    self.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.pageNum = 1;
    [self setHeaderRefreshControl];
}

-(void)setHeaderRefreshControl
{
    MJRefreshNormalHeader *headerTemp = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadItems)];
    self.mj_header = headerTemp;
}

-(void)setFootLoadMoreControl
{
    MJRefreshAutoNormalFooter *footerTemp = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.mj_footer = footerTemp;

}

-(void)endRefreshing
{
    [self.mj_header endRefreshing];
}

-(void)endLoadMoreWithNoMoreData:(BOOL)isNoMoreData
{
    if (isNoMoreData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        [self.mj_footer endRefreshing];
    }
    
}

-(void)loadItems
{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(circleTableViewDidTriggerRefresh:)]) {
        self.pageNum = 1;
        [self.refreshDelegate circleTableViewDidTriggerRefresh:self];
    }
}

-(void)loadMoreData
{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(circleTableViewDidLoadMoreData:)]) {
        self.pageNum += 1;
        [self.refreshDelegate circleTableViewDidLoadMoreData:self];
    }
}
@end
