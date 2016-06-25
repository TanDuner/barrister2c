//
//  LawerSelectTimeViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SelectTimeFinish)(id object);

@interface LawerSelectTimeViewController : BaseViewController

@property (nonatomic,copy) SelectTimeFinish selectTImeFinishBlock;


-(void)show;


-(void)dismiss;




@end
