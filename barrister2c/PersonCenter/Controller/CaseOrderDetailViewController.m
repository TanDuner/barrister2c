//
//  CaseOrderDetailViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "CaseOrderDetailViewController.h"
#import "OrderDetailOrderCell.h"
#import "OrderProxy.h"
#import "OrderDetailViewController.h"
#import "OnlineWaitPayCell.h"
#import "MyAccountRechargeVC.h"

@interface CaseOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BarristerOrderDetailModel *orderDetailModel;

}

@property (nonatomic,strong) UITableView *orderTableView;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) OrderProxy *proxy;


@property (nonatomic,strong) NSString *moneny;


@end

@implementation CaseOrderDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configView];
    
    [self initData];
    
    
}
-(void)configView
{
    self.title = @"订单详情";
    
    [self.view addSubview:self.orderTableView];
    
    
}

#pragma -mark -------Data----------

-(void)initData
{
    self.items = [NSMutableArray arrayWithCapacity:1];
    
    OrderDetailCellModel *model1 = [[OrderDetailCellModel alloc] init];
    model1.showType = OrderDetailShowTypeOrderInfo;
    [self.items addObject:model1];

    
    if ([self.orderModel.payStatus isEqualToString:@"0"]) {//未支付
        OrderDetailCellModel *model2 = [[OrderDetailCellModel alloc] init];
        model2.showType = OrderDetailShowTypeOnlineWaitPay;
        [self.items addObject:model2];
   
    }
    
    OrderDetailCellModel *model3 = [[OrderDetailCellModel alloc] init];
    model3.showType = OrderDetailShowTypeOnlineQQ;
    
    [self.items addObject:model3];
    
    
    OrderDetailCellModel *model4 = [[OrderDetailCellModel alloc] init];
    model4.showType = OrderDetailShowTypeOnlinePhone;
    
    [self.items addObject:model4];


//    g *payStatus;
//    @property (nonatomic,strong) NSString *orderTime;
//    @property (nonatomic,strong) NSString *qq;
//    @property (nonatomic,strong) NSString *phone;
    
    
    orderDetailModel = [[BarristerOrderDetailModel alloc] init];

    
    orderDetailModel.type = ONLINE;
    
    orderDetailModel.payStatus = self.orderModel.payStatus;
    
    orderDetailModel.orderTime = self.orderModel.date;
    
    orderDetailModel.qq = self.orderModel.qq;
    
    orderDetailModel.phone = self.orderModel.phone;
    
    orderDetailModel.paymentAmount = self.orderModel.paymentAmount;
    
}

#pragma -mark --------UITableView DataSource Methods------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(*&self) weakSelf = self;
    OrderDetailCellModel *modeTemp = (OrderDetailCellModel *)[self.items safeObjectAtIndex:indexPath.row];
    switch (modeTemp.showType) {
        case OrderDetailShowTypeOrderInfo:
        {
            OrderDetailOrderCell * cellTemp = [[OrderDetailOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.model = orderDetailModel;
            return cellTemp;
        }
            break;
        case OrderDetailShowTypeOnlineWaitPay:
        {
            OnlineWaitPayCell * cellTemp = [[OnlineWaitPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.selectionStyle = UITableViewCellSelectionStyleNone;
            cellTemp.block = ^()
            {
                [weakSelf pay];
            };
            cellTemp.model = orderDetailModel;
            return cellTemp;
        }
            break;
         case OrderDetailShowTypeOnlineQQ:
        {
            UITableViewCell *qqCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UIImageView *leftImage = [[UIImageView alloc] initWithFrame:RECT(10, 10, 30, 30)];
            leftImage.image = [UIImage imageNamed:@""];
            [qqCell.contentView addSubview:leftImage];
            
            UILabel *label = [[UILabel alloc] initWithFrame:RECT(50, 0, 200, 50)];
            label.font = SystemFont(14.0f);
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = KColorGray333;
            label.text = self.orderModel.qq?self.orderModel.qq:@"";
            [qqCell.contentView addSubview:label];
            
            UIImageView *lineView = [[UIImageView alloc] init];
            lineView.backgroundColor = kSeparatorColor;
            [lineView setFrame:RECT(0, 49.5, SCREENWIDTH, .5)];
            [qqCell.contentView addSubview:lineView];
            
            return qqCell;
        
        }
           break;
            case OrderDetailShowTypeOnlinePhone:
        {
        
            UITableViewCell *phoneCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UIImageView *leftImage = [[UIImageView alloc] initWithFrame:RECT(10, 10, 30, 30)];
            leftImage.image = [UIImage imageNamed:@""];
            [phoneCell.contentView addSubview:leftImage];
            
            UILabel *label = [[UILabel alloc] initWithFrame:RECT(50, 0, 200, 50)];
            label.font = SystemFont(14.0f);
            label.text = self.orderModel.phone?self.orderModel.phone:@"";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = KColorGray333;
            
            [phoneCell.contentView addSubview:label];
            return phoneCell;
            
        }
            break;
            
        default:
        {
            return [UITableViewCell new];
        }
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailCellModel *modelTemp = (OrderDetailCellModel *)[self.items safeObjectAtIndex:indexPath.row];
    switch (modelTemp.showType) {
        case OrderDetailShowTypeOrderInfo:
        {
            return [OrderDetailOrderCell getHeightWithModel:orderDetailModel];
        }
            break;
        case OrderDetailShowTypeOnlineWaitPay:
        {
            return 100;
        }
            break;
        case OrderDetailShowTypeOnlineQQ:
        {
            return 50;
        }
            break;
        case OrderDetailShowTypeOnlinePhone:
        {
            return 50;
        }
            break;
            default:
            return 0;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.orderModel.payStatus isEqualToString:@"1"]) {
        if (indexPath.row == 1) {
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //用来接收临时消息的客服QQ号码(注意此QQ号需开通QQ推广功能,否则陌生人向他发送消息会失败)
                NSString *QQ = self.orderModel.qq;
                //调用QQ客户端,发起QQ临时会话
                NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }

        }
        else if(indexPath.row == 2){
            if ([[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.orderModel.phone];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }

        }
    }
    else
    {
        if (indexPath.row == 2) {
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //用来接收临时消息的客服QQ号码(注意此QQ号需开通QQ推广功能,否则陌生人向他发送消息会失败)
                NSString *QQ = self.orderModel.qq;
                //调用QQ客户端,发起QQ临时会话
                NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
            
        }
        else if(indexPath.row == 3){
            if ([[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.orderModel.phone];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
            
        }

    }
 
  
}


-(void)pay
{

    NSString *tip  =[NSString stringWithFormat:@"您将支付线上服务费用%@元",self.orderModel.paymentAmount];
    
    [XuUItlity showYesOrNoAlertView:@"确认" noText:@"取消" title:@"提示" mesage:tip callback:^(NSInteger buttonIndex, NSString *inputString) {
        if (buttonIndex == 1) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.orderModel.orderId forKey:@"orderId"];
            [XuUItlity showLoading:@"正在支付..."];
            __weak typeof(*&self) weakSelf = self;
            [self.proxy payOnlineServiceWithParams:params Block:^(id returnData, BOOL success) {
                [XuUItlity hideLoading];
                if (success) {
                    weakSelf.orderModel.payStatus = @"1";
                    [weakSelf initData];
                    [XuUItlity showSucceedHint:@"支付成功" completionBlock:nil];
                    
                    
                }
                else
                {
                    NSDictionary *dict = (NSDictionary *)returnData;
                    weakSelf.orderModel.payStatus= @"0";
                    NSString *resultCode = [dict objectForKey:@"resultCode"];
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
                    else
                    {
                        [XuUItlity showFailedHint:@"支付失败" completionBlock:nil];
                        
                    }
                    
                }
            }];
            
        }
        else
        {
            
        }

    }];
    
    
}


#pragma -mark ----Getter---

-(UITableView *)orderTableView
{
    if (!_orderTableView) {
        _orderTableView  =[[UITableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
        _orderTableView.delegate  = self;
        _orderTableView.dataSource  = self;
        _orderTableView.backgroundColor = kBaseViewBackgroundColor;
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.tableFooterView = [UIView new];
    }
    return _orderTableView;
}

-(OrderProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[OrderProxy alloc] init];
    }
    return _proxy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
