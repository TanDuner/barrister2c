//
//  FindViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/15.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "FindViewController.h"
#import "FindNetProxy.h"
#import "UIButton+EnlargeEdge.h"
#define ImageWidth 28

#define LawButtonWidth 38
#define LawLeftPadding 17.5
#define LawTopPadding 17.5 + 45
#define LawHorSpacing (SCREENWIDTH - LawLeftPadding *2 - LawButtonWidth *4)/3
#define LawVerSpacing (SCREENHEIGHT/640.0) *45
#define LawNumOfLine 4

@interface ZXItemView : UIView

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subtitleLabel;
@property (nonatomic,strong) UIButton *clickButton;
@end

@implementation ZXItemView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subtitleLabel];
        [self addSubview:self.clickButton];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.clickButton setFrame:self.bounds];
    
}

-(void)clickAciton:(UIButton *)button
{
    NSLog(@"xxx");
}

#pragma -mark ---Getter-------

-(UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:RECT(15, 25, ImageWidth, ImageWidth)];
    }
    return _leftImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:RECT(self.leftImageView.x + self.leftImageView.width + 10, self.leftImageView.y, 100 , 15)];
        _titleLabel.font = SystemFont(16.0);
        _titleLabel.textColor = RGBCOLOR(198, 122, 116);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}


-(UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] initWithFrame:RECT(self.titleLabel.x, self.titleLabel.y + self.titleLabel.height + 6, 120, 10)];
        _subtitleLabel.font = SystemFont(13.0f);
        _subtitleLabel.textColor = RGBCOLOR(150, 151, 152);
        _subtitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _subtitleLabel;
}

-(UIButton *)clickButton
{
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clickButton addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButton;
}



@end



@interface FindViewController ()

@property (nonatomic,strong) UIView *topSelectView;
@property (nonatomic,strong) UIView *bottomCategoryView;

@property (nonatomic,strong) ZXItemView *LeftItem;
@property (nonatomic,strong) ZXItemView *rightItem;

@property (nonatomic,strong) FindNetProxy *proxy;
@end

@implementation FindViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self configView];
    
    [self configData];
}


#pragma -mark --UI--
-(void)configView
{
    [self configTopView];
    [self configBottomView];

}

-(void)configTopView
{
    [self.view addSubview:self.topSelectView];
}

-(void)configBottomView
{
    [self.view addSubview:self.bottomCategoryView];
}


#pragma -mark --Data---

-(void)configData
{
    NSArray *array = @[@"中国法律",@"中国法规",@"地方法规",@"司法解释",@"实用案例",@"国际条约",@"合同范本",@"法律文书",@"百姓法律",@"英文法律",@"法律考试",@"WTO/白皮书"];
    
    [self.bottomCategoryView setFrame:RECT(0, 78 + 10, SCREENWIDTH, ceil(array.count/4) * (LawTopPadding + LawButtonWidth))];
    
    for (int i = 0; i < array.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = LawButtonWidth/2.0f;
        button.layer.masksToBounds = YES;
        [button setEnlargeEdge:8];
        button.tag = i;
        button.titleEdgeInsets = UIEdgeInsetsMake(60, 0, 0, 0);
        button.titleLabel.font = SystemFont(10.0f);
        [button addTarget:self action:@selector(clickLawBooksAciton:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:RECT(LawLeftPadding + (LawButtonWidth + LawHorSpacing) *(i%LawNumOfLine), LawTopPadding + (LawButtonWidth + LawVerSpacing)*(i/LawNumOfLine), LawButtonWidth, LawButtonWidth)];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(button.x - 10, button.y + button.height + 15, LawButtonWidth + 20, 12)];
        tipLabel.textColor = KColorGray666;
        tipLabel.font = SystemFont(12.0f);
        tipLabel.text = array[i];
        
        [self.bottomCategoryView addSubview:button];
        [self.bottomCategoryView addSubview:tipLabel];
    }
    
    [self.proxy getLawBooksWithParams:nil WithBlock:^(id returnData, BOOL success) {
        if (success) {
        
        }
        else
        {
        
        }
    }];
}

#pragma -mark --Aciton----

-(void)clickLawBooksAciton:(UIButton *)btn
{
    
}

#pragma -mark ----Getter-------

#define ItemWidth (SCREENWIDTH - 1)/2.0
#define ItemHeight 78

-(FindNetProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[FindNetProxy alloc] init];
    }
    return _proxy;
}

-(UIView *)topSelectView
{
    if (!_topSelectView) {
        _topSelectView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, ItemHeight + 10)];
        _LeftItem = [[ZXItemView alloc] initWithFrame:RECT(0, 0, ItemWidth, ItemHeight)];
        _LeftItem.leftImageView.image = [UIImage imageNamed:@"common_icon_succeed"];
        _LeftItem.titleLabel.text = @"即时咨询";
        _LeftItem.subtitleLabel.text = @"立即与律师沟通";
        
        UIView *sepView = [[UIView alloc] initWithFrame:RECT(ItemWidth, 0, 1, ItemHeight)];
        sepView.backgroundColor = RGBCOLOR(204, 205, 206);
        
        
        _rightItem = [[ZXItemView alloc] initWithFrame:RECT(ItemWidth + 1, 0, ItemWidth, ItemHeight)];
        _rightItem.leftImageView.image = [UIImage imageNamed:@"common_icon_succeed"];
        _rightItem.titleLabel.text = @"预约咨询";
        _rightItem.subtitleLabel.text = @"约定时间与律师沟通";

        
        UIView *horSpeView = [[UIView alloc] initWithFrame:RECT(0, ItemHeight, SCREENWIDTH, 10)];
        horSpeView.backgroundColor = RGBCOLOR(239, 239, 246);
        
        [_topSelectView addSubview:_LeftItem];
        [_topSelectView addSubview:sepView];
        [_topSelectView addSubview:_rightItem];
        [_topSelectView addSubview:horSpeView];
        
        _topSelectView.backgroundColor =[UIColor whiteColor];
    }
    
    return _topSelectView;
}


-(UIView *)bottomCategoryView
{
    if (!_bottomCategoryView) {
        _bottomCategoryView = [[UIView alloc] initWithFrame:RECT(0, ItemHeight + 10, SCREENWIDTH, 1000)];
        _bottomCategoryView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 15, 200, 15)];
        tipLabel.textColor = KColorGray222;
        tipLabel.font = SystemFont(16.0);
        tipLabel.text = @"中国法律应用大全";
        
        [_bottomCategoryView addSubview:tipLabel];
        
        
        UIView *horSpeView = [[UIView alloc] initWithFrame:RECT(0, 45, SCREENWIDTH, 1)];
        horSpeView.backgroundColor = RGBCOLOR(239, 239, 246);
        
        [_bottomCategoryView addSubview:horSpeView];

    }
    return _bottomCategoryView;

}

@end
