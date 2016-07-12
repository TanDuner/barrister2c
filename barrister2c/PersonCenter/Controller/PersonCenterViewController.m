//
//  PersonCenterViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/15.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "PersonCenterModel.h"
#import "PersonCenterCustomCell.h"
#import "PersonCenterAccountCell.h"
#import "MyMessageViewController.h"
#import "PersonInfoViewController.h"
#import "SettingViewController.h"
#import "MyLikeViewController.h"
#import "MyAccountViewController.h"
#import "MyOrderListViewController.h"
#import "BarristerLoginManager.h"



@implementation PersonCenterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self configData];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:NOTIFICATION_LOGIN_SUCCESS object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:NOTIFICATION_LOGOUT_SUCCESS object:nil];

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:YES];
    if (self.tableView) {
        [self.tableView reloadData];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma -mark ------Data-------

-(void)configData
{
    PersonCenterModel *model1 = [[PersonCenterModel alloc] init];
    model1.cellType = PersonCenterModelTypeZH;

    if ([BaseDataSingleton shareInstance].loginState.integerValue == 1) {
        model1.titleStr = [BaseDataSingleton shareInstance].userModel.nickname;
        model1.iconNameStr = [BaseDataSingleton shareInstance].userModel.userIcon;
        model1.isShowArrow = NO;
        model1.isAccountLogin = YES;

    }
    else
    {
        model1.titleStr = @"注册/登录";
        model1.cellType = PersonCenterModelTypeZH;
        model1.iconNameStr = @"commom_default_head.png";
        model1.isShowArrow = NO;
        model1.isAccountLogin = NO;

    }
    
    
    PersonCenterModel *model = [[PersonCenterModel alloc] init];
    model.titleStr = @"我的收藏";
    model.cellType = PersonCenterModelTypeSZ;
    model.iconNameStr = @"Me_like";
    model.isShowArrow = YES;

    
    PersonCenterModel *model2 = [[PersonCenterModel alloc] init];
    model2.titleStr = @"我的账户";
    model2.cellType = PersonCenterModelTypeZHU;
    model2.iconNameStr = @"Me_Account";
    model2.isShowArrow = YES;
    
    PersonCenterModel *model5 = [[PersonCenterModel alloc] init];
    model5.titleStr = @"我的订单";
    model5.cellType = PersonCenterModelTypeDD;
    model5.iconNameStr = @"Me_order";
    model5.isShowArrow = YES;

    
    PersonCenterModel *model3 = [[PersonCenterModel alloc] init];
    model3.titleStr = @"我的消息";
    model3.cellType = PersonCenterModelTypeXX;
    model3.iconNameStr = @"Me_message";
    model3.isShowArrow = YES;
    
    
    PersonCenterModel *model6 = [[PersonCenterModel alloc] init];
    model6.titleStr = @"设置";
    model6.cellType = PersonCenterModelTypeSZ;
    model6.iconNameStr = @"Me_setting";
    model6.isShowArrow = YES;
    
    [self.items addObject:model1];
    [self.items addObject:model];
    [self.items addObject:model5];

    
    [self.items addObject:model2];
    [self.items addObject:model3];
    [self.items addObject:model6];
}


#pragma -mark --------UI--------

-(void)reloadTableView
{
    [self.items removeAllObjects];
    [self configData];
    [self.tableView reloadData];
}

-(void)configView
{
    
}


#pragma -mark --------UITableView DataSource Methods----------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20)];
        view.backgroundColor = kBaseViewBackgroundColor;
        return view;
    }
    else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        return 20;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"accountCell";
        PersonCenterAccountCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[PersonCenterAccountCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        PersonCenterModel *model =  (PersonCenterModel *)[self.items safeObjectAtIndex:0];
        cell.model = model;
        return cell;
        
    }
    else
    {
        static NSString *CellIdentifier = @"customCell";
        PersonCenterCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[PersonCenterCustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        PersonCenterModel *model =  (PersonCenterModel *)[self.items safeObjectAtIndex:indexPath.section == 1?(indexPath.row + 1):(self.items.count - 1)];
        cell.model = model;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [PersonCenterAccountCell getCellHeight];
    }
    else
    {
        return  [PersonCenterCustomCell getCellHeight];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    
    if (indexPath.section == 0) {
        
        if (![BaseDataSingleton shareInstance].loginState.integerValue  == 1) {
            [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
            return;
        }
        
        PersonInfoViewController *personInfo = [[PersonInfoViewController alloc] init];
        [self.navigationController pushViewController:personInfo animated:YES];
    }
    else if (indexPath.section == 1)
    {
        
        if (![BaseDataSingleton shareInstance].loginState.integerValue == 1) {
            [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
            return;
        }
        
        switch (indexPath.row) {
            case 0:
            {
             
                MyLikeViewController *likeVC = [[MyLikeViewController alloc] init];
                [self.navigationController pushViewController:likeVC animated:YES];

            }
                break;
            case 1:
            {
                MyOrderListViewController *orderListVC = [[MyOrderListViewController alloc] init];
                [self.navigationController pushViewController:orderListVC animated:YES];
            }
                break;
            case 2:
            {
                MyAccountViewController *accountVC = [[MyAccountViewController alloc] init];
                [self.navigationController pushViewController:accountVC animated:YES];
            }
                break;
            case 3:
            {
                MyMessageViewController *messageVC = [[MyMessageViewController alloc] init];
                [self.navigationController pushViewController:messageVC animated:YES];

            }
                break;
            default:
                break;
        }
    }
    else
    {
        SettingViewController *settingVC = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}


@end
