//
//  LawerListViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//
#import "LawerListViewController.h"
#import "RefreshTableView.h"
#import "LawerListCell.h"
#import "IMPullDownMenu.h"
#import "LawerDetailViewController.h"
#import "LawerListProxy.h"
#import "BussinessAreaModel.h"
#import "BussinessTypeModel.h"

@interface LawerListViewController ()<UITableViewDataSource,UITableViewDelegate,IMPullDownMenuDelegate,RefreshTableViewDelegate>

@property (nonatomic,strong) IMPullDownMenu *pullDownMenu;

@property (nonatomic,strong) LawerListProxy *proxy;

@property (nonatomic,strong) RefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray *items;

/**
 *  用于pullDown Menu
 */

@property (nonatomic,strong) NSString *city;

//@property (nonatomic,strong) BussinessAreaModel *bussinessAreaModel;
//
//@property (nonatomic,strong) BussinessTypeModel *bussinessTypeModel;

@property (nonatomic,strong) NSString *year;


@property (nonatomic,strong) NSArray *cityArray;


@property (nonatomic,strong) NSArray *yearsArray;

@end

@implementation LawerListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configView];

    [self configData];
}

-(void)configData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.type) {
        [params setObject:self.type forKey:@"type"];
    }
    if (self.bussinessAreaModel) {
        [params setObject:self.bussinessAreaModel.areaId forKey:@"caseType"];
    }
    if (self.bussinessTypeModel) {
        [params setObject:self.bussinessTypeModel.typeId forKey:@"businessType"];
    }
    if (self.city) {
        [params setObject:self.city forKey:@"area"];
    }
    
    if (self.year) {
        [params setObject:self.year forKey:@"year"];
    }
    
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageSize] forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.tableView.pageNum] forKey:@"page"];
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
    
    
    [self.tableView reloadData];
    
}

-(void)handleLawerDataWithArray:(NSArray *)array
{
    __weak typeof(*&self)weakSelf = self;
    
    [self handleTableRefreshOrLoadMoreWithTableView:self.tableView array:array aBlock:^{
        [weakSelf.items removeAllObjects];
    }];
    
    for ( int i = 0; i < array.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
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


#pragma -mark ----
- (void)PullDownMenu:(IMPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    if (column == 0) {
        if (self.cityArray) {
            if (row == 0) {
                self.city = nil;
            }
            else
            {
                if (self.cityArray.count > row - 1) {
                    self.city = [self.cityArray objectAtIndex:row - 1];
                }
            }
            

        }

    }
    else if (column == 1)
    {
        if (row == 0) {
            self.bussinessAreaModel = nil;
        }
        else
        {
            if ([BaseDataSingleton shareInstance].bizAreas.count > row - 1) {
                self.bussinessAreaModel = [[BaseDataSingleton shareInstance].bizAreas objectAtIndex:row - 1];
            }
        }

    }
    else if (column == 2)
    {
        if (row == 0) {
            self.bussinessTypeModel = nil;
        }
        else
        {
            if ([BaseDataSingleton shareInstance].bizTypes.count > row - 1) {
                self.bussinessTypeModel = [[BaseDataSingleton shareInstance].bizTypes objectAtIndex:row - 1];
            }
        }
    }
    else if (column == 3)
    {
        if (row == 0) {
            self.year = @"";
        }
        else if(row == 1)
        {
            self.year = @"3";
        }
        else if (row == 2)
        {
            self.year = @"5";
        }
        else if (row == 3)
        {
            self.year = @"10";
        }
        else if (row == 4)
        {
            self.year = @"11";
        }
    }
    
    [self configData];
}


#pragma - mark ---ConfigView

-(void)configView
{
    self.title = @"律师列表";
    
    self.pullDownMenu = [[IMPullDownMenu alloc] initWithArray:@[] frame:CGRectMake(0, 0, SCREENWIDTH, 44) viewController:self];
    self.pullDownMenu.backgroundColor = [UIColor whiteColor];
    self.pullDownMenu.delegate = self;

    
    [self.view addSubview:self.tableView];
    
    NSMutableArray *sortArray = [NSMutableArray arrayWithCapacity:0];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *cityList = [NSArray arrayWithContentsOfFile:plistPath];

    NSMutableArray *cityArray = [NSMutableArray array];
    
    for (int i = 0; i < cityList.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[cityList objectAtIndex:i];
        NSString *city = [dict objectForKey:@"state"];
        [cityArray addObject:city];
    }
    self.cityArray = [NSArray arrayWithArray:cityArray];
    
    IMPullDownMenuItem *sortItem = [[IMPullDownMenuItem alloc] init];
    sortItem.unlimitedBtnText = @"不限";
    sortItem.listItemArray =  cityArray;
    sortItem.title = @"地区";
    [sortArray addObject:sortItem];

    [self.noContentView setFrame:RECT(0, self.pullDownMenu.height, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - self.pullDownMenu.height)];

    
    NSMutableArray *areaTitlesArray = [NSMutableArray array];
    for (int i = 0; i < [BaseDataSingleton shareInstance].bizAreas.count; i ++) {
        BussinessAreaModel *model = (BussinessAreaModel *)[[BaseDataSingleton shareInstance].bizAreas objectAtIndex:i];
        [areaTitlesArray addObject:model.name];
    }

 
    
    NSMutableArray *typeTitlesArray = [NSMutableArray array];
    for (int i = 0; i < [BaseDataSingleton shareInstance].bizTypes.count; i ++) {
        BussinessAreaModel *model = (BussinessAreaModel *)[[BaseDataSingleton shareInstance].bizTypes objectAtIndex:i];
        [typeTitlesArray addObject:model.name];
    }

    
    IMPullDownMenuItem *sortItem1 = [[IMPullDownMenuItem alloc] init];
    sortItem1.unlimitedBtnText = @"不限";
    sortItem1.listItemArray =  areaTitlesArray;
    sortItem1.title = @"领域";
    [sortArray addObject:sortItem1];
    
    
    IMPullDownMenuItem *sortItem2 = [[IMPullDownMenuItem alloc] init];
    sortItem2.unlimitedBtnText = @"不限";
    sortItem2.listItemArray =  typeTitlesArray;
    sortItem2.title = @"业务";
    [sortArray addObject:sortItem2];
    
    self.yearsArray = @[@"1-3年",@"3-5年",@"5-10年",@"10年以上"];
    
    IMPullDownMenuItem *sortItem3 = [[IMPullDownMenuItem alloc] init];
    sortItem3.unlimitedBtnText = @"不限";
    sortItem3.listItemArray =  self.yearsArray;
    sortItem3.title = @"年限";
    [sortArray addObject:sortItem3];
    
    
    [self.pullDownMenu resetDataArray:sortArray];

    [self.pullDownMenu addSubview:[self getLineViewWithFrame:RECT(0, self.pullDownMenu.bounds.size.height - .5, SCREENWIDTH, .5)]];
    
    [self.view addSubview:self.pullDownMenu];
    
    if (self.bussinessAreaModel) {
        NSInteger index = -999;
        for (int  i = 0; i < [BaseDataSingleton shareInstance].bizAreas.count; i ++) {
            BussinessAreaModel *model = [[BaseDataSingleton shareInstance].bizAreas objectAtIndex:i];
            if ([self.bussinessAreaModel.areaId isEqualToString:model.areaId]) {
                index = i;
            }
        }
        
        if (index != -999) {
            [self.pullDownMenu setColumn:1 row:index + 1];
        }
        
    }
    
    if (self.bussinessTypeModel) {
        NSInteger index = -999;
        for (int  i = 0; i < [BaseDataSingleton shareInstance].bizTypes.count; i ++) {
            BussinessTypeModel *model = [[BaseDataSingleton shareInstance].bizTypes objectAtIndex:i];
            if ([self.bussinessTypeModel.typeId isEqualToString:model.typeId]) {
                index = i;
            }
        }
        
        if (index != -999) {
            [self.pullDownMenu setColumn:2 row:index + 1];
        }
        
    }
    
    
    [self.view addSubview:self.tableView];
    [self.tableView setFrame:RECT(0, self.pullDownMenu.y + self.pullDownMenu.height, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - self.pullDownMenu.height)];
    
    
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
        BarristerLawerModel *model = [self.items objectAtIndex:indexPath.row];
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
        detailVC.model = [self.items objectAtIndex:indexPath.row];        
    }

    [self.navigationController pushViewController:detailVC animated:YES];
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
