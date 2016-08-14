//
//  OrderDetialRewardCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/14.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderDetialRewardCell.h"

@implementation OrderDetialRewardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *leftImage = [[UIImageView alloc] initWithFrame:RECT(10, 10, 30, 30)];
        leftImage.image = [UIImage imageNamed:@"dashang"];
        [self addSubview:leftImage];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:RECT(50, 10, 200, 12)];
        titleLabel.text = @"打赏律师";
        titleLabel.textColor = KColorGray333;
        titleLabel.font = SystemFont(14.0f);
        [self addSubview:titleLabel];
        
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:RECT(50, 25, 250, 12)];
        subTitleLabel.text = @"如果您对此五福比较满意可以打赏律师";
        subTitleLabel.textColor = KColorGray666;
        subTitleLabel.font = SystemFont(12.0f);
        [self addSubview:subTitleLabel];
        
    }
    return self;

}

@end
