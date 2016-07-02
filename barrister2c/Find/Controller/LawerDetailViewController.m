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
#import "LawerListProxy.h"

typedef void(^ShowTimeSelectBlock)(id object);

@interface LawerDetailViewController ()

@property (nonatomic,strong) LawerSelectTimeViewController *selectTimeView;

@property (nonatomic,strong) LawerListProxy *proxy;

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
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.model.laywerId,@"lawyerId", nil];
    __weak typeof(*&self) weakSelf  = self;
    [self.proxy getOrderDetailWithParams:params Block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            [weakSelf handleLawerDataWithDict:dict];
        }
        else
        {
            [XuUItlity showFailedHint:@"加载失败" completionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
    
    
}


-(void)handleLawerDataWithDict:(NSDictionary *)dict
{
    NSDictionary *laywerDict = [dict objectForKey:@"detail"];
    self.model = [[BarristerLawerModel alloc] initWithDictionary:laywerDict];
    
    [self.tableView reloadData];
}

#pragma -mark ----Action----

-(void)showTimeSelectView
{
    [self.selectTimeView show];
}


-(void)collectionAction
{

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.model.laywerId,@"lawyerId", nil];
    __weak typeof(*&self) weakSelf = self;
    if (![self.model.isCollect isEqualToString:@"yes"]) {
        [self.proxy collectLaywerWithParams:params Block:^(id returnData, BOOL success) {
            if (success) {
                weakSelf.model.isCollect = @"yes";
            }
            else
            {
                NSString *resultCode = (NSString *)returnData;
                if ([[NSString stringWithFormat:@"%@",resultCode] isEqualToString:@"1009"]) {
                    [XuUItlity showFailedHint:@"已经收藏" completionBlock:nil];
                    weakSelf.model.isCollect = @"yes";
                }
                else
                {
                    weakSelf.model.isCollect = @"no";
                }


            }
            
            [weakSelf.tableView reloadData];
        }];
    }
    else
    {
        [self.proxy cancelCollectLaywerWithParams:params Block:^(id returnData, BOOL success) {
            if (success) {
                weakSelf.model.isCollect = @"no";
            }
            else
            {
                weakSelf.model.isCollect = @"yes";
            }
            [weakSelf.tableView reloadData];
        }];
    }

    
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
            __weak typeof(*&self) weakSelf = self;
            LawerDetailMidCell *cell = [[LawerDetailMidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.block = ^(BarristerLawerModel *model)
            {
                [weakSelf collectionAction];
            };
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
            cell.leftImageView.image = [UIImage imageNamed:@"imService"];
            cell.bottomLabel.text = @"立即与律师沟通";
            return cell;
        }
        else
        {
            LawerDetailBottomCell *cell = [[LawerDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.topLabel.text = @"预约咨询";
            cell.leftImageView.image = [UIImage imageNamed:@"appointmentService"];
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

-(LawerListProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[LawerListProxy alloc] init];
    }
    return _proxy;
}

@end
