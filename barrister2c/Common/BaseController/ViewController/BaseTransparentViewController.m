//
//  BaseTransparentViewController.m
//  barrister
//
//  Created by 徐书传 on 16/5/31.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTransparentViewController.h"
#import "UINavigationBar+Background.h"

@implementation BaseTransparentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //    _tableView.delegate = self;
    
    //    _scrollView.delegate = self;
    
    [self scrollViewDidScroll:_tableView];
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _tableView.delegate = nil;
    
    //    _scrollView.delegate = nil;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    if (!navigationBar) {
//        IMTabBarController *mainTabVC = ((IMAppDelegate *)[[UIApplication sharedApplication] delegate]).mainTabVC;
//        
//        if (mainTabVC) {
//            IMNavigationController *navigationController = [mainTabVC.viewControllerssafeObjectAtIndex:mainTabVC.selectedIndex];
//            navigationBar = (UINavigationBar *)navigationController.navigationBar;
//        }
//    }
//    
    [navigationBar navigationBarReset];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = KColorGray999;
    
    [self configData];
    
    [self initNavigationView];
    
    [self.view addSubview:self.noDataView];
}

- (void)configData
{
    // 初始化顶部背景图默认高度
    _headerImage_height = 175;
    
    // 初始化导航变色的高度
    _naviagtion_change_height = 175 - 64;
    
    // 初始化默认的顶部图片
    _headerBackImage = [UIImage imageNamed:@"job_coin_background"];
}

- (void)initTableView
{
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:self.headerBackImageView];
    
    [self.tableView addSubview:self.headerBackView];
}

- (void)initScrollView
{
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.headerBackImageView];
    
    [self.scrollView addSubview:self.headerBackView];
    
}

#pragma mark get-method

- (BaseNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[BaseNoDataView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        
        _noDataView.hidden = YES;
        
        _noDataView.delegate = self;
    }
    
    return _noDataView;
}

/**
 *  tableView
 */
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setContentInset:UIEdgeInsetsMake(_headerImage_height, 0, 0, 0)];
    }
    
    return _tableView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView setContentInset:UIEdgeInsetsMake(_headerImage_height, 0, 0, 0)];
    }
    return _scrollView;
}

- (UIView *)headerBackView {
    if (!_headerBackView) {
        _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -_headerImage_height, SCREENWIDTH, _headerImage_height)];
        _headerBackView.backgroundColor = [UIColor clearColor];
    }
    
    return _headerBackView;
}

- (UIImageView *)headerBackImageView {
    if (!_headerBackImageView) {
        _headerBackImageView = [[UIImageView alloc] initWithImage:_headerBackImage];
        _headerBackImageView.frame = CGRectMake(0, -_headerImage_height, SCREENWIDTH, _headerImage_height);
        _headerBackImageView.userInteractionEnabled = YES;
        [_headerBackImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerBackImageView setClipsToBounds:YES];
    }
    return _headerBackImageView;
}


#pragma mark set-method

- (void)setHeaderBackImage:(UIImage *)headerBackImage {
    
    if (headerBackImage) {
        _headerBackImageView.image = headerBackImage;
        
        _headerImage_height = headerBackImage.size.height;
        
        _naviagtion_change_height = _headerImage_height - 64;
        
        _headerBackImageView.frame = CGRectMake(0, -_headerImage_height, SCREENWIDTH, _headerImage_height);
        
        _headerBackView.frame = CGRectMake(0, -_headerImage_height, SCREENWIDTH, _headerImage_height);
        
        [_tableView setContentInset:UIEdgeInsetsMake(_headerImage_height, 0, 0, 0)];
    }
}

#pragma mark - 自定义导航

- (void)initNavigationView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self.navigationController.navigationBar setNavigationBarTitleColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setNavigationBarBackgroundColor:[UIColor clearColor]];
}

- (void)addNavigationBackButton:(id)target action:(SEL)action btnText:(NSString *)btnText
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:btnText forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [backBtn setImage:[UIImage imageNamed:@"job_coin_back"] forState:UIControlStateNormal];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(0, 0, 50, 30)];
    //    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, -10, 0, 0)];
    //    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, -5, 0, 0)];
    
    UIBarButtonItem * backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBar;
}

- (void)addNavigationRightButton:(id)target action:(SEL)action btnText:(NSString *)btnText
{
    NSDictionary  *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor whiteColor] } ;
    NSDictionary  *disableAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [ UIColor  lightGrayColor] } ;
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:btnText
                                                                 style:UIBarButtonItemStylePlain
                                                                target:target
                                                                action:action];
    [rightBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [rightBtn setTitleTextAttributes:disableAttributes forState:UIControlStateDisabled];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = KColorGray999;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY + _headerImage_height <= _naviagtion_change_height) {
        
        CGFloat alpha = (offsetY + _headerImage_height) / (_naviagtion_change_height);
        
        [self.navigationController.navigationBar setNavigationBarBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        if (alpha < 0.1) {
            // 恢复成透明导航
            [self.navigationController.navigationBar setNavigationBarTitleColor:[UIColor whiteColor]];
            
            [self.navigationItem.leftBarButtonItem.customView setImage:[UIImage imageNamed:@"job_coin_back"] forState:UIControlStateNormal];
            
            [self setBarButtonItemColor:[UIColor whiteColor] barButtonItemType:0 target:self];
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
            
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线
        }
        else {
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于显示导航栏的底线
        }
    }
    else {
        // 还原成通用导航
        [self showNormarlNavigationBar];
    }
    
    if (offsetY < -_headerImage_height) {
        CGRect rect = self.headerBackImageView.frame;
        rect.origin.y = offsetY;
        rect.size.height =  - offsetY;
        
        self.headerBackImageView.frame = rect;
    }
}

#pragma mark - navigationBar custom
- (void)showNormarlNavigationBar
{
    [self.navigationController.navigationBar setNavigationBarBackgroundColor:[KColorGray999 colorWithAlphaComponent:1]];
    
    [self.navigationItem.leftBarButtonItem.customView setImage:[UIImage imageNamed:@"job_coin_orange_back"] forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [self.navigationController.navigationBar setNavigationBarTitleColor:KColorGray666];
    
    [self.navigationController.navigationBar setShadowImage:nil];//用于去除导航栏的底线
    
    [self setBarButtonItemColor:kNavigationBarColor barButtonItemType:0 target:self];
    
}

/**
 *  设置导航按钮的颜色
 */
- (void)setBarButtonItemColor:(UIColor *)aColor barButtonItemType:(NSInteger)aType target:(BaseViewController *)aTarget
{
    if (aType == 0) {
        // 左按钮
        [self setLeftBarButtonItemColor:aColor target:aTarget];
        
        // 右按钮
        [self setRightBarButtonItemColor:aColor target:aTarget];
    }
    else if (aType == 1) {
        // 左按钮
        [self setLeftBarButtonItemColor:aColor target:aTarget];
    }
    else {
        // 右按钮
        [self setRightBarButtonItemColor:aColor target:aTarget];
    }
}

/**
 *  设置导航左按钮的颜色
 */
- (void)setLeftBarButtonItemColor:(UIColor *)aColor target:(BaseViewController *)aTarget
{
    // 左按钮
    id leftCustomView = aTarget.navigationItem.leftBarButtonItem.customView;
    if ([leftCustomView isKindOfClass:[UIButton class]]) {
        [leftCustomView setTitleColor:aColor forState:UIControlStateNormal];
    }
    else if (leftCustomView == nil) {
        [aTarget.navigationItem.leftBarButtonItem setTitleTextAttributes : @{NSForegroundColorAttributeName : aColor} forState:UIControlStateNormal];
    }
}

/**
 *  设置导航右按钮的颜色
 */
- (void)setRightBarButtonItemColor:(UIColor *)aColor target:(BaseViewController *)aTarget
{
    // 左按钮
    id rightCustomView = aTarget.navigationItem.rightBarButtonItem.customView;
    if ([rightCustomView isKindOfClass:[UIButton class]]) {
        [rightCustomView setTitleColor:aColor forState:UIControlStateNormal];
    }
    else if (rightCustomView == nil) {
        [aTarget.navigationItem.rightBarButtonItem setTitleTextAttributes : @{NSForegroundColorAttributeName : aColor} forState:UIControlStateNormal];
    }
}



#pragma mark - noDataView

- (void)showNoDataViewWithStr:(NSString *)str textBtn:(NSString *)btnText target:(id)target selector:(SEL)selector
{
    [self showNormarlNavigationBar];
    
    self.noDataView.hidden = NO;
    
    _tableView.hidden = YES;
    
    _scrollView.hidden = YES;
    
    [self.noDataView showNoDataViewWithStr:str textBtn:btnText target:target selector:selector];
}

- (void)hideNoDataView
{
    self.noDataView.hidden = YES;
    
    [self scrollViewDidScroll:_tableView];
    
    _tableView.hidden = NO;
    
    _scrollView.hidden = NO;
}

#pragma mark - noDataViewDelegate

- (void)jobNoDataClick
{
    
}

@end

/**
 *  隐藏导航下面的线 -- 先保留一下这个方法
 */
/*
- (void)setBarBottomLineHidde:(BOOL)hidden
{
if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
NSArray *list=self.navigationController.navigationBar.subviews;
for (id obj in list) {
if ([obj isKindOfClass:[UIImageView class]]) {
UIImageView *imageView = (UIImageView *)obj;
NSArray *list2 = imageView.subviews;
for (id obj2 in list2) {
if ([obj2 isKindOfClass:[UIImageView class]]) {
UIImageView *imageView2 = (UIImageView *)obj2;
imageView2.hidden = hidden;
}
}
}
}
}
}
 */
