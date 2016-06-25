//
//  LawerDetailViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerDetailViewController.h"
#import "LawerDetailMidCell.h"
#import "LawerListCell.h"
#import "LawerDetailBottomCell.h"
#import "LawerSelectTimeViewController.h"


typedef void(^ShowTimeSelectBlock)(id object);

@interface LawerDetailViewController ()

@property (nonatomic,strong) LawerSelectTimeViewController *selectTimeView;

@end

@implementation LawerDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configData];
    
    [self configView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showTabbar:NO];
}

#pragma -mark --UI--

-(void)configView
{
    self.title = @"律师详情";
}


#pragma -mark ---Data----

-(void)configData
{
    self.model = [[BarristerLawerModel alloc] init];
    self.model.name = @"李言";
    self.model.workingStartYear = @"2008";
    self.model.workYears = @"8";
    self.model.rating = 3.5;
    self.model.goodAt = @"经济犯罪|法律顾问|家庭";
    self.model.area = @"北京丰台";
    self.model.company = @"京城律师事务所";
    self.model.userIcon = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=327417392,2097894166&fm=116&gp=0.jpg";
    self.model.appraiseCount = 10;
    self.model.recentServiceTimes = 20;
    
    self.model.introduceStr = @"王律师是个好律师,打过很多著名的案件，王律师是个好律师,打过很多著名的案件，王律师是个好律师,打过很多著名的案件，王律师是个好律师,打过很多著名的案件，王律师是个好律师,打过很多著名的案件，王律师是个好律师,打过很多著名的案件!";
    [self.model handleProprety];
    
    
}

#pragma -mark ----Action----

-(void)showTimeSelectView
{
    [self.selectTimeView show];
}


#pragma -mark ----UITableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            
            [self showTimeSelectView];
        }
    }

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else if(section == 1)
    {
        return 2;
    }
    else
    {
        return 0;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [LawerListCell getCellHeight];
        }
        else 
        {
            return [LawerDetailMidCell getCellHeightWithModel:self.model];
        }

    }
    else if (indexPath.section == 1)
    {
        return 60;
    }
    else
    {
        return 0;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LawerListCell *cell = [[LawerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        }
        else
        {
            LawerDetailMidCell *cell = [[LawerDetailMidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.model = self.model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            LawerDetailBottomCell *cell = [[LawerDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.topLabel.text = @"即时咨询";
            cell.bottomLabel.text = @"立即与律师沟通";
            return cell;
        }
        else
        {
            LawerDetailBottomCell *cell = [[LawerDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.topLabel.text = @"预约咨询";
            cell.bottomLabel.text = @"约定时间与律师沟通";

            return cell;
        }
    }
    else
    {
        return [UITableViewCell new];
    }
}

#pragma -mark ---Getter---

-(LawerSelectTimeViewController *)selectTimeView
{
    if (!_selectTimeView) {
        _selectTimeView = [[LawerSelectTimeViewController alloc] init];
        [_selectTimeView.view setCenter:CGPointMake(self.view.center.x, 1000)];
        [self.view addSubview:_selectTimeView.view];

    }
    return _selectTimeView;
}


@end
