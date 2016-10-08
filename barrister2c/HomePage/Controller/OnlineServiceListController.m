//
//  OnlineServiceListController.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OnlineServiceListController.h"
#import "HomePageProxy.h"
#import "RefreshTableView.h"
#import "OnlineServiceListModel.h"
#import "OnlineServiceCell.h"
#import "BarristerLoginManager.h"
#import "BaseWebViewController.h"

@interface OnlineServiceListController ()<RefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) HomePageProxy *proxy;

@property (nonatomic,strong) RefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation OnlineServiceListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginVC) name:@"NeedLoginNotificaiton" object:nil];
    
}

-(void)showLoginVC
{
    [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
    [self configData];
    
}

-(void)configData
{
    
    __weak typeof(*& self) weakSelf  = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%d",50] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageNum] forKey:@"page"];
    
    if (self.typeId) {
        [params setObject:self.typeId forKey:@"bizTypeId"];
    }

    
    [XuUItlity showLoadingInView:self.view hintText:@"加载中..."];
    [self.proxy getOnlineServiceListWithParams:params Block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        if (success) {
            [weakSelf hideNoContentView];
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"list"];
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
                [weakSelf.tableView endLoadMoreWithNoMoreData:YES];
                [weakSelf showNoContentView];
            }
            else
            {
                [XuUItlity showFailedHint:@"加载失败" completionBlock:nil];
                [weakSelf.tableView endLoadMoreWithNoMoreData:NO];
            }
            
        }

    }];
    

    
//    NSDictionary *dict = @{@"icon":@"",@"name":@"赵大大",@"intro":@"非常专业",@"phone":@"1333333333",@"qq":@"30410425"};
//
//        NSDictionary *dict1 = @{@"icon":@"",@"name":@"赵大2",@"intro":@"非常专业",@"phone":@"1333333333",@"qq":@"304110425"};
//    
//    OnlineServiceListModel *model = [[OnlineServiceListModel alloc] initWithDictionary:dict];
//
//        OnlineServiceListModel *model1 = [[OnlineServiceListModel alloc] initWithDictionary:dict1];
//    
//    [self.items addObject:model];
//    [self.items addObject:model1];
    
    [self.tableView reloadData];
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
        OnlineServiceListModel *model = [[OnlineServiceListModel alloc] initWithDictionary:dict];
        [self.items addObject:model];
    }
    [self.tableView reloadData];
    
    
}


-(void)configView
{
    self.title = @"线上专项服务";
    [self initNavigationRightTextButton:@"说明" action:@selector(toTipViewController)];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
    [self.tableView setFootLoadMoreControl];
    self.tableView.pageSize = 10;
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
    self.tableView.refreshDelegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

#pragma -mark --
-(void)toTipViewController
{
    BaseWebViewController *tipVC = [[BaseWebViewController alloc] init];
    tipVC.showTitle = @"专家咨询说明";
    tipVC.url = @"http://www.dls.com.cn/art/waplist.asp?id=682";
    [self.navigationController pushViewController:tipVC animated:YES];
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
    
    OnlineServiceListModel *modelTemp = [self.items safeObjectAtIndex:indexPath.row];
    if (modelTemp) {
        if ([OnlineServiceCell getCellHeightWithModel:modelTemp] < 80) {
            return 80;
        }
        return [OnlineServiceCell getCellHeightWithModel:modelTemp];
    }
    else
    {
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"orderList";
    OnlineServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[OnlineServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    OnlineServiceListModel *modelTemp = [self.items safeObjectAtIndex:indexPath.row];
    cell.model = modelTemp;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (self.items.count > indexPath.row) {
//        OnlineServiceListModel *model = [self.items safeObjectAtIndex:indexPath.row];
//        
//        
//    }
//    
    
}
#pragma -mark ---

-(HomePageProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[HomePageProxy alloc] init];
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
