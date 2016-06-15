//
//  RefreshTableView.h
//  barrister
//
//  Created by 徐书传 on 16/4/12.
//  Copyright © 2016年 Xu. All rights reserved.
//


/**
 *  带上下拉刷新控件的tableview 主要适用于一个也页面有俩个tableview 的界面
 *
 *  @return
 */

#import "BaseTableView.h"

@class RefreshTableView;

@protocol RefreshTableViewDelegate <NSObject>

-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView;

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView;

@end

@interface RefreshTableView : BaseTableView

@property (nonatomic,weak) id <RefreshTableViewDelegate> refreshDelegate;
/**
 *  tableview 刷新的pageNum
 */
@property (nonatomic,assign) NSInteger pageNum;

/**
 *  tableview 刷新的pageSize
 */

@property (nonatomic,assign) NSInteger pageSize;

/**
 *  可以自主选择设置refreshControl 默认设置
 */
-(void)setHeaderRefreshControl;

/**
 *  可以自主选择是否设置上拉加载更多 默认不设置
 */
-(void)setFootLoadMoreControl;

/**
 *  停止下拉刷新
 */
-(void)endRefreshing;

/**
 *
 *  停止上拉加载更多
 *  @param isNoMoreData 是否显示没有更多数据
 */
-(void)endLoadMoreWithNoMoreData:(BOOL)isNoMoreData;

@end
