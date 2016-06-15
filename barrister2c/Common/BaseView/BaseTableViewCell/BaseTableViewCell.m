//
//  BaseTableViewCell.m
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [self.selectedBackgroundView setBackgroundColor:[UIColor colorWithHexString:@"#eaebeb"]];
    }
    
    return self;
}

/**
 *  数据配置
 */
-(void)configData
{
    
}

/**
 *  布局配置
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    [self configData];
}

-(UIView *)getLineViewWithRect:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = kSeparatorColor;
    return view;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
