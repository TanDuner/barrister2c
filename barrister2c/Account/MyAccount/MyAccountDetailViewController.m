//
//  MyAccountDetailViewController.m
//  barrister
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyAccountDetailViewController.h"
#import "MyAccountDetailModel.h"
#import "AccountProxy.h"
#import "MyAccountDetailCell.h"
#import "RefreshTableView.h"

@interface MyAccountDetailViewController ()<UITableViewDataSource,UITableViewDelegate,RefreshTableViewDelegate>


@property (nonatomic,strong) AccountProxy *proxy;

@property (nonatomic,strong) RefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray *items;
@end

@implementation MyAccountDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self confgiView];
    
    [self requestData];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}


#pragma -mark --UI --

-(void)confgiView
{
    self.title  = @"交易明细";
    self.tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - TABBAR_HEIGHT) style:UITableViewStylePlain];
    [self.tableView setFootLoadMoreControl];
    self.tableView.pageSize = 10;
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
    self.tableView.refreshDelegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}



#pragma -mark --ConfigData

-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView
{
    [self requestData];
}

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView
{
    [self requestData];
}

-(void)requestData
{
    __weak typeof(*&self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageNum] forKey:@"page"];
    [self.proxy getAccountDetailDataWithParams:nil Block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"list"];
            if ([XuUtlity isValidArray:array]) {
                [weakSelf handleDetailDataWithArray:array];
            }
            else
            {
                [weakSelf handleDetailDataWithArray:@[]];
            }
            
        }
        else
        {
            [XuUItlity showFailedHint:@"加载明细失败" completionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}


-(void)handleDetailDataWithArray:(NSArray*)array
{
    __weak typeof(*&self) weakSelf = self;
    
    [self handleTableRefreshOrLoadMoreWithTableView:self.tableView array:array aBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.items removeAllObjects];
    }];
    
    
    [self.tableView reloadData];
    
    
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = [array objectAtIndex:i];
        MyAccountDetailModel *model = [[MyAccountDetailModel alloc] initWithDictionary:dict];
        [self.items addObject:model];
    }
    
    [self.tableView reloadData];
}


#pragma -mark ----Table Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifi = @"identif";
    MyAccountDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifi];
    if (!cell) {
        cell = [[MyAccountDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.items.count > indexPath.row) {
        MyAccountDetailModel *model = [self.items objectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}



#pragma -mark --Getter--
-(AccountProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[AccountProxy alloc] init];
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
