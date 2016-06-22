//
//  HomeTypeCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "HomeTypeCell.h"
#import "UIButton+EnlargeEdge.h"
#import "UIImage+Additions.h"

#define ButtonWidth (SCREENWIDTH - 1)/2.0
#define ButtonHeight 49




@interface HomeTypeCellItemView : UIView

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIButton *clickButton;
@end

@implementation HomeTypeCellItemView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.button];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.clickButton setFrame:RECT(0, 0, self.width, self.height)];
}

#pragma -narj -Getter--
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:RECT(10, (49 - 12) / 2.0, (SCREENWIDTH - 1)/2.0 - 10, 12)];
        _titleLabel.textColor = KColorGray333;
        _titleLabel.font = SystemFont(15.0f);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:RECT((SCREENWIDTH - 1)/2.0 - 15 - 35, (49 - 35)/2.0, 35, 35)];
    }
    return _button;
}

-(UIButton *)clickButton
{
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _clickButton;
}
@end



@interface HomeTypeCell ()

@property (nonatomic,strong) UIImageView *flagImageView;
@property (nonatomic,strong) UILabel *tipLabel;

@property (nonatomic,strong) UIView *verLineView;

@end

@implementation HomeTypeCell

+(CGFloat)getCellHeightWithArray:(NSMutableArray *)array
{
    int x = ceil(array.count / 2.0);
    
    CGFloat height =  x  * 50 + 45;
    
    return height;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.flagImageView];
        
        [self addSubview:self.tipLabel];
        
        [self addSubview:[self getLineViewWithRect:RECT(0, 45, SCREENWIDTH, .5)]];
        
        
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

-(void)createTypeDatas
{
    for (int i = 0; i< self.items.count; i ++) {
        BussinessTypeModel *model = [self.items objectAtIndex:i];
        
        HomeTypeCellItemView *itemView  = [[HomeTypeCellItemView alloc] init];
        
        [itemView setFrame:RECT((i%2) *ButtonWidth, (i/2) *(ButtonHeight + .5) + 45, ButtonWidth, ButtonHeight)];
        
        
        itemView.titleLabel.text  = model.title;
        
        [itemView.button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
//        itemView.backgroundColor = [UIColor whiteColor];
        
        itemView.button.backgroundColor = [UIColor redColor];
        
        [itemView.button addTarget:self action:@selector(buttonClickAction) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:itemView];
        
        if (i %2 == 0) {
            [self addSubview:[self getLineViewWithRect:RECT(0, itemView.height + itemView.y + .5, SCREENWIDTH, .5)]];
        }
        
    }
    
    [self addSubview:[self getLineViewWithRect:RECT(ButtonWidth, 45, .5, [HomeTypeCell getCellHeightWithArray:self.items] - 45)]];

    

}

-(void)buttonClickAction
{
    

}



#pragma -mark --Getter---

-(UIImageView *)flagImageView
{
    if (!_flagImageView) {
        _flagImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, 10, 25, 25)];
        _flagImageView.backgroundColor = [UIColor redColor];
    }
    return _flagImageView;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding + _flagImageView.width + 7, (45 - 15)/2.0, 200, 15)];
        _tipLabel.text = @"业务类型";
        _tipLabel.font = SystemFont(14.0f);
        _tipLabel.textColor = RGBCOLOR(27, 161, 232);
        _tipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return  _tipLabel;
}

-(UIView *)verLineView
{
    if (!_verLineView) {
        _verLineView = [self getLineViewWithRect:RECT((SCREENWIDTH - .5)/2.0, 45, .5, 0)];
    }
    return _verLineView;
}

@end
