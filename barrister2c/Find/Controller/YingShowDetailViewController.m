//
//  YingShowDetailViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowDetailViewController.h"
#import "YingShowDetailBottomCell.h"
#import "YingShowListCell.h"

@interface YingShowDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation YingShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
    
}


-(void)initView
{
    [self initNavigationRightTextButton:@"支付" action:@selector(payAction)];
    
    [self.view addSubview:self.tableView];
}


-(void)payAction
{
    
}


-(void)initData
{
    
    YingShowUserModel *userModel = [[YingShowUserModel alloc] init];
    userModel.name = @"张三";
    userModel.company = @"58同城";
    userModel.companyPhone = @"010-59565858";
    userModel.address = @"酒仙桥北路甲10号院";
    userModel.liceseeNuber = @"848248958394849";
    userModel.ID_number = @"103847593785959550";
    userModel.phone = @"13333333333";
    

    
    YingShowInfoModel *model = [[YingShowInfoModel alloc] init];
    
    model.creditUser = userModel;
    
    [model handlePropretyWithDict:nil];
    
    
    model.type = @"合同欠款";
    model.updateTime = @"2016-10-12";
    model.addTime = @"2016-03-04";
    model.status = @"已通过";
    model.money = @"10000";
    
    model.cellHeight = 141;
    
    
    self.model = model;
    
    [self.tableView reloadData];
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

#pragma -mark ---UITableView Delegate Methods---

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 87;
    }
    else if (indexPath.section == 1)
    {
       return [YingShowDetailBottomCell getCellHeightWithModel:self.model];
    }
    else if (indexPath.section == 2)
    {
       return [YingShowDetailBottomCell getCellHeightWithModel:self.model];
    }
    else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YingShowListCell *cell = [[YingShowListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section == 1)
    {
        YingShowDetailBottomCell *cell = [[YingShowDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section == 2)
    {
        YingShowDetailBottomCell *cell = [[YingShowDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.model = self.model;
        return cell;
    }
    return nil;
}


#pragma -mark ---Getter----

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_HIGHTIOS_7) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
