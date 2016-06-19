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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.refreshDelegate = self;
    
    [self.view addSubview:self.tableView];
}

-(void)configData
{
    
    MyMessageModel *model1 = [[MyMessageModel alloc] init];
    model1.titleStr = @"充值成功";
    model1.subTitleStr = @"于06 月 14 日充值成功 金额40元";
    model1.timeStr =  @"2016-06-14";
    

    MyMessageModel *model2 = [[MyMessageModel alloc] init];
    model2.titleStr = @"收到评价";
    model2.subTitleStr = @"订单2016060403998收到用户评价 快去看看吧";
    model2.timeStr =  @"2016-06-12";

    
    MyMessageModel *model3 = [[MyMessageModel alloc] init];
    model3.titleStr = @"认证通过";
    model3.subTitleStr = @"恭喜20160601提交的认证申请通过认证！";
    model3.timeStr =  @"2016-06-01";

    [self.items addObject:model1];
    [self.items addObject:model2];
    [self.items addObject:model3];
    
    [self.tableView reloadData];
    
    
    [self.tableView endRefreshing];

//    __weak typeof(*&self) weakSelf = self;
//    [self.proxy getMyMessageWithParams:nil block:^(id returnData, BOOL success) {
//        if (success) {
//            NSArray *array = (NSArray *)returnData;
//            if (array.count > 0) {
//                [weakSelf praiseDataWithArray:array];
//            }
//            else
//            {
//                [weakSelf showNoContentView];
//            }
//
//        }
//        else
//        {
//            [XuUItlity showFailedHint:@"加载失败" completionBlock:^{
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        }
//    }];
}

-(void)praiseDataWithArray:(NSArray *)array
{
    for (int i = 0; i < array.count; i ++ ) {
        NSDictionary *dict = [array objectAtIndex:i];
        MyMessageModel *model = [[MyMessageModel alloc] initWithDictionary:dict];
        [self.items addObject:model];
    }
    [self.tableView reloadData];
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
