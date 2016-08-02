//
//  LawerSearchViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/2.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerSearchViewController.h"
#import "RefreshTableView.h"
#import "LawerListCell.h"
#import "LawerDetailViewController.h"
#import "LawerListProxy.h"

@interface LawerSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,RefreshTableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) LawerListProxy *proxy;

@property (nonatomic,strong) RefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) NSString *searchLawerName;
@end

@implementation LawerSearchViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configView];
    
}

-(void)configData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageNum] forKey:@"page"];
    
    if (self.searchLawerName) {
        [params setObject:self.searchLawerName forKey:@"lawyerName"];
    }

    [XuUItlity showLoadingInView:self.view hintText:@"正在加载..."];
    __weak typeof(*&self) weakSelf  = self;
    [self.proxy getLawerListWithParams:params block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"items"];
            if ([XuUtlity isValidArray:array]) {
                [weakSelf handleLawerDataWithArray:array];
            }
            else
            {
                [weakSelf handleLawerDataWithArray:@[]];
            }
        }
        else{
            
        }
    }];
    
    [self.searchBar resignFirstResponder];
    
    
    [self.tableView reloadData];
    
}

-(void)handleLawerDataWithArray:(NSArray *)array
{
    self.tableView.hidden = NO;
    __weak typeof(*&self)weakSelf = self;
    
    [self handleTableRefreshOrLoadMoreWithTableView:self.tableView array:array aBlock:^{
        [weakSelf.items removeAllObjects];
    }];
    
    for ( int i = 0; i < array.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[array safeObjectAtIndex:i];
        BarristerLawerModel *model = [[BarristerLawerModel alloc] initWithDictionary:dict];
        
        [self.items addObject:model];
    }
    [self.tableView reloadData];
}


#pragma -mark -----Refreh Delegate Methods-----

-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView
{
    [self configData];
}

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView
{
    [self configData];
}




#pragma - mark ---ConfigView

-(void)configView
{
    self.title = @"搜索律师";
    

    self.searchBar = [[UISearchBar alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, 44)];
    self.searchBar.placeholder = @"输入律师姓名";
    self.searchBar.delegate = self;
    [self.searchBar becomeFirstResponder];
    
    [self.noContentView setFrame:RECT(0, self.searchBar.height, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - self.searchBar.height)];
    
    
    [self.view addSubview:self.searchBar];
    
    [self.view addSubview:self.tableView];

    self.tableView.hidden = YES;
    
    [self.tableView setFrame:RECT(0, self.searchBar.y + self.searchBar.height, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - self.searchBar.height)];
    
    
}

#pragma -mark  --UitableVIew delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"identif";
    LawerListCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[LawerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    if (self.items.count > indexPath.row) {
        BarristerLawerModel *model = [self.items  safeObjectAtIndex:indexPath.row];
        cell.model = model;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LawerListCell getCellHeight];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LawerDetailViewController *detailVC = [[LawerDetailViewController alloc] init];
    if (self.items.count > indexPath.row) {
        BarristerLawerModel *model = [self.items  safeObjectAtIndex:indexPath.row];
        detailVC.lawyerId = model.laywerId;
    }
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma -mark ----SearchDelegate Methods---

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.items removeAllObjects];
    self.tableView.pageNum = 1;
    self.searchLawerName = searchBar.text;
    [self configData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.items removeAllObjects];
    self.tableView.pageNum = 1;
    self.searchLawerName = searchBar.text;
    [self configData];
}

#pragma -mark ---Getter----

-(LawerListProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[LawerListProxy alloc] init];
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

-(RefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setFootLoadMoreControl];
        _tableView.refreshDelegate = self;
    }
    return _tableView;
}




@end
