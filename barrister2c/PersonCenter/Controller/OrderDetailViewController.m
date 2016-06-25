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
/**
 * 用于显示Detail的类型
 */

typedef NS_ENUM(NSInteger,OrderDetailShowType)
{
    OrderDetailShowTypeOrderInfo,
    OrderDetailShowTypeOrderCustomInfo,
    OrderDetailShowTypeOrderCallRecord,
    OrderDetailShowTypeOrderMark
};



@interface OrderDetailCellModel : NSObject

@property (nonatomic,assign) OrderDetailShowType showType;

@end

@implementation OrderDetailCellModel


@end






@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BarristerOrderModel *model;
}

@property (nonatomic,strong) UITableView *orderTableView;
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation OrderDetailViewController

-(id)initWithModel:(BarristerOrderModel *)orderModel
{
    if (self  =[super init]) {
        model = orderModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self initData];
    [self configData];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
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
}

-(void)configData
{
    OrderDetailCellModel *model1 = [[OrderDetailCellModel alloc] init];
    model1.showType = OrderDetailShowTypeOrderInfo;
    [self.items addObject:model1];
    
    OrderDetailCellModel *model2 = [[OrderDetailCellModel alloc] init];
    model2.showType = OrderDetailShowTypeOrderCustomInfo;
    [self.items addObject:model2];
    
    OrderDetailCellModel *model3 = [[OrderDetailCellModel alloc] init];
    model3.showType = OrderDetailShowTypeOrderCallRecord;
    [self.items addObject:model3];
    
    if (model.markStr.length > 0) {
        OrderDetailCellModel *model4 = [[OrderDetailCellModel alloc] init];
        model4.showType = OrderDetailShowTypeOrderMark;
        [self.items addObject:model4];
    }
    
    
    [self.orderTableView reloadData];

    
    
}

#pragma -mark --------UITableView DataSource Methods------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (model.markStr.length > 0) {
        return 4;
    }
    else
    {
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            OrderDetailCustomInfoCell * cellTemp = [[OrderDetailCustomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.model = model;
            return cellTemp;

        }
            break;
        case 2:
        {
            OrderDetailCallRecordCell *cellTemp = [[OrderDetailCallRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cellTemp.model = model;
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
        case OrderDetailShowTypeOrderCustomInfo:
        {
            return [OrderDetailCustomInfoCell getHeightWithModel:model];
        }
        case OrderDetailShowTypeOrderCallRecord:
        {
            return [OrderDetailCallRecordCell getHeightWithModel:model];
        }
            
        default:
        {
            return 0;
        }
            break;
    }
}

#pragma -mark ----Getter----

-(UITableView *)orderTableView
{
    if (!_orderTableView) {
        _orderTableView  =[[UITableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
        _orderTableView.delegate  = self;
        _orderTableView.dataSource  = self;
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.tableFooterView = [UIView new];
    }
    return _orderTableView;
}

@end
