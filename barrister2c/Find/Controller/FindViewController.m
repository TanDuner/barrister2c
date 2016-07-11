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
#import "LawerListViewController.h"
#import "BaseWebViewController.h"
#import "FindNetProxy.h"
#import "LawBooksModel.h"
#import "YYWebImage.h"
#import "UIImage+Additions.h"
#import "BarristerLoginManager.h"
#define ImageWidth 28

#define LawButtonWidth 50
#define LawLeftPadding 17.5
#define LawTopPadding 17.5 + 45
#define LawHorSpacing (SCREENWIDTH - LawLeftPadding *2 - LawButtonWidth *4)/3
#define LawVerSpacing (SCREENHEIGHT/640.0) *45
#define LawNumOfLine 4

@class ZXItemView;
typedef void(^ClickZXItemBlock)(ZXItemView *itemView);

@interface ZXItemView : UIView

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subtitleLabel;
@property (nonatomic,strong) UIButton *clickButton;
@property (nonatomic,copy) ClickZXItemBlock block;

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
    if (self.block) {
        self.block(self);
    }
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

@property (nonatomic,strong) NSMutableArray *urlArray;

@property (nonatomic,strong) NSMutableArray *titleArray;

@end

@implementation FindViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self configView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:YES];
    if (self.titleArray.count == 0) {
        [self configData];
    }
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
    __weak typeof(*&self)weakSelf = self;
    [self.proxy getLawBooksWithParams:nil WithBlock:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *array = [dict objectForKey:@"legalList"];
            if ([XuUtlity isValidArray:array]) {
                [weakSelf handleLawBookListDataWithArray:array];
            }
            else
            {
                [weakSelf handleLawBookListDataWithArray:@[]];
            }
        }
        else
        {
            [XuUItlity showFailedHint:@"加载应用大全失败" completionBlock:nil];
        }
    }];
    

    
    
  
}

-(void)handleLawBookListDataWithArray:(NSArray *)array
{
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = [array  safeObjectAtIndex:i];
        LawBooksModel *model = [[LawBooksModel alloc] initWithDictionary:dict];
        [self.titleArray addObject:model.name];
        [self.urlArray addObject:model.url];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = LawButtonWidth/2.0f;
        button.layer.masksToBounds = YES;
        [button setEnlargeEdge:8];
        button.tag = i;
        button.titleEdgeInsets = UIEdgeInsetsMake(60, 0, 0, 0);
        button.titleLabel.font = SystemFont(10.0f);
        [button addTarget:self action:@selector(clickLawBooksAciton:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:RECT(LawLeftPadding + (LawButtonWidth + LawHorSpacing) *(i%LawNumOfLine), LawTopPadding + (LawButtonWidth + LawVerSpacing)*(i/LawNumOfLine), LawButtonWidth, LawButtonWidth)];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(button.x - 10, button.y + button.height + 15, LawButtonWidth + 20, 12)];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.textColor = KColorGray666;
        tipLabel.font = SystemFont(12.0f);
        tipLabel.text = self.titleArray[i];
        
        [self.bottomCategoryView addSubview:tipLabel];
        
        UIImageView *imageVIew = [[UIImageView alloc] initWithFrame:button.frame];
        [imageVIew yy_setImageWithURL:[NSURL URLWithString:model.icon] placeholder:[UIImage createImageWithColor:[UIColor lightGrayColor]]];
        imageVIew.userInteractionEnabled = YES;
        
        [self.bottomCategoryView addSubview:imageVIew];
        [self.bottomCategoryView addSubview:button];


    }
    
    
    [self.bottomCategoryView setFrame:RECT(0, 78 + 10, SCREENWIDTH, ceil(array.count/4) * (LawTopPadding + LawButtonWidth))];


}


#pragma -mark --Aciton----

-(void)clickLawBooksAciton:(UIButton *)btn
{
    //没登录让登录
    if (![[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
        [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
        return;
    }
    if (self.titleArray.count != self.urlArray.count) {
        return;
    }
    
    
    if (self.urlArray.count > btn.tag) {
        NSString *url = [self.urlArray safeObjectAtIndex:btn.tag];
        BaseWebViewController *webView = [[BaseWebViewController alloc] init];
        webView.url = url;
        webView.showTitle = self.titleArray[btn.tag];
        [self.navigationController pushViewController:webView animated:YES];
    }
  

}

#pragma -mark ----Getter-------

-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _titleArray;
}

//@[@"http://sjtj.flgw.com.cn/zgfl/default.asp",@"http://sjtj.flgw.com.cn/zgfg/default.asp",@"http://sjtj.flgw.com.cn/dffg/default.asp",@"http://sjtj.flgw.com.cn/sfjs/default.asp",@"http://sjtj.flgw.com.cn/flks/default.asp",@"http://sjtj.flgw.com.cn/syal/default.asp",@"http://sjtj.flgw.com.cn/htfb/default.asp",@"http://sjtj.flgw.com.cn/flws/default.asp",@"http://sjtj.flgw.com.cn/gjty/default.asp",@"http://sjtj.flgw.com.cn/bxfl/default.asp",@"http://sjtj.flgw.com.cn/wto/default.asp",@"http://sjtj.flgw.com.cn/ywfl/default.asp"]

-(NSMutableArray *)urlArray
{
    if (!_urlArray) {
        _urlArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _urlArray;
}

#define ItemWidth (SCREENWIDTH - 1)/2.0
#define ItemHeight 78

-(UIView *)topSelectView
{
    if (!_topSelectView) {
        _topSelectView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, ItemHeight + 10)];
        _LeftItem = [[ZXItemView alloc] initWithFrame:RECT(0, 0, ItemWidth, ItemHeight)];
        _LeftItem.leftImageView.image = [UIImage imageNamed:@"JSZX"];
        _LeftItem.titleLabel.text = @"即时咨询";
        _LeftItem.subtitleLabel.text = @"立即与律师沟通";
        __weak typeof(*&self) weakSelf = self;
        _LeftItem.block = ^(ZXItemView *itemView)
        {
            [weakSelf toLawerList];
        };
        
        UIView *sepView = [[UIView alloc] initWithFrame:RECT(ItemWidth, 0, 1, ItemHeight)];
        sepView.backgroundColor = RGBCOLOR(204, 205, 206);
        
        
        _rightItem = [[ZXItemView alloc] initWithFrame:RECT(ItemWidth + 1, 0, ItemWidth, ItemHeight)];
        _rightItem.leftImageView.image = [UIImage imageNamed:@"YYZX"];
        _rightItem.titleLabel.text = @"预约咨询";
        _rightItem.subtitleLabel.text = @"约定时间与律师沟通";
        _rightItem.block = ^(ZXItemView *itemView)
        {
            [weakSelf toLawerList];
        };
        
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


-(FindNetProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[FindNetProxy alloc] init];
    }
    return _proxy;
}

-(void)toLawerList
{
    LawerListViewController *lawerListVC = [[LawerListViewController alloc] init];
    [self.navigationController pushViewController:lawerListVC animated:YES];
}




@end
