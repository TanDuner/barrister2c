//
//  ModifyInfoViewController.h
//  barrister
//
//  Created by 徐书传 on 16/6/8.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonCenterModel.h"

typedef void(^ModifyInfoBlock)(PersonCenterModel *model);


@interface ModifyInfoViewController : BaseViewController

-(id)initWithModel:(PersonCenterModel *)model;

@property (nonatomic,copy) ModifyInfoBlock modifyBlock;

@end
