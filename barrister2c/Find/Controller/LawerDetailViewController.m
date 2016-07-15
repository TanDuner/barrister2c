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
#import "AppointmentManager.h"
#import "AppointmentMoel.h"
#import "XuAlertView.h"
#import "MyAccountRechargeVC.h"
#import "BarristerLoginManager.h"

typedef void(^ShowTimeSelectBlock)(id object);

@interface LawerDetailViewController ()<FinishAppoinmentDelegate>

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
    [XuUItlity showLoading:@"正在加载"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.lawyerId,@"lawyerId", nil];
    __weak typeof(*&self) weakSelf  = self;
    [self.proxy getOrderDetailWithParams:params Block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
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
    [XuUItlity showLoading:@"正在加载..."];
    NSString *dateStr = [XuUtlity stringFromDate:[NSDate date] forDateFormatterStyle:DateFormatterDate];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.model.laywerId,@"lawyerId",dateStr,@"date", nil];
    __weak typeof(*&self) weakSelf = self;
    [self.proxy getLawerAppointmentDataWithParams:params Block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"appointmentSettings"];
            if ([XuUtlity isValidArray:array]) {
                [strongSelf handleAppointmentDataWithArray:array];
            }
            else
            {
                [strongSelf handleAppointmentDataWithArray:@[]];
            }
        }
        else
        {
            [XuUItlity showFailedHint:@"获取设置信息失败" completionBlock:nil];
        }

    }];
    
}

-(void)handleAppointmentDataWithArray:(NSArray *)array
{
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[array safeObjectAtIndex:i];
        AppointmentMoel *model = [[AppointmentMoel alloc] initWithDictionary:dict];
        
        for (int j = 0; j < [AppointmentManager shareInstance].modelArray.count; j ++) {
            AppointmentMoel *modelTemp = [[AppointmentManager shareInstance].modelArray safeObjectAtIndex:j];
            if ([modelTemp.date isEqualToString:model.date]) {
                [[AppointmentManager shareInstance].modelArray replaceObjectAtIndex:j withObject:model];
            }
        }
    }
    
    if ([AppointmentManager shareInstance].modelArray.count > 0) {
        //把当前时间之前的全部置换为2
        AppointmentMoel *firstModel = [[AppointmentManager shareInstance].modelArray firstObject];
        [firstModel setCurrentOrEailerDateUnSelected];

    }

    
    
    self.selectTimeView = [[LawerSelectTimeViewController alloc] init];
    self.selectTimeView.lawerModel = self.model;
    self.selectTimeView.delegate = self;
    [self.selectTimeView.view setCenter:CGPointMake(self.view.center.x, 1000)];
    [self.view addSubview:self.selectTimeView.view];

    [self.selectTimeView showWithType:APPOINTMENT];
}

/**
 *  预约咨询
 *
 *  @param totalPrice
 *  @param price            <#price description#>
 *  @param appointmentArray <#appointmentArray description#>
 *  @param orderContent     <#orderContent description#>
 */

-(void)didFinishChooseAppoinmentWithMoneny:(NSString *)totalPrice
                                  PerPrice:(NSString *)price
                      appointmentDateArray:(NSMutableArray *)appointmentArray
                              Ordercontent:(NSString *)orderContent
{

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    for ( int i = 0; i < appointmentArray.count; i ++) {
        AppointmentMoel *model = [appointmentArray safeObjectAtIndex:i];
        NSString *settings = @"";
        for (int j = 0; j < model.settingArray.count; j ++) {
            NSString *settringPieceStr = [model.settingArray safeObjectAtIndex:j];
            settings = [NSString stringWithFormat:@"%@,%@",settings,settringPieceStr];
        }
        if ([settings hasPrefix:@","]) {
            settings = [settings substringFromIndex:1];
        }
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:model.date,@"date",settings,@"value", nil];
        
        [array addObject:dict];
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    if (array.count > 0) {
        NSString *str =  [[AppointmentManager shareInstance] objectToJsonStr:array];
        [params setObject:str forKey:@"appointmentDate"];
        
    }
    
    [params setObject:[NSString stringWithFormat:@"%@",totalPrice] forKey:@"money"];
    [params setObject:[NSString stringWithFormat:@"%@",price] forKey:@"price"];
    [params setObject:orderContent forKey:@"orderContent"];
    [params setObject:self.model.laywerId forKey:@"barristerId"];
    if (self.bussinesAreaStr.length > 0) {
        [params setObject:self.bussinesAreaStr forKey:@"caseType"];
    }

    [self.proxy placeOrderOrderWithParams:params Block:^(id returnData, BOOL success) {
        if (success) {
            if (array.count > 0) {
                [XuUItlity showOkAlertView:@"知道了" title:@"提示" mesage:@"下单成功,可以到我的订单查看" callback:nil];
            }
            else
            {
                [XuUItlity showOkAlertView:@"确定" title:@"提示" mesage:@"下单成功,系统即将为您建立通话 如果一分钟内未接到电话可以到我的订单手动拨号建立通话" callback:nil];

            }
            
        }
        else
        {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSString *resultCode = [dict objectForKey:@"resultCode"];
            NSString *resultMsg = [dict objectForKey:@"resultMsg"];
            if (resultCode.integerValue == 1007) {
                [XuUItlity showFailedHint:resultMsg completionBlock:nil];
            }
            if (resultCode.integerValue == 3000) {
                [XuUItlity showYesOrNoAlertView:@"充值" noText:@"取消" title:@"提示" mesage:@"余额不足，请充值" callback:^(NSInteger buttonIndex, NSString *inputString) {
                    if (buttonIndex == 0) {
                        NSLog(@"取消");
                    }
                    else
                    {
                        MyAccountRechargeVC *rechargeVC = [[MyAccountRechargeVC alloc] init];
                        [self.navigationController pushViewController:rechargeVC animated:YES];

                    }
                }];
                

            }
            
        }
    }];
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
    
    if (![BaseDataSingleton shareInstance].loginState.integerValue  == 1) {
        [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
        return;
    }

    if (indexPath.section == 1) {
       
        if (indexPath.row == 1) {
    
            [self showTimeSelectView];
       
        }
        else
        {
            
            if ([self.model.orderStatus isEqualToString:@"can"]) {
                self.selectTimeView = [[LawerSelectTimeViewController alloc] init];
                self.selectTimeView.lawerModel = self.model;
                self.selectTimeView.delegate = self;
                [self.selectTimeView.view setCenter:CGPointMake(self.view.center.x, 1000)];
                [self.view addSubview:self.selectTimeView.view];
                
                [self.selectTimeView showWithType:IM];

            }
            else
            {
                [XuUItlity showAlertHint:@"律师当前不接单哦~" completionBlock:nil andView:self.view];
            }
            

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
            cell.showAllBlock = ^(BarristerLawerModel *model)
            {
                model.isShowAll = ! model.isShowAll;
                [weakSelf.tableView reloadData];
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
