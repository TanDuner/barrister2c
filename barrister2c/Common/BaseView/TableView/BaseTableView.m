//
//  BaseTableView.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableView.h"


@implementation BaseTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initBaseProprety];
        
    }
    return self;
}

-(void)initBaseProprety
{
    self.separatorStyle  = UITableViewCellSeparatorStyleNone;
}





@end
