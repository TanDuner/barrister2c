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

#import "YYWebImage.h"
#import "UIImage+Additions.h"

#define ButtonWidth (SCREENWIDTH - 1)/2.0
#define ButtonHeight 49




@interface HomeTypeCellItemView : UIView

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIButton *clickButton;
@end

@implementation HomeTypeCellItemView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightImageView];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.clickButton];
        self.userInteractionEnabled = YES;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
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

-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.userInteractionEnabled = YES;
        [_rightImageView setFrame:RECT((SCREENWIDTH - 1)/2.0 - 15 - 35, (49 - 35)/2.0, 35, 35)];
    }
    return _rightImageView;
}

-(UIButton *)clickButton
{
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clickButton setFrame:RECT(0, 0, ButtonWidth, ButtonHeight)];
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
        
        [self addSubview:[self getLineViewWithRect:RECT(0, 44.5, SCREENWIDTH, .5)]];

        
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
        
        HomeTypeCellItemView *itemView  = [[HomeTypeCellItemView alloc] initWithFrame:RECT((i%2) *ButtonWidth, (i/2) *(ButtonHeight + .5) + 46.5, ButtonWidth, ButtonHeight - .5)];
        

        itemView.titleLabel.text  = model.desc;
        
        
        itemView.rightImageView.backgroundColor = [UIColor whiteColor];
        itemView.rightImageView.tag = i;
        [itemView.rightImageView yy_setImageWithURL:[NSURL URLWithString:model.icon] placeholder:[UIImage createImageWithColor:KColorGray333]];
        [itemView.clickButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:itemView];
        
        if (i %2 == 0) {
            [self addSubview:[self getLineViewWithRect:RECT(0, CGRectGetMaxY(itemView.frame) + .5, SCREENWIDTH, .5)]];
        }
        
    }
    
    [self addSubview:[self getLineViewWithRect:RECT(ButtonWidth, 45, .5, [HomeTypeCell getCellHeightWithArray:self.items] - 45)]];
    
}



-(void)buttonClickAction:(UIButton *)button
{
    if (self.block) {
        self.block(button.tag);
    }

}



#pragma -mark --Getter---

-(UIImageView *)flagImageView
{
    if (!_flagImageView) {
        _flagImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, 10, 25, 25)];
        _flagImageView.image = [UIImage imageNamed:@"typeFlag"];
    }
    return _flagImageView;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding + _flagImageView.width + 7, (45 - 15)/2.0, 200, 15)];
        _tipLabel.text = @"线上专项服务";
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
