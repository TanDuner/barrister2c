//
//  OrderDetailViewController.h
//  barrister
//
//  Created by 徐书传 on 16/4/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "CallHistoriesModel.h"

/**
 * 用于显示Detail的类型
 */

typedef NS_ENUM(NSInteger,OrderDetailShowType)
{
    OrderDetailShowTypeOrderInfo,
    OrderDetailShowTypeOrderMark,
    OrderDetailShowTypeOrderReward,
    OrderDetailShowTypeOrderCancel,
    OrderDetailShowTypeAppriseOrder,
    OrderDetailShowTypeOrderCustomInfo,
    OrderDetailShowTypeOrderCallRecord,
    OrderDetailShowTypeOnlineWaitPay,
    OrderDetailShowTypeOnlineQQ,
    OrderDetailShowTypeOnlinePhone,
};



@interface OrderDetailCellModel : NSObject

@property (nonatomic,assign) OrderDetailShowType showType;

@property (nonatomic,strong) CallHistoriesModel *callModel;

@end


@interface OrderDetailViewController : BaseViewController

-(id)initWithOrderId:(NSString *)orderId;

@end
