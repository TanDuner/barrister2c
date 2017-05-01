//
//  ZhaiLiFangViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/27.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "ZhaiLiFangViewController.h"
#import "RefreshTableView.h"
#import "YingShowProxy.h"
#import "YingShowViewController.h"
#import "YingShowListCell.h"
#import "YingShowDetailViewController.h"
#import "YingShowPublishViewController.h"
#import "BarristerLoginManager.h"
#import "AppDelegate.h"

#define SearchViewHeight 0


@interface ZhaiLiFangViewController ()<UITableViewDelegate,UITableViewDataSource,RefreshTableViewDelegate>
@property (nonatomic,strong) RefreshTableView *tableView;
@property (nonatomic,strong) YingShowProxy *proxy;
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation ZhaiLiFangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上榜债务人";
    [self configView];
//    [self initNavigationRightTextButton:@"发布" action:@selector(toPublishYinShowVC)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOtherVC) name:NOTIFICATION_BACK_LOGINVC object:nil];

}

-(void)changeOtherVC
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.tabBarCTL changeSelectIndex:0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
    [self showTabbar:NO];
}

//-(void)toPublishYinShowVC
//{
//    YingShowPublishViewController *publishVC = [[YingShowPublishViewController alloc] init];
//    publishVC.title = @"发布";
//    [self.navigationController pushViewController:publishVC animated:YES];
//    
//}


-(void)configView
{
//    [self initSearchEnteryView];
    
    [self.view addSubview:self.tableView];

}

//-(void)initSearchEnteryView
//{
//    UIView *searchEnteryView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SearchViewHeight)];
//    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, 10, 30, 30)];
//    leftImageView.image = [UIImage imageNamed:@"zhaixitong.png"];
//    [searchEnteryView addSubview:leftImageView];
//    
//    UIButton *searchEnterButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchEnterButton setFrame:RECT(50, 0, 250, searchEnteryView.height)];
//    [searchEnterButton setTitle:@"债权债务信息查询系统" forState:UIControlStateNormal];
//    [searchEnterButton setTitleColor:KColorGray666 forState:UIControlStateNormal];
//    [searchEnterButton addTarget:self action:@selector(toSearchViewController) forControlEvents:UIControlEventTouchUpInside];
//    [searchEnterButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -80, 0, 0)];
//    [searchEnteryView addSubview:searchEnterButton];
//    searchEnterButton.titleLabel.font = SystemFont(15.0);
//    
//    searchEnteryView.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:searchEnteryView];
//    
//    
//}

-(void)toSearchViewController
{
    YingShowViewController *searchVC = [[YingShowViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}



#pragma -mark ---TableView Delegate Methods ----

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.items.count > indexPath.row) {
        YingShowInfoModel *model = [self.items objectAtIndex:indexPath.row];
        YingShowDetailViewController *detailVC = [[YingShowDetailViewController alloc] init];
        detailVC.model = model;
        detailVC.title = @"详情";
        [self.navigationController pushViewController:detailVC animated:YES];

    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifi = @"identifi";
    YingShowListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifi];
    if (!cell) {
        cell = [[YingShowListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
    }
    
    
    if (self.items.count > indexPath.row) {
        YingShowInfoModel *model = (YingShowInfoModel *)[self.items safeObjectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}


#pragma -mark ----Data----

-(void)initData
{
    __weak typeof(*&self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(self.tableView.pageNum),@"page",@(self.tableView.pageSize),@"pageSize", nil];
    [self.proxy getYingShowSearchResultWithParams:params block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"list"];
            
            if ([XuUtlity isValidArray:array]) {
                [weakSelf handleListDataWithArray:array];
            }
            else{
                [weakSelf handleListDataWithArray:@[]];
            }
            
        }
        else{
            NSString *resultCode = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"resultCode"]];
            if (resultCode.integerValue == 901) {
                [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
                return;
            }

            [weakSelf showNoContentView];
        }
    }];
    
}

-(void)handleListDataWithArray:(NSArray *)array
{
    __weak typeof(*&self) weakSelf = self;

    [self handleTableRefreshOrLoadMoreWithTableView:self.tableView array:array aBlock:^{
        [self.items removeAllObjects];
        if (array.count == 0) {
            [weakSelf showNoContentView];
        }
        else{
            [weakSelf hideNoContentView];
        }
    }];
    
    
    for ( int i = 0; i < array.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
        
        YingShowInfoModel *model = [[YingShowInfoModel alloc] initWithDictionary:dict];
        
        [self.items addObject:model];
    }
    
    [self.tableView reloadData];
}



#pragma -mark --Refresh Delegate methods-----

-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView
{
    self.tableView.pageNum = 1;
    [self initData];
}

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView
{
    [self initData];
}



#pragma -mark --Getter----

-(RefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, SearchViewHeight, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - SearchViewHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.backgroundColor = kBaseViewBackgroundColor;
        _tableView.dataSource = self;
        _tableView.refreshDelegate = self;
        _tableView.rowHeight = 159;
        _tableView.pageSize = 20;
        [_tableView setFootLoadMoreControl];
        
        
        UIView *headView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, 30)];
        headView.backgroundColor = kBaseViewBackgroundColor;
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 7.5, SCREENWIDTH, 15)];
        label.font  = SystemFont(15.0f);
        label.textColor = KColorGray333;
        label.text = @"上榜债务人";
        label.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:label];
        
        _tableView.tableHeaderView = headView;
        
    }
    return _tableView;
}



-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}


-(YingShowProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[YingShowProxy alloc] init];
    }
    return _proxy;
}

-(void)showNoContentView
{
    [self.noContentView setFrame:self.tableView.frame];
}



@end
