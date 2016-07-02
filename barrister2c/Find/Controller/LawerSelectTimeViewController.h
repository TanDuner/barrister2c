//
//  LawerSelectTimeViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "BarristerLawerModel.h"


@protocol FinishAppoinmentDelegate  <NSObject>

//  参数：userId,verifyCode, money 金额, appointmentDate 预约时间（参考律师端预约设置）,barristerId 律师id, orderContent  订单描述, caseType 案例类型

-(void)didFinishChooseAppoinmentWithMoneny:(NSString *)totalPrice
                                  PerPrice:(NSString *)price
                           appointmentDateArray:(NSMutableArray *)appointmentArray
                              Ordercontent:(NSString *)orderContent;

@end


@interface LawerSelectTimeViewController : BaseViewController


@property (nonatomic,weak) id <FinishAppoinmentDelegate> delegate;

@property (nonatomic,strong) BarristerLawerModel *lawerModel;


-(void)showWithType:(NSString *)type;


-(void)dismiss;




@end
