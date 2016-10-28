//
//  MyUploadYingShowViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyUploadYingShowViewController.h"
#import "RefreshTableView.h"
#import "YingShowProxy.h"
#import "YingShowInfoModel.h"
#import "YingShowListCell.h"


@interface MyUploadYingShowViewController ()<UITableViewDelegate,UITableViewDataSource,RefreshTableViewDelegate>

@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) RefreshTableView *tableView;
@property (nonatomic,strong) YingShowProxy *proxy;


@end

@implementation MyUploadYingShowViewController


- (void)viewDidLoad {
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
    
    self.title = @"我上传的的债权债务信息";
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.pageSize = 20;
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 159;
    self.tableView.refreshDelegate = self;
    
    [self.view addSubview:self.tableView];
    
}

-(void)configData
{
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageNum] forKey:@"page"];
    
    __weak typeof(*&self) weakSelf = self;
    
    [self.proxy getYingShowMyUploadListWithParams:params block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *msg = (NSDictionary *)returnData;
            NSArray *array = [msg objectForKey:@"list"];
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
            NSDictionary *dict = [array safeObjectAtIndex:i];
            YingShowInfoModel *model = [[YingShowInfoModel alloc] initWithDictionary:dict];
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



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenfiti  = @"messageIdentifi";
    YingShowListCell *cell = [tableView dequeueReusableCellWithIdentifier:idenfiti];
    if (!cell) {
        cell = [[YingShowListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfiti];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [cell addGestureRecognizer:longPress];
    }
    if (self.items.count > indexPath.row) {
        YingShowInfoModel *modelTemp = [self.items  safeObjectAtIndex:indexPath.row];
        cell.model = modelTemp;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    YingShowInfoModel *model = [self.items safeObjectAtIndex:indexPath.row];
    
    if (!model) {
        return;
    }
}


-(void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    
      if ([longPress state] == UIGestureRecognizerStateBegan)
      {
          [XuUItlity showYesOrNoAlertView:@"确认" noText:@"取消" title:@"提示" mesage:@"确认删除删除吗？" callback:^(NSInteger buttonIndex, NSString *inputString) {
              if (buttonIndex == 1) {
                  YingShowListCell *cell = (YingShowListCell *)longPress.view;
                  __block YingShowInfoModel *model = cell.model;
                  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.yingShowInfoId,@"id", nil];
                  
                  __weak typeof(*&self) weakSelf = self;
                  [self.proxy deleteMyUploadYingShowInfoWithParams:params block:^(id returnData, BOOL success) {
                      if (success) {
                          [XuUItlity showSucceedHint:@"删除成功" completionBlock:^{
                              [weakSelf removeDeleteDataWithModel:model];
                          }];
                          
                      }
                      else{
                          NSLog(@"取消删除")
                      }
                  }];
              }
              else{
                  
                  NSLog(@"取消删除")
              }
          }];

      }
    
    
}


-(void)removeDeleteDataWithModel:(YingShowInfoModel *)model
{
    if (self.items && self.items.count > 0 &&[self.items containsObject:model]) {
        [self.items removeObject:model];
        [self.tableView reloadData];
    }
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

-(YingShowProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[YingShowProxy alloc] init];
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
