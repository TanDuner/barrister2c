//
//  OrderDetailViewController.m
//  barrister
//
//  Created by 徐书传 on 16/4/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailOrderCell.h"
#import "OrderDetailCustomInfoCell.h"
#import "OrderDetailCallRecordCell.h"
#import "OrderProxy.h"
#import "BarristerOrderDetailModel.h"
#import "OrderDetailCancelCell.h"
#import "OrderDetailMarkCell.h"
#import "AppriseOrderCell.h"
#import "UIButton+EnlargeEdge.h"
#import "OrderPraiseViewController.h"
#import "RewardSelectViewController.h"
#import "VolumePlayHelper.h"

#import "UIButton+EnlargeEdge.h"
/**
 * 用于显示Detail的类型
 */

typedef NS_ENUM(NSInteger,OrderDetailShowType)
{
    OrderDetailShowTypeOrderInfo,
    OrderDetailShowTypeOrderMark,
    OrderDetailShowTypeOrderCancel,
    OrderDetailShowTypeAppriseOrder,
    OrderDetailShowTypeOrderCustomInfo,
    OrderDetailShowTypeOrderCallRecord,
    
};



@interface OrderDetailCellModel : NSObject

@property (nonatomic,assign) OrderDetailShowType showType;

@property (nonatomic,strong) CallHistoriesModel *callModel;

@end

@implementation OrderDetailCellModel


@end


@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BarristerOrderDetailModel *model;
}

@property (nonatomic,strong) UITableView *orderTableView;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,strong) OrderProxy *proxy;

@property (nonatomic,strong) UIView *rewardView;
@property (nonatomic,strong) NSString *moneny;

@property (nonatomic,strong) RewardSelectViewController *rewardSelectVC;

@end

@implementation OrderDetailViewController

-(id)initWithModel:(BarristerOrderModel *)orderModel
{
    if (self  =[super init]) {
        self.orderId = orderModel.orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [XuUItlity showLoadingInView:self.view hintText:@"加载中..."];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
    [self initData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[VolumePlayHelper PlayerHelper] audioPlayerStop];
}

#pragma -mark ---------UI----------

-(void)configView
{
    self.title = @"订单详情";
    
    [self.view addSubview:self.orderTableView];
}

#pragma -mark -------Data----------

-(void)initData
{
    self.items = [NSMutableArray arrayWithCapacity:1];
    
    NSMutableDictionary *aParams = [NSMutableDictionary dictionary];
    if (self.orderId) {
        [aParams setObject:self.orderId forKey:@"orderId"];
    }
    else
    {
        //没有订单id 进入详情
        [XuUItlity showFailedHint:@"数据异常" completionBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return;
    }
    [aParams setObject:[BaseDataSingleton shareInstance].userModel.userId forKey:@"userId"];
    [aParams setObject:[BaseDataSingleton shareInstance].userModel.verifyCode forKey:@"verifyCode"];
    
    __weak typeof(*&self) weakSelf = self;
    [self.proxy getOrderDetailWithParams:aParams Block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            model = [[BarristerOrderDetailModel alloc] initWithDictionary:dict];
            
            [weakSelf configData];
        }
        else
        {
            [XuUItlity showFailedHint:@"加载失败" completionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];

    
}

-(void)configData
{
    OrderDetailCellModel *model1 = [[OrderDetailCellModel alloc] init];
    model1.showType = OrderDetailShowTypeOrderInfo;
    [self.items addObject:model1];
    
    OrderDetailCellModel *model2 = [[OrderDetailCellModel alloc] init];
    model2.showType = OrderDetailShowTypeOrderMark;
    [self.items addObject:model2];

    if ([model.status isEqualToString:STATUS_WAITING]) {
        OrderDetailCellModel *model3 = [[OrderDetailCellModel alloc] init];
        model3.showType = OrderDetailShowTypeOrderCancel;
        [self.items addObject:model3];
   
    }
    
    if ([model.status isEqualToString:STATUS_DONE] && [model.isStart isEqualToString:ISSTAR_NO]) {
        OrderDetailCellModel *model4 = [[OrderDetailCellModel alloc] init];
        model4.showType = OrderDetailShowTypeAppriseOrder;
        [self.items addObject:model4];

    }

    
    OrderDetailCellModel *model5 = [[OrderDetailCellModel alloc] init];
    model5.showType = OrderDetailShowTypeOrderCustomInfo;
    [self.items addObject:model5];
    
    if ([XuUtlity isValidArray:model.callRecordArray]) {
        if (model.callRecordArray.count > 0) {
            
            for (int i = 0; i < model.callRecordArray.count; i ++) {
                
                CallHistoriesModel *modelTemp = [model.callRecordArray objectAtIndex:i];
                modelTemp.index = i;
                OrderDetailCellModel *model6 = [[OrderDetailCellModel alloc] init];
                model6.showType = OrderDetailShowTypeOrderCallRecord;
                model6.callModel = modelTemp;
                [self.items addObject:model6];

            }
            
        }
        
    }
    
    if ([model.status isEqualToString:STATUS_DONE]) {
        self.orderTableView.tableFooterView = self.rewardView;
    }
    
    [self.orderTableView reloadData];

}

/**
 *  拨打电话
 *
 *  @param btn
 */
-(void)callAction:(UIButton *)btn
{
    NSDate *startDate = [XuUtlity NSStringDateToNSDate:model.startTime forDateFormatterStyle:DateFormatterDateAndTime];
    double startNum = [startDate timeIntervalSince1970];
    
    double nowNum = [[NSDate date] timeIntervalSince1970];
    if (nowNum > startNum) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.orderId,@"orderId", nil];
        [self.proxy makeCallWithParams:params Block:^(id returnData, BOOL success) {
            if (success) {
                [XuUItlity showAlertHint:@"已拨通 等待回拨" completionBlock:nil andView:self.view];
            }
            else
            {
                [XuUItlity showFailedHint:@"拨打失败" completionBlock:nil];
            }
            
        }];
        
    }
    else
    {
        [XuUItlity showFailedHint:@"不在约定时间内" completionBlock:nil];
    }
    
}

/**
 *  申请取消订单
 *
 *  @param sender
 */
-(void)cancelOrderAciton:(id)sender
{
    __weak typeof(*&self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:model.orderId forKey:@"orderId"];
    [self.proxy applyToCancelOrderWithParams:params Block:^(id returnData, BOOL success) {
        if (success) {
            [XuUItlity showSucceedHint:@"申请成功" completionBlock:nil];
            [weakSelf initData];
        }
        else
        {
            [XuUItlity showFailedHint:@"申请失败" completionBlock:nil];
        }
    }];
}


-(void)rewardAciton
{
    
    [self.view addSubview:self.rewardSelectVC.view];
    [self.rewardSelectVC show];
    
}


/**
 *  评价订单
 */
-(void)appriseOrderAction
{
    OrderPraiseViewController *praiseVC = [[OrderPraiseViewController alloc] init];
    [self.navigationController pushViewController:praiseVC animated:YES];
    
}


#pragma -mark --------UITableView DataSource Methods------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(*&self) weakSelf = self;
    OrderDetailCellModel *modeTemp = (OrderDetailCellModel *)[self.items objectAtIndex:indexPath.row];
    switch (modeTemp.showType) {
        case 0:
        {
           OrderDetailOrderCell * cellTemp = [[OrderDetailOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.model = model;
            return cellTemp;
        }
            break;
            case 1:
        {
            OrderDetailMarkCell * cellTemp = [[OrderDetailMarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.model = model;
            return cellTemp;
        }
            break;
        case 2:
        {
            OrderDetailCancelCell *cellTemp = [[OrderDetailCancelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.block = ^(NSString *btnType)
            {
                [weakSelf cancelOrderAciton:nil];
            };
            cellTemp.model = model;
            return cellTemp;
        }
            break;
        case 3:
        {
            AppriseOrderCell *cellTemp = [[AppriseOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.block  =^()
            {
                [weakSelf appriseOrderAction];
            };
            cellTemp.model = model;
            return cellTemp;
            
        }
            break;
        case 4:
        {
            OrderDetailCustomInfoCell * cellTemp = [[OrderDetailCustomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cellTemp.callButton addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
            cellTemp.model = model;
            return cellTemp;

        }
            break;
            case 5:
        {
            OrderDetailCallRecordCell *cellTemp = [[OrderDetailCallRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.model = modeTemp.callModel;
            return cellTemp;
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
    OrderDetailCellModel *modelTemp = (OrderDetailCellModel *)[self.items objectAtIndex:indexPath.row];
    switch (modelTemp.showType) {
        case OrderDetailShowTypeOrderInfo:
        {
            return [OrderDetailOrderCell getHeightWithModel:model];
        }
            break;
        case OrderDetailShowTypeOrderMark:
        {
            return [OrderDetailMarkCell getCellHeightWithModel:model];
        }
            break;
        case OrderDetailShowTypeOrderCancel:
        {
            if ([model.status isEqualToString:STATUS_WAITING]) {
                return [OrderDetailCancelCell getCellHeight];
            }
            else
            {
                return 0;
            }
        }
            break;
        case OrderDetailShowTypeAppriseOrder:
        {
            if ([model.status isEqualToString:STATUS_DONE]) {
                return [AppriseOrderCell getCellHeight];
            }
            else
            {
                return 0;
            }
        }
            break;
        case OrderDetailShowTypeOrderCustomInfo:
        {
            return [OrderDetailCustomInfoCell getHeightWithModel:model];
        }
        case OrderDetailShowTypeOrderCallRecord:
        {
            if (model.callRecordArray.count > 0) {
                return [OrderDetailCallRecordCell getHeightWithModel:modelTemp.callModel];
            }
            else
            {
                return 0;
            }
        }
            
        default:
        {
            return 0;
        }
            break;
    }}

#pragma -mark ----Getter----

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

-(UIView *)rewardView
{
    if (!_rewardView) {
        _rewardView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, 50)];
        UIButton *rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rewardBtn setTitle:@"打赏" forState:UIControlStateNormal];
        [rewardBtn setEnlargeEdge:10];
        [rewardBtn setImage:[UIImage imageNamed:@"dashang"] forState:UIControlStateNormal];
        [rewardBtn setTitleEdgeInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
        [rewardBtn setFrame:RECT((SCREENWIDTH - 30)/2.0, 10, 30, 30)];
        [rewardBtn addTarget:self action:@selector(rewardAciton) forControlEvents:UIControlEventTouchUpInside];
        [_rewardView addSubview:rewardBtn];
    }
    return _rewardView;
}

-(RewardSelectViewController *)rewardSelectVC
{
    if (!_rewardSelectVC) {
        _rewardSelectVC = [[RewardSelectViewController alloc] init];
        _rewardSelectVC.detailModel = model;
    }
    return _rewardSelectVC;
}

@end
