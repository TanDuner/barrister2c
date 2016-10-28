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
#import "UIButton+EnlargeEdge.h"
#import "XWMoneyTextField.h"
#import "ZHPickView.h"

#define SearchViewHeight SCREENHEIGHT - NAVBAR_HIGHTIOS_7 - TABBAR_HEIGHT - 44
#define FifltViewHeight 100
#define GaojiSearchView 150




@interface YingShowViewController ()<UITableViewDelegate,UITableViewDataSource,RefreshTableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate,YingShowHorScrollViewDelegate,ZHPickViewDelegate,XWMoneyTextFieldLimitDelegate>

@property (nonatomic,strong) RefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray*items;

@property (nonatomic,strong) BorderTextFieldView *searchTextField;

@property (nonatomic,strong) UIButton *searchButton;

@property (nonatomic,strong) YingShowProxy *proxy;

@property (nonatomic,strong) NSString *searchKey;


@property (nonatomic,strong) UIView *fiflterView;


@property (nonatomic,strong) UIScrollView *searchBgScrollView;

@property (nonatomic,strong) UIView *gaojiSearchView;


@property (nonatomic,strong) NSString *searchTypeSelectStr;
@property (nonatomic,strong) NSString *zhaiquanSelectStr;
@property (nonatomic,strong) NSString *zhaiStatusSelectStr;


@property (nonatomic,assign) BOOL isShowAllSearchView;

@property (nonatomic,strong) YingShowHorSelectScrollView *statusScrollView;


@property (nonatomic,strong) UIButton *startTimeButton;
@property (nonatomic,strong) UIButton *endTimeButton;


@property (nonatomic,strong) XWMoneyTextField *maxMonenyTextField;
@property (nonatomic,strong) XWMoneyTextField *minMonenyTextField;

@property (nonatomic,strong) ZHPickView *pickview;



@property (nonatomic,strong) BorderTextFieldView *addressSearchTextField;


@property (nonatomic,strong) ZHPickView *datePickerView;


@end

@implementation YingShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isShowAllSearchView = NO;
    
    [self initView];
    
    
    [self initData];
}


-(void)initView
{
    self.title = @"债权债务信息查询";
    
    [self initNavigationRightTextButton:@"发布" action:@selector(toPublishYinShowVC)];

    [self initTableView];
    
    [self initSearchView];
    
    
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
        
    }}


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
    cell.backgroundColor = [UIColor colorWithString:@"#EEEEEE" colorAlpha:1];
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
    
    if (self.items) {
        [self.items removeAllObjects];
        self.tableView.pageNum = 1;
    }
    
    if (![[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
        [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
        return;
    }

    [self.searchTextField resignFirstResponder];
    
    if (!self.isShowAllSearchView) {
        [self normalSearch];
    }
    else{
        [self gaojiSearch];
    }
}


-(void)normalSearch
{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    if (IS_EMPTY(self.searchTextField.text)) {
        [XuUItlity showFailedHint:@"请输入搜索内容" completionBlock:nil];
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


-(void)gaojiSearch
{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    if (IS_EMPTY(self.searchTextField.text)) {
        [XuUItlity showFailedHint:@"请输入搜索内容" completionBlock:nil];
        return;
    }
    
    if (IS_EMPTY(self.searchTypeSelectStr)) {
        return;
    }
    
    if (IS_EMPTY(self.zhaiquanSelectStr)) {
        return;
    }
  
    if (IS_NOT_EMPTY(self.searchTextField.text)) {
        [params setObject:self.searchTextField.text forKey:@"key"];
    }
    
    
    [params setObject:self.searchTypeSelectStr forKey:@"keyType"];
    [params setObject:self.zhaiquanSelectStr forKey:@"userType"];
    if (IS_NOT_EMPTY(self.zhaiStatusSelectStr)) {
        [params setObject:self.zhaiStatusSelectStr forKey:@"creditDebtStatus"];
    }

    
    NSString *startDateStr = self.startTimeButton.titleLabel.text;
    NSString *endDateStr = self.endTimeButton.titleLabel.text;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [formatter dateFromString:startDateStr];
    NSDate *date2 = [formatter dateFromString:endDateStr];
    
  
    
    double timeSpace = [date2 timeIntervalSinceDate:date1];
    
    if (timeSpace < 0 ) {
        [XuUItlity showFailedHint:@"时间范围不合法" completionBlock:nil];
        return;
    }
    else{
        if (date2 && date1) {
            [params setObject:startDateStr forKey:@"startDate"];
            [params setObject:endDateStr forKey:@"endDate"];
            
        }
    }
    
    
    NSString *startMonenyStr = self.minMonenyTextField.text;
    
    NSString *endMonenyStr = self.maxMonenyTextField.text;
    
    if (IS_NOT_EMPTY(startMonenyStr) && IS_NOT_EMPTY(endDateStr)) {
        if (endMonenyStr.doubleValue >= startMonenyStr.doubleValue) {
            [params setObject:startMonenyStr forKey:@"startMoney"];
            [params setObject:endMonenyStr forKey:@"endMoney"];
        }
        else{
            [XuUItlity showFailedHint:@"金额不合法" completionBlock:nil];
            return;
        }

    }

    
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
            self.tableView.hidden = YES;
            self.searchBgScrollView.hidden = YES;
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
    
    
    
    
    self.searchBgScrollView.hidden = YES;
    self.tableView.hidden = NO;
    [self.view bringSubviewToFront:self.tableView];
    [self.tableView reloadData];
    
    if (array.count == 0) {
        [XuUItlity showFailedHint:@"无相关数据" completionBlock:nil];
    }
 
    
}



-(void)gaojiSearchAction
{
    self.isShowAllSearchView = !self.isShowAllSearchView;
    if (self.isShowAllSearchView) {
        self.gaojiSearchView.hidden = NO;
        self.searchBgScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.gaojiSearchView.frame) + 240 + 80);
        
    }
    else{

        self.gaojiSearchView.hidden = YES;
        self.searchBgScrollView.contentSize = CGSizeMake(0, 0);
        
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{

    self.tableView.hidden = YES;
    self.searchBgScrollView.hidden = NO;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchAction];
    return YES;
}




-(void)chooseTime:(UIButton *)button
{
    [self.view endEditing:YES];
    
    if (button == self.startTimeButton) {
        self.datePickerView.tag = 10001;
        [self.datePickerView show];
    }
    else if (button == self.endTimeButton)
    {
        self.datePickerView.tag = 10002;
        [self.datePickerView show];
    }
    
}




-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (resultString && resultString.length > 10) {
        resultString = [resultString substringToIndex:10];
        
        if (pickView.tag == 10001) {
            [self.startTimeButton setTitle:resultString forState:UIControlStateNormal];;
            
        }
        else if (pickView.tag == 10002)
        {
            [self.endTimeButton setTitle:resultString forState:UIControlStateNormal];;
        }
        
    }
    
}

- (void)valueChange:(id)sender
{



}

#pragma -mark  --Getter------


-(RefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[RefreshTableView alloc] initWithFrame:RECT(0, 44, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - TABBAR_HEIGHT - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.backgroundColor = kBaseViewBackgroundColor;
        _tableView.dataSource = self;
        _tableView.refreshDelegate = self;
        _tableView.rowHeight = 159;
        
    }
    return _tableView;
}


-(UIView *)fiflterView
{
    if (!_fiflterView) {
        _fiflterView = [[UIView alloc] initWithFrame:RECT(0, 44, SCREENWIDTH, self.view.height - 44)];
        
        
        self.searchBgScrollView = [[UIScrollView alloc] initWithFrame:RECT(0, 0, 0, 0)];
        self.searchBgScrollView.backgroundColor = kBaseViewBackgroundColor;
//        self.searchBgScrollView.backgroundColor = [UIColor whiteColor];
        
        
//        [self.searchBgScrollView addSubview:[self getLineViewWithFrame:RECT(0, CGRectGetMaxY(self.searchTextField.frame) + 1, SCREENWIDTH, 1)]];
        
        UILabel *tiaojianLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10, 200, 15)];
        tiaojianLabel.font = SystemFont(15.0f);
        tiaojianLabel.textColor = KColorGray333;
        tiaojianLabel.textAlignment = NSTextAlignmentLeft;
        tiaojianLabel.text = @"查询条件";
        [self.searchBgScrollView addSubview:tiaojianLabel];
        
        
        UIButton *gaojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [gaojiButton setTitle:@"高级搜索" forState:UIControlStateNormal];
        [gaojiButton setFrame:RECT(SCREENWIDTH - 60 - 10, tiaojianLabel.frame.origin.y - 5, 60, 25)];
        [gaojiButton setEnlargeEdgeWithTop:3 right:0 bottom:3 left:20];
        [gaojiButton setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
        [gaojiButton addTarget:self action:@selector(gaojiSearchAction) forControlEvents:UIControlEventTouchUpInside];
        gaojiButton.titleLabel.font = SystemFont(13.0f);
        [self.searchBgScrollView addSubview:gaojiButton];
        
        
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
        [self.searchBgScrollView addSubview:searchTypeScrollView];
        
        
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(searchTypeScrollView.frame) + 10, 200, 15)];
        typeLabel.font = SystemFont(15.0f);
        typeLabel.textColor = KColorGray333;
        typeLabel.textAlignment = NSTextAlignmentLeft;
        typeLabel.text = @"查询他的";
        [self.searchBgScrollView addSubview:typeLabel];
        
        
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
        [self.searchBgScrollView addSubview:zhaiTypeScrollView];
        
        [self.searchBgScrollView setFrame:_fiflterView.bounds];
        
        
        [self.searchBgScrollView addSubview:self.gaojiSearchView];
        
        [_gaojiSearchView setFrame:RECT(0, CGRectGetMaxY(zhaiTypeScrollView.frame) + 10, SCREENWIDTH - 20, CGRectGetMaxY(self.addressSearchTextField.frame) + 10)];

        
        
        [_fiflterView addSubview:self.searchBgScrollView];
        
    
        
        
        
    }
    return _fiflterView;
}


-(UIView *)gaojiSearchView
{
    if (!_gaojiSearchView) {
        _gaojiSearchView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 0, 200, 15)];
        statusLabel.textColor = KColorGray333;
        statusLabel.text = @"债状态";
        statusLabel.textAlignment = NSTextAlignmentLeft;
        statusLabel.font = SystemFont(15.0f);
        [_gaojiSearchView addSubview:statusLabel];
        
        NSArray *statusTitlteArray = @[@"不限制",@"未起诉",@"诉讼中",@"执行中",@"已过失效"];
        
        NSMutableArray *statusItemArray = [NSMutableArray array];
        for (int i = 0; i < statusTitlteArray.count; i ++) {
            YingShowHorSelectModel *model = [[YingShowHorSelectModel alloc] init];
            model.titleStr = statusTitlteArray[i];
            if (i == 0) {
                model.isSelected = YES;
            }
            [statusItemArray addObject:model];
        }
        
        
        self.statusScrollView = [[YingShowHorSelectScrollView alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(statusLabel.frame) + 5, SCREENWIDTH - 20, 15) items:statusItemArray];
        self.statusScrollView.horScrollDelegate = self;
        
        [_gaojiSearchView addSubview:self.statusScrollView];
        
        
        
        UILabel *timeRangeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.statusScrollView.frame) + 10, 200, 15)];
        timeRangeLabel.textColor = KColorGray333;
        timeRangeLabel.text = @"时间范围";
        timeRangeLabel.textAlignment = NSTextAlignmentLeft;
        timeRangeLabel.font = SystemFont(15.0f);
        [_gaojiSearchView addSubview:timeRangeLabel];

        
        [_gaojiSearchView addSubview:self.startTimeButton];
        [self.startTimeButton setFrame:RECT(LeftPadding, CGRectGetMaxY(timeRangeLabel.frame) + 10, (SCREENWIDTH - 10 - 10 - 10)/2.0, 40)];
        [_gaojiSearchView addSubview:self.endTimeButton];
        [self.endTimeButton setFrame:RECT(LeftPadding + self.startTimeButton.width + LeftPadding, CGRectGetMaxY(timeRangeLabel.frame) + 10, (SCREENWIDTH - 10 - 10 - 10)/2.0, 40)];
        
        UILabel *monenyRangeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.endTimeButton.frame) + 10, 200, 15)];
        monenyRangeLabel.textColor = KColorGray333;
        monenyRangeLabel.text = @"金额范围";
        monenyRangeLabel.textAlignment = NSTextAlignmentLeft;
        monenyRangeLabel.font = SystemFont(15.0f);
        [_gaojiSearchView addSubview:monenyRangeLabel];
        
        
        [_gaojiSearchView addSubview:self.minMonenyTextField];
        
        [self.minMonenyTextField setFrame:RECT(LeftPadding, CGRectGetMaxY(monenyRangeLabel.frame) + 10, (SCREENWIDTH - 10 - 10 - 10)/2.0, 40)];
        
        [_gaojiSearchView addSubview:self.maxMonenyTextField];
        
        [self.maxMonenyTextField setFrame:RECT(LeftPadding + self.minMonenyTextField.width + LeftPadding, CGRectGetMaxY(monenyRangeLabel.frame) + 10, (SCREENWIDTH - 10 - 10 - 10)/2.0, 40)];

        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.maxMonenyTextField.frame) + 10, 200, 15)];
        addressLabel.textColor = KColorGray333;
        addressLabel.text = @"地区";
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.font = SystemFont(15.0f);
        [_gaojiSearchView addSubview:addressLabel];
        
        [_gaojiSearchView addSubview:self.addressSearchTextField];
        
        _gaojiSearchView.hidden = YES;
        

    }
    return _gaojiSearchView;
}



-(UIButton *)startTimeButton
{
    if (!_startTimeButton) {
        _startTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startTimeButton.layer.cornerRadius = 3.0f;
        _startTimeButton.layer.masksToBounds = YES;
        [_startTimeButton setTitle:@"选择开始时间" forState:UIControlStateNormal];
        [_startTimeButton setTitleColor:RGBCOLOR(199, 199, 205) forState:UIControlStateNormal];
        _startTimeButton.backgroundColor = [UIColor whiteColor];
        _startTimeButton.titleLabel.font = SystemFont(13.0f);
        [_startTimeButton addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _startTimeButton;
}


-(UIButton *)endTimeButton
{
    if (!_endTimeButton) {
        _endTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _endTimeButton.layer.cornerRadius = 3.0f;
        _endTimeButton.layer.masksToBounds = YES;
        [_endTimeButton setTitle:@"选择结束时间" forState:UIControlStateNormal];
        _endTimeButton.titleLabel.font = SystemFont(13.0f);
        [_endTimeButton setTitleColor:RGBCOLOR(199, 199, 205) forState:UIControlStateNormal];
        _endTimeButton.backgroundColor = [UIColor whiteColor];
        [_endTimeButton addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endTimeButton;
}


-(XWMoneyTextField *)minMonenyTextField
{
    
    if (!_minMonenyTextField) {
        _minMonenyTextField = [[XWMoneyTextField alloc] initWithFrame:CGRectZero];
        _minMonenyTextField.placeholder = @"最小金额";
        _minMonenyTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _minMonenyTextField.limit.delegate = self;
        _minMonenyTextField.limit.max = @"999999.99";
        _minMonenyTextField.backgroundColor = [UIColor whiteColor];
        _minMonenyTextField.layer.cornerRadius = 2.0f;
        _minMonenyTextField.font  = SystemFont(14.0f);
        _minMonenyTextField.layer.masksToBounds = YES;
        [self.view addSubview:_minMonenyTextField];
        
    }
    return _minMonenyTextField;
    
}
-(XWMoneyTextField *)maxMonenyTextField
{

    if (!_maxMonenyTextField) {
        _maxMonenyTextField = [[XWMoneyTextField alloc] initWithFrame:CGRectZero];
        _maxMonenyTextField.placeholder = @"最大金额";
        _maxMonenyTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _maxMonenyTextField.limit.delegate = self;
        _maxMonenyTextField.font  = SystemFont(14.0f);
        _maxMonenyTextField.backgroundColor = [UIColor whiteColor];
        _maxMonenyTextField.layer.cornerRadius = 2.0f;
        _maxMonenyTextField.layer.masksToBounds = YES;
        _maxMonenyTextField.limit.max = @"999999.99";
        [self.view addSubview:_maxMonenyTextField];

    }
    return _maxMonenyTextField;

}

-(BorderTextFieldView *)addressSearchTextField
{
    if (!_addressSearchTextField) {
        _addressSearchTextField = [[BorderTextFieldView alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.maxMonenyTextField.frame) + 25 + 10, SCREENWIDTH - 20, 40)];
        _addressSearchTextField.keyboardType = UIKeyboardTypeWebSearch;
        _addressSearchTextField.textColor = kFormTextColor;
        _addressSearchTextField.cleanBtnOffset_x = _addressSearchTextField.width - 40;
        _addressSearchTextField.delegate = self;
        _addressSearchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入地区" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)}];
        
    }
    return _addressSearchTextField;
}



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

-(ZHPickView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [[ZHPickView alloc] initDatePickWithDate:nil datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _datePickerView.delegate = self;
    }
    return _datePickerView;
}


#pragma -mark----HorScrollView Delegatge Methods-----

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
    else if(horScrollView.tag == 1002){//债权债务的
        if ([horScrollView.selectObject isEqualToString:@"债权人"]) {
            self.zhaiquanSelectStr = @"credit";
        }
        else if ([horScrollView.selectObject isEqualToString:@"债务人"])
        {
            self.zhaiquanSelectStr = @"debt";
        }
    }
    else if (horScrollView == self.statusScrollView)
    {
        NSString *statusSelectStr = [YingShowInfoModel getSubmitStrWithSelectObject:self.statusScrollView.selectObject];
        
        self.zhaiStatusSelectStr = statusSelectStr;
    }
}


@end
