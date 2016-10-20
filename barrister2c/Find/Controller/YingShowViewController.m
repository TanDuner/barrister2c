//
//  YingShowViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowViewController.h"
#import "YingShowPublishViewController.h"
#import "RefreshTableView.h"
#import "YingShowInfoModel.h"
#import "YingShowProxy.h"
#import "YingShowListCell.h"
#import "YingShowDetailViewController.h"
#import "YingShowUserModel.h"
#import "BorderTextFieldView.h"
#import "YingShowHorSelectModel.h"
#import "YingShowHorSelectScrollView.h"
#import "BarristerLoginManager.h"

#define SearchViewHeight 44
#define FifltViewHeight 100


@interface YingShowViewController ()<UITableViewDelegate,UITableViewDataSource,RefreshTableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate,YingShowHorScrollViewDelegate>

@property (nonatomic,strong) RefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray*items;

@property (nonatomic,strong) BorderTextFieldView *searchTextField;

@property (nonatomic,strong) UIButton *searchButton;

@property (nonatomic,strong) YingShowProxy *proxy;

@property (nonatomic,strong) NSString *searchKey;


@property (nonatomic,strong) UIView *fiflterView;


@property (nonatomic,strong) NSString *searchTypeSelectStr;
@property (nonatomic,strong) NSString *zhaiquanSelectStr;

@end

@implementation YingShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    
    [self initData];
}


-(void)initView
{
    [self initNavigationRightTextButton:@"发布" action:@selector(toPublishYinShowVC)];
    
    [self initSearchView];
    
    [self initTableView];
    
}


-(void)initSearchView
{
    [self.view addSubview:self.searchTextField];
    
    [self.view addSubview:self.searchButton];
    
    [self.view addSubview:self.fiflterView];
    

}

-(void)initTableView
{
    [self.view addSubview:self.tableView];
}


-(void)initData
{
    

 
    
//    __weak typeof(*& self) weakSelf = self;
//    [self handleTableRefreshOrLoadMoreWithTableView:self.tableView array:self.items aBlock:^{
//        [weakSelf.items removeAllObjects];
//
//    }];
//    
//    [self.tableView endRefreshing];
//    
//    YingShowInfoModel *model = [[YingShowInfoModel alloc] init];
//    model.type = @"合同欠款";
//    model.updateTime = @"2016-10-12";
//    model.addTime = @"2016-03-04";
//    model.status = @"已通过";
//    model.money = 100000;
//    
//     [self.items addObject:model];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showTabbar:YES];
    
}


#pragma -mark ---TableView Delegate Methods ----

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YingShowDetailViewController *detailVC = [[YingShowDetailViewController alloc] init];
    detailVC.title = @"详情";
    [self.navigationController pushViewController:detailVC animated:YES];
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
    cell.backgroundColor = [UIColor greenColor];
    
    if (self.items.count > indexPath.row) {
        YingShowInfoModel *model = (YingShowInfoModel *)[self.items safeObjectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}


#pragma -mark --Refresh Delegate methods-----

-(void)circleTableViewDidTriggerRefresh:(RefreshTableView *)tableView
{
    self.tableView.pageNum = 1;
    [self initData];
}

-(void)circleTableViewDidLoadMoreData:(RefreshTableView *)tableView
{
    self.tableView.pageNum += 1;
    [self initData];
}



#pragma -mark ----Action----

-(void)toPublishYinShowVC
{
    YingShowPublishViewController *publishVC = [[YingShowPublishViewController alloc] init];
    publishVC.title = @"发布";
    [self.navigationController pushViewController:publishVC animated:YES];
    
}


#pragma -mark ----Action----

-(void)searchAction
{
    
    if (![[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
        [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
        return;
    }
    
    [self.searchTextField resignFirstResponder];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (IS_EMPTY(self.searchTextField.text)) {
        [XuUItlity showFailedHint:@"请输入搜索关键词" completionBlock:nil];
        return;
    }
   
    if (IS_EMPTY(self.searchTypeSelectStr)) {
        return;
    }
    
    if (IS_EMPTY(self.zhaiquanSelectStr)) {
        return;
    }
    
    [params setObject:self.searchTextField.text forKey:@"key"];
    [params setObject:self.searchTypeSelectStr forKey:@"keyType"];
    [params setObject:self.zhaiquanSelectStr forKey:@"userType"];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:@"10000" forKey:@"pageSize"];
    
    __weak typeof(*&self) weakSelf = self;
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
            [XuUItlity showFailedHint:@"搜索失败" completionBlock:nil];
            
        }
    }];
    
}

-(void)handleListDataWithArray:(NSArray *)array
{
 
    [self handleTableRefreshOrLoadMoreWithTableView:self.tableView array:array aBlock:^{
        [self.items removeAllObjects];
    }];
    
    for ( int i = 0; i < array.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
        
        YingShowInfoModel *model = [[YingShowInfoModel alloc] initWithDictionary:dict];
        
        [self.items addObject:model];
    }
    
    [self.tableView reloadData];
}


#pragma -mark  --Getter------


-(RefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, SearchViewHeight + FifltViewHeight, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - SearchViewHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refreshDelegate = self;
        _tableView.rowHeight = 87;
        
    }
    return _tableView;
}


-(UIView *)fiflterView
{
    if (!_fiflterView) {
        _fiflterView = [[UIView alloc] initWithFrame:RECT(0, CGRectGetMaxY(self.searchTextField.frame), SCREENWIDTH, FifltViewHeight)];
        
        UILabel *tiaojianLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10, 200, 15)];
        tiaojianLabel.font = SystemFont(15.0f);
        tiaojianLabel.textColor = KColorGray333;
        tiaojianLabel.textAlignment = NSTextAlignmentLeft;
        tiaojianLabel.text = @"查询条件";
        [_fiflterView addSubview:tiaojianLabel];
        
        
        NSArray *titleArray = @[@"公司名称",@"机构代码",@"身份证"];
        NSMutableArray *itemArray = [NSMutableArray array];
        for ( int i = 0; i < titleArray.count; i ++) {
            YingShowHorSelectModel *model = [[YingShowHorSelectModel alloc] init];
            model.titleStr = titleArray[i];
            if (i == 0) {
                model.isSelected = YES;
                self.searchTypeSelectStr = @"company";
            }
            
            [itemArray addObject:model];
        }
        
        YingShowHorSelectScrollView *searchTypeScrollView = [[YingShowHorSelectScrollView alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(tiaojianLabel.frame) + 10, SCREENWIDTH, 15) items:itemArray];
        searchTypeScrollView.tag = 1001;
        searchTypeScrollView.horScrollDelegate = self;
        [_fiflterView addSubview:searchTypeScrollView];
        
        
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(searchTypeScrollView.frame) + 10, 200, 15)];
        typeLabel.font = SystemFont(15.0f);
        typeLabel.textColor = KColorGray333;
        typeLabel.textAlignment = NSTextAlignmentLeft;
        typeLabel.text = @"债权/债务人类型";
        [_fiflterView addSubview:typeLabel];
        
        
        NSArray *typeTitleArray = @[@"债权人",@"债务人"];
        NSMutableArray *typeItemArray = [NSMutableArray array];
        for ( int i = 0; i < typeTitleArray.count; i ++) {
            YingShowHorSelectModel *model = [[YingShowHorSelectModel alloc] init];
            model.titleStr = typeTitleArray[i];
            if (i == 0) {
                model.isSelected = YES;
                self.zhaiquanSelectStr = @"credit";
            }
            [typeItemArray addObject:model];
        }
        
        YingShowHorSelectScrollView *zhaiTypeScrollView = [[YingShowHorSelectScrollView alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(typeLabel.frame) + 10, SCREENWIDTH, 15) items:typeItemArray];
        zhaiTypeScrollView.tag = 1002;
        zhaiTypeScrollView.horScrollDelegate = self;
        [_fiflterView addSubview:zhaiTypeScrollView];
        
    }
    return _fiflterView;
}

-(BorderTextFieldView *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH - 60, 40)];
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
        _searchButton.frame = RECT(SCREENWIDTH - 60, 0, 60, 40);
        [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchButton.titleLabel.font = SystemFont(14.0f);
        [_searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        _searchButton.enabled = NO;
    }
    return _searchButton;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchAction];
    return YES;
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.text.length > 0) {
        self.searchButton.enabled = YES;
    }
    else{
        self.searchButton.enabled = NO;
    }
    return YES;
}

-(NSMutableArray *)items
{
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

-(void)didSelectItemWithSelectObject:(NSString *)selectObject ScrollView:(YingShowHorSelectScrollView *)horScrollView
{
    //查询条件的
    if (horScrollView.tag == 1001) {
        if ([horScrollView.selectObject isEqualToString:@"公司名称"]) {
            self.searchTypeSelectStr = @"company";
        }
        else if ([horScrollView.selectObject isEqualToString:@"机构代码"])
        {
            self.searchTypeSelectStr = @"licenseNum";
        }
        else if ([horScrollView.selectObject isEqualToString:@"身份证"])
        {
            self.searchTypeSelectStr = @"idNum";
        }
        
    }
    else{//债权债务的
        if ([horScrollView.selectObject isEqualToString:@"债权人"]) {
            self.zhaiquanSelectStr = @"credit";
        }
        else if ([horScrollView.selectObject isEqualToString:@"债务人"])
        {
            self.zhaiquanSelectStr = @"debt";
        }
    }
}


@end
