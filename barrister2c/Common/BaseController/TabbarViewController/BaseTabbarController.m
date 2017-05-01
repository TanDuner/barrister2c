//
//  BaseTabbarController.m
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTabbarController.h"
#import "HomeViewController.h"
#import "FindViewController.h"
#import "LearnCenterViewController.h"
#import "PersonCenterViewController.h"
#import "BaseNavigaitonController.h"
#import "ZhaiLiFangViewController.h"
#import "ZhaiLiFangNewViewController.h"

#define     ImageWidth        25


#define ItemWidth SCREENWIDTH/5.0

@interface BaseTabbarController ()


@property (nonatomic,strong) NSMutableArray * tabBarImageNames;
@property (nonatomic,strong) NSMutableArray * tabBarSelectedImageNames;
@property (nonatomic,strong) NSMutableArray * tabBarTitleNames;

- (void)loadViewControllers;
- (void)loadCustomTabBarView;

@end

@implementation BaseTabbarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //隐藏系统TabBar
        self.tabBar.hidden = YES;
        self.newsMsgLabelArray = [NSMutableArray arrayWithCapacity:10];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetViewFrame:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetViewFrame:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //加载视图控制器
    [self loadViewControllers];
    
    //加载自定义TabBar
    [self loadCustomTabBarView];
}


-(void)resetViewFrame:(NSNotification *)nsnotifi
{
    if (STATUSBAR_HIGHT == 20) {
        self.tabBarBG.frame = CGRectMake(0, SCREENHEIGHT-TABBAR_HEIGHT, SCREENWIDTH, TABBAR_HEIGHT);
    }
    else
    {
        self.tabBarBG.frame = CGRectMake(0, SCREENHEIGHT-TABBAR_HEIGHT - 20, SCREENWIDTH, TABBAR_HEIGHT);
    }

}

#pragma mark-
#pragma mark-加载
- (void)loadViewControllers
{
    
    self.titleArray = [NSMutableArray arrayWithObjects:@"首页",@"数据中心",@"债立方",@"学习中心",@"个人中心", nil];
    
    
    self.btnArray = [NSMutableArray arrayWithCapacity:10];
    
    
    HomeViewController *c1 = [[HomeViewController alloc] init];
    c1.title = [self.titleArray safeObjectAtIndex:0];
    BaseNavigaitonController *ctl1 = [[BaseNavigaitonController alloc] initWithRootViewController:c1];
    
    
    
    FindViewController *c2 = [[FindViewController alloc] init];
    c2.title = [self.titleArray safeObjectAtIndex:1];
    BaseNavigaitonController *ctl2 = [[BaseNavigaitonController alloc] initWithRootViewController:c2];
    
    
    ZhaiLiFangNewViewController *c5 = [[ZhaiLiFangNewViewController alloc] init];
    c5.title = @"债立方";
    BaseNavigaitonController *ctl5 = [[BaseNavigaitonController alloc] initWithRootViewController:c5];
    
    
    LearnCenterViewController *c3 = [[LearnCenterViewController alloc] init];
    c3.title = [self.titleArray safeObjectAtIndex:2];
    BaseNavigaitonController *ctl3 = [[BaseNavigaitonController alloc] initWithRootViewController:c3];
    
    PersonCenterViewController *c4 = [[PersonCenterViewController alloc] init];
    c4.title = [self.titleArray safeObjectAtIndex:3];
    BaseNavigaitonController *ctl4 = [[BaseNavigaitonController alloc] initWithRootViewController:c4];
    
    
    
    
    // 将视图控制器添加至数组中
    NSArray *viewControllers = @[ctl1,ctl2,ctl5,ctl3,ctl4];
    
    [self setViewControllers:viewControllers animated:YES];
    
}

- (void)loadCustomTabBarView
{
    [self initDatas];
    
    // 初始化自定义TabBar背景
    
    _tabBarBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-TABBAR_HEIGHT, SCREENWIDTH, TABBAR_HEIGHT)];
    
    _tabBarBG.userInteractionEnabled = YES; //关键
    _tabBarBG.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBarBG];
    
//    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0.5, SCREENWIDTH, 0.5)];
//    lineImageView.backgroundColor = RGBCOLOR(172, 172, 172);
//    [_tabBarBG addSubview:lineImageView];
    
    //tabbarItems
    for (int i = 0; i < 5; i++) {
        NSString *imageName = [self.tabBarImageNames safeObjectAtIndex:i];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((ItemWidth - ImageWidth)/2, 5, ImageWidth, ImageWidth)];
        imageView.tag = 900;
        imageView.image = [UIImage imageNamed:imageName];
        
        UIButton * tabbarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        tabbarItem.backgroundColor = [UIColor clearColor];
        [self.btnArray addObject:tabbarItem];
        tabbarItem.titleLabel.font = SystemFont(12.0f);
        tabbarItem.titleLabel.textAlignment = NSTextAlignmentCenter;
        tabbarItem.frame = CGRectMake(i*ItemWidth, 0, ItemWidth, TABBAR_HEIGHT);
        tabbarItem.tag = i;
        [tabbarItem addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarItem addSubview:imageView];
        [_tabBarBG addSubview:tabbarItem];
        
        UILabel *labelT = [[UILabel alloc] initWithFrame:CGRectMake(0, TABBAR_HEIGHT - 15, ItemWidth, 12)];
        labelT.font = SystemFont(12.0f);
        labelT.textAlignment = NSTextAlignmentCenter;
        labelT.textColor = RGBCOLOR(119, 119, 119 );
        labelT.backgroundColor = [UIColor clearColor];
        labelT.text = [self.titleArray safeObjectAtIndex:i];
        [tabbarItem addSubview:labelT];
        
        
        //默认第一个
        if (i == self.selectedIndex) {
            [self changeViewController:tabbarItem];
        }
    }

}

#pragma mark-
#pragma mark-显示/隐藏
- (void)showTabBar
{
    self.tabBar.hidden = YES;//这里一定要有，否则不兼容ios7
    [UIView beginAnimations:nil context:NULL];
    if (IS_IOS7) {
        [UIView setAnimationDuration:0.05];
    }
    else
        [UIView setAnimationDuration:0.34];
    
    _tabBarBG.frame = CGRectMake(0, SCREENHEIGHT-TABBAR_HEIGHT, SCREENWIDTH, TABBAR_HEIGHT);
    [UIView commitAnimations];
}

- (void)hiddenTabBar
{
    [UIView beginAnimations:nil context:NULL];
    if (IS_IOS7) {
        [UIView setAnimationDuration:0.05];
    }
    else
        [UIView setAnimationDuration:0.36];
    
    _tabBarBG.frame = CGRectMake(-SCREENWIDTH, SCREENHEIGHT-TABBAR_HEIGHT, SCREENWIDTH, TABBAR_HEIGHT);
    [UIView commitAnimations];
}

#pragma mark-
#pragma mark-初始化数据
- (void)initDatas{
    
    self.tabBarImageNames = [[NSMutableArray alloc]initWithObjects:
                              @"Tab01Normal.png",
                              @"Tab02Normal.png",
                              @"Tab05Normal.png",
                              @"Tab03Normal.png",
                              @"Tab04Normal.png",

                              nil];
    
    self.tabBarSelectedImageNames = [[NSMutableArray alloc]initWithObjects:
                                      @"Tab01Highlighted.png",
                                      @"Tab02Highlighted.png",
                                      @"Tab05Highlighted.png",
                                      @"Tab03Highlighted.png",
                                      @"Tab04Highlighted.png",
                                      nil];
    
}

#pragma mark-
#pragma mark-其他
- (void)changeViewController:(UIButton *)button
{
    
    UIButton *lastbtn = (UIButton *)[self.btnArray safeObjectAtIndex:self.selectedIndex];
    for (UIImageView *imageView in lastbtn.subviews) {
        if (imageView.tag == 900) {
            NSString *lastImageName = [self.tabBarImageNames safeObjectAtIndex:self.selectedIndex];
            [imageView setImage:[UIImage imageNamed:lastImageName]];
        }
    }
    
    for (UIButton *btn in self.btnArray) {
        if (btn == button) {
            [btn setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
            for (UIImageView *imageView in btn.subviews) {
                if (imageView.tag == 900) {
                    NSString *seleteImage = [self.tabBarSelectedImageNames safeObjectAtIndex:button.tag];
                    [imageView setImage:[UIImage imageNamed:seleteImage]];
                }
            }
        }
        else
        {
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    //转到相应的视图
    self.selectedIndex = button.tag;

}


-(void)changeSelectIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)[self.btnArray safeObjectAtIndex:index];
    
    if (button) {
        [self changeViewController:button];
    }
    
    
    
}


#pragma mark- 设置tabbar 角标



-(void)setNewMsgTipWithIndex:(int)index
{
    if (index == 1) {
        return;
    }
    UILabel *labelTemp = [self.newsMsgLabelArray safeObjectAtIndex:index];
    [_tabBarBG addSubview:labelTemp];
    labelTemp.hidden = NO;
    
}

-(void)hideNewMsgTipWithIndex:(int)index
{
    UILabel *labelTemp = [self.newsMsgLabelArray safeObjectAtIndex:index];
    labelTemp.hidden = YES;
    [labelTemp removeFromSuperview];
    
}


@end
