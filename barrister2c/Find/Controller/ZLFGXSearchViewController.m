//
//  ZLFGXSearchViewController.m
//  barrister2c
//
//  Created by 徐书传 on 17/5/6.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "ZLFGXSearchViewController.h"
#import "RefreshTableView.h"
#import "YingShowProxy.h"
#import "YingShowUserModel.h"
#import "ZLFGXSearchListCell.h"
#import "BarristerLoginManager.h"
#import "BorderTextFieldView.h"
#import "ZLFGXDetailViewController.h"

@interface ZLFGXSearchViewController ()<UITableViewDelegate,UITableViewDataSource,RefreshTableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) RefreshTableView *tableView;
@property (nonatomic,strong) YingShowProxy *proxy;
@property (nonatomic,strong) NSMutableArray *items;


@property (nonatomic,strong) BorderTextFieldView *searchTextField;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) UIView *searchBgScrollView;
@end

@implementation ZLFGXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"债权债务关系查询";
    [self configView];

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}



-(void)configView
{
    
    [self initSearchView];

    [self.view addSubview:self.tableView];
    
    self.tableView.hidden = YES;
    
    
}

-(void)initSearchView
{
    [self.view addSubview:self.searchTextField];
    
    [self.view addSubview:self.searchButton];
    
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
        
        YingShowUserModel *model = [[YingShowUserModel alloc] initWithDictionary:dict];
        
        [self.items addObject:model];
    }
    
    self.tableView.hidden = NO;
    [self.tableView reloadData];
}


#pragma mark - tableview Delegate 
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.tableView.hidden = YES;
    self.searchBgScrollView.hidden = NO;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchAction];
    return YES;
}


-(void)searchAction
{
    
    if (self.items) {
        [self.items removeAllObjects];
        self.tableView.pageNum = 1;
    }
    
    if (![[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
        [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
        return;
    }
    
    [self.searchTextField resignFirstResponder];
    
    [self normalSearch];

    
}

-(void)normalSearch
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (IS_EMPTY(self.searchTextField.text)) {
        [XuUItlity showFailedHint:@"请输入搜索内容" completionBlock:nil];
        return;
    }
    
    [params setObject:self.searchTextField.text forKey:@"keywords"];
    [params setObject:@(self.tableView.pageNum) forKey:@"page"];
    [params setObject:@"100" forKey:@"pageSize"];
    
    __weak typeof(*&self) weakSelf = self;
    [self.proxy getZLFSearchResultWithParams:params Block:^(id returnData, BOOL success) {
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
            
            [XuUItlity showFailedHint:@"搜索失败" completionBlock:nil];
            
        }
    }];
    
}






#pragma -mark --Refresh Delegate methods-----

-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView
{
    self.tableView.pageNum = 1;
    [self normalSearch];
}

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView
{
    self.tableView.pageNum += 1;
    [self normalSearch];
}




-(RefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 44, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.backgroundColor = kBaseViewBackgroundColor;
        _tableView.dataSource = self;
        _tableView.refreshDelegate = self;
        _tableView.rowHeight = 159;
        _tableView.pageSize = 20;
        [_tableView setFootLoadMoreControl];
    }
    return _tableView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifi = @"identifi";
    ZLFGXSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifi];
    if (!cell) {
        cell = [[ZLFGXSearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
    }
    
    
    if (self.items.count > indexPath.row) {
        YingShowUserModel *model = (YingShowUserModel *)[self.items safeObjectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YingShowUserModel *model = (YingShowUserModel *)[self.items safeObjectAtIndex:indexPath.row];
    if (model) {
        ZLFGXDetailViewController *zlfdetail = [[ZLFGXDetailViewController alloc] init];
        zlfdetail.userModel = model;
        [self.navigationController pushViewController:zlfdetail animated:YES];
    }
    
}

#pragma mark - getter and setter


-(BorderTextFieldView *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH - 60, 44)];
        _searchTextField.keyboardType = UIKeyboardTypeWebSearch;
        _searchTextField.textColor = kFormTextColor;
        _searchTextField.cleanBtnOffset_x = _searchTextField.width - 40;
        _searchTextField.delegate = self;
        _searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入搜索内容" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
    }
    return _searchTextField;
}


-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        _searchButton.backgroundColor = kNavigationBarColor;
        _searchButton.frame = RECT(SCREENWIDTH - 60, 0, 60, 44);
        [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchButton.titleLabel.font = SystemFont(14.0f);
        [_searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

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
        _items = [NSMutableArray array];
    }
    return _items;
}




@end
