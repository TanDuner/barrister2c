//
//  BaseViewController.m
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "ZToastView.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"

#import "RefreshTableView.h"


#define NAVIGATION_BAR_TITLECOLOR       [UIColor whiteColor]


@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self initBaseViewController];
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initBaseViewController];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initBaseViewController];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBaseViewBackgroundColor;
    
    [self addBackButton];
    self.noContentString = @"没有数据";
    self.loadingString = @"正在加载...";
    
    [self updateNavigationController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateNavigationController];
    
    if (IS_IOS7) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    [self layoutSubviews];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)updateNavigationController
{
    
    BOOL hidden = [self.navigationController.viewControllers count] <= 1;
    
    if (!hidden) {
        [self.navigationController setNavigationBarHidden:hidden animated:YES];
    }
}


- (void)initBaseViewController
{
    _dataSingleton = [BaseDataSingleton shareInstance];
}


#pragma mark -
#pragma mark - Actions

-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)showNavigationLoading
{
    static const int nLoadingIconWidth = 30;
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 160, 44)];
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    [titleLab setFont:SystemFont(17.0f)];
    [titleLab setTextColor:NAVIGATION_BAR_TITLECOLOR];
    [titleLab setText:self.navigationItem.title];
    [titleLab sizeToFit];
    UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    if (titleView.frame.size.width - nLoadingIconWidth >= titleLab.frame.size.width)
    {
        [titleLab setFrame:CGRectMake((titleView.frame.size.width - titleLab.frame.size.width) / 2, 0, titleLab.frame.size.width, 44)];
    }
    else
    {
        [titleLab setFrame:CGRectMake(nLoadingIconWidth, 0, titleView.frame.size.width - nLoadingIconWidth, 44)];
    }
    [indicatorView setFrame:CGRectMake(titleLab.frame.origin.x - nLoadingIconWidth, 0, nLoadingIconWidth, 44)];
    [titleView addSubview:indicatorView];
    [titleView addSubview:titleLab];
    [indicatorView startAnimating];
    
    self.navigationItem.titleView = titleView;
    
}

- (void)hideNavigationLoading
{
    self.navigationItem.titleView = nil;
}

- (NSString *)getBackBtnText
{
    
    return @"返回";
//    UIViewController * perVc;
//    NSString * backBtnText;
//    NSUInteger curIndex = [self.navigationController.viewControllers indexOfObject:self];
//    
//    if (curIndex > 0 && curIndex < [self.navigationController.viewControllers count])
//    {
//        perVc = [self.navigationController.viewControllers objectAtIndex:curIndex - 1];
//        if (curIndex == 1
//            && self.navigationController.tabBarItem.title
//            && self.navigationController.tabBarItem.title.length > 0)
//        {
//            backBtnText = self.navigationController.tabBarItem.title;
//        }
//        else
//        {
//            backBtnText = perVc.navigationItem.title;
//        }
//    }
//    
//    if (!backBtnText || backBtnText.length <= 0)
//    {
//        backBtnText = NSLocalizedString(@"Back", nil);
//    }
//    
//    return backBtnText;
}

- (void)addBackButton
{
    
    if (self != [self.navigationController.viewControllers objectAtIndex:0])
    {
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:[self getBackBtnText] forState:UIControlStateNormal];
        [backBtn setTitleColor:NAVIGATION_BAR_TITLECOLOR forState:UIControlStateNormal];
        [backBtn setTitleColor:kButtonColor1Highlight forState:UIControlStateHighlighted];
        [backBtn.titleLabel setFont:SystemFont(16.0f)];
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_icon"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_icon_hl"] forState:UIControlStateHighlighted];
        [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setFrame:CGRectMake(0, 0, 50, 30)];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, -10, 0, 0)];
        [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, -5, 0, 0)];
        
        UIBarButtonItem * backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBar;
    }
}

- (void)addBackButtonOnRootWithTarget:(id)target action:(SEL)action
{
    [self addBackButtonOnRootWithTarget:target action:action btnText:NSLocalizedString(@"Back", nil)];
}

- (void)addBackButtonOnRootWithTarget:(id)target action:(SEL)action btnText:(NSString *)btnText
{

    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:btnText forState:UIControlStateNormal];
    [backBtn setTitleColor:NAVIGATION_BAR_TITLECOLOR forState:UIControlStateNormal];
    [backBtn setTitleColor:kButtonColor1Highlight forState:UIControlStateHighlighted];
    [backBtn.titleLabel setFont:SystemFont(16.0f)];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_icon"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_icon_hl"] forState:UIControlStateHighlighted];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, -10, 0, 0)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, -5, 0, 0)];
    
    UIBarButtonItem * backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBar;
  }

- (void)initNavigationRightTextButton:(NSString *)btnText action:(SEL)action
{
    NSDictionary  *attributes = @{ NSFontAttributeName : SystemFont(16.0f), NSForegroundColorAttributeName : NAVIGATION_BAR_TITLECOLOR } ;
    NSDictionary  *disableAttributes = @{ NSFontAttributeName : SystemFont(16.0f), NSForegroundColorAttributeName : kButtonColor1Highlight } ;
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:btnText
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:action];
    [rightBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [rightBtn setTitleTextAttributes:disableAttributes forState:UIControlStateDisabled];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)initNavigationRightTextButton:(NSString *)btnText action:(SEL)action target:(id)target
{
    NSDictionary  *attributes = @{ NSFontAttributeName : SystemFont(16.0f), NSForegroundColorAttributeName : NAVIGATION_BAR_TITLECOLOR } ;
    NSDictionary  *disableAttributes = @{ NSFontAttributeName : SystemFont(16.0f), NSForegroundColorAttributeName : [ UIColor  lightGrayColor] } ;
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:btnText
                                                                 style:UIBarButtonItemStylePlain
                                                                target:target
                                                                action:action];
    [rightBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [rightBtn setTitleTextAttributes:disableAttributes forState:UIControlStateDisabled];
    self.navigationItem.rightBarButtonItem = rightBtn;
}


- (void)hideNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)showNavigationBar
{
    self.navigationController.navigationBarHidden = NO;
}

-(void)showTabbar:(BOOL)isShowTabbar
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!isShowTabbar) {
        [delegate.tabBarCTL hiddenTabBar];
    }
    else
    {
        [delegate.tabBarCTL showTabBar];
    }

}

- (void)showLoadingHUD
{
    [self showLoadingHUDWithLabel:@"正在加载..."];
}

- (void)showLoadingHUDWithLabel:(NSString *)label
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
    _HUD.delegate = self;
    _HUD.labelText = label;
    
    [_HUD show:YES];
}

- (void)hideHUD
{
    [_HUD hide:YES];
}

- (void)makeToast:(NSString *)message
{
    [self makeToast:message duration:2.0f];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration
{
    ZToastView *toastView = [[ZToastView alloc] initWithFrame:CGRectMake(0, 0, 248, 80)];
    [toastView setMessage:message];
    [toastView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
    
    [self.view showToast:toastView
                duration:duration
                position:CSToastPositionCenter];
}

- (void)showErrorMessage:(NSError *)error
{
    NSString *errorMessage = [NSString stringWithFormat:@"错误码：%ld\n%@", (long)error.code, [error localizedDescription]];
    
    [self makeToast:errorMessage duration:2.0f];
}

- (CGFloat)subviewTopY
{
    CGFloat y = 0;
    if (IS_IOS7) {
        y = 20.0f;
    }
    
    if (!self.navigationController.navigationBar.hidden) {
        y += self.navigationController.navigationBar.height;
    }
    
    return y;
}

#pragma mark -
#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [_HUD removeFromSuperview];
    _HUD = nil;
}

- (void)showNoContentView
{
    [self noContentView].hidden = NO;
}

- (void)hideNoContentView
{
    [self noContentView].hidden = YES;
}

- (UIView *)noContentView
{
    if (!_noContentView) {
        _noContentView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        [self.view addSubview:_noContentView];
        [self.view sendSubviewToBack:_noContentView];
        
        UIImage *image = [UIImage imageNamed:@"icon_nothing"];
        CGRect frame = CGRectMake((self.view.width - image.size.width) / 2.0f, (self.view.height - image.size.height) / 2.0f - image.size.height / 2.0f, image.size.width, image.size.height);
        _noContentImageView = [[UIImageView alloc] initWithFrame:frame];
        _noContentImageView.image = image;
        
        [_noContentView addSubview:_noContentImageView];
        
        UIFont *font = SystemFont(14.0f);
        CGSize size = [self.noContentString XuSizeWithFont:font constrainedToSize:CGSizeMake(_noContentView.width - 40.0f, _noContentView.height)];
        
        frame = CGRectMake(20.0f, _noContentImageView.y + _noContentImageView.height + 20.0f, _noContentView.width - 40.0f, size.height);
        _noContentLabel = [[UILabel alloc] initWithFrame:frame];
        _noContentLabel.font = font;
        _noContentLabel.textColor = UIColorFromRGB(0x666666);
        _noContentLabel.textAlignment = NSTextAlignmentCenter;
        _noContentLabel.backgroundColor = [UIColor clearColor];
        _noContentLabel.text = self.noContentString;
        
        [_noContentView addSubview:_noContentLabel];
        
        [self.view addSubview:_noContentView];
    }
    
    return _noContentView;
}

- (void)showLoadingView
{
    UIView *loadingView = [self loadingView];
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
}

- (void)hideLoadingView
{
    [_loadingView removeFromSuperview];
    _loadingView = nil;
}

- (UIView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
        _loadingView.backgroundColor = self.view.backgroundColor;
        
        UIFont *font = SystemFont(14.0f);
        
        CGSize size = [self.loadingString XuSizeWithFont:font constrainedToSize:CGSizeMake(_loadingView.width - 40.0f, _loadingView.height)];
        
        _loadingActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGRect frame = CGRectMake((_loadingView.width - (_loadingActivityIndicatorView.width + 10.0f + size.width)) / 2.0f, (_loadingView.height - _loadingActivityIndicatorView.height) / 2.0f, _loadingActivityIndicatorView.width, _loadingActivityIndicatorView.height);
        _loadingActivityIndicatorView.frame = frame;
        [_loadingActivityIndicatorView startAnimating];
        
        [_loadingView addSubview:_loadingActivityIndicatorView];
        
        frame = CGRectMake(_loadingActivityIndicatorView.x + _loadingActivityIndicatorView.width + 10.0f, (_loadingView.height - size.height) / 2.0f, size.width, size.height);
        _loadingLabel = [[UILabel alloc] initWithFrame:frame];
        _loadingLabel.font = font;
        _loadingLabel.textColor = UIColorFromRGB(0x666666);
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.backgroundColor = [UIColor clearColor];
        _loadingLabel.text = self.loadingString;
        
        [_loadingView addSubview:_loadingLabel];
    }
    
    return _loadingView;
}

- (void)layoutSubviews
{
    // 没有消息
    _noContentView.frame = self.view.bounds;
    CGRect frame = CGRectMake((self.view.width - _noContentImageView.image.size.width) / 2.0f, (self.view.height - _noContentImageView.image.size.height) / 2.0f - _noContentImageView.image.size.height / 2.0f, _noContentImageView.image.size.width, _noContentImageView.image.size.height);
    _noContentImageView.frame = frame;
    UIFont *font = SystemFont(14.0f);
    CGSize size = [self.noContentString XuSizeWithFont:font constrainedToSize:CGSizeMake(_noContentView.width - 40.0f, _noContentView.height)];

    
    frame = CGRectMake(20.0f, _noContentImageView.y + _noContentImageView.height + 20.0f, _noContentView.width - 40.0f, size.height);
    _noContentLabel.frame = frame;
    
    // 正在加载
    _loadingView.frame = self.view.bounds;
    size = [self.loadingString XuSizeWithFont:font constrainedToSize:CGSizeMake(_loadingView.width - 40.0f, _loadingView.height)];
    frame = CGRectMake((_loadingView.width - (_loadingActivityIndicatorView.width + 10.0f + size.width)) / 2.0f, (_loadingView.height - _loadingActivityIndicatorView.height) / 2.0f, _loadingActivityIndicatorView.width, _loadingActivityIndicatorView.height);
    _loadingActivityIndicatorView.frame = frame;
    frame = CGRectMake(_loadingActivityIndicatorView.x + _loadingActivityIndicatorView.width + 10.0f, (_loadingView.height - size.height) / 2.0f, size.width, size.height);
    _loadingLabel.frame = frame;
}


-(UIView *)getLineViewWithFrame:(CGRect )rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = kSeparatorColor;
    return view;
}


/**
 *  处理tableview 上下拉刷新的 数据问题
 */
-(void)handleTableRefreshOrLoadMoreWithTableView:(RefreshTableView *)tableView array:(NSArray *)array aBlock:(void(^)())aBlock
{
    if (tableView.pageNum == 1) {
        if (aBlock) {
            aBlock();
        }
        [tableView endRefreshing];
        if (array.count == 0) {
            [self showNoContentView];
        }
        else
        {
            [self hideNoContentView];
            if (array.count < tableView.pageSize) {
                [tableView endLoadMoreWithNoMoreData:YES];
            }
            else
            {
                [tableView endLoadMoreWithNoMoreData:NO];
            }
        }
    }
    else
    {
        [self hideNoContentView];
        if (array.count < tableView.pageSize) {
            [tableView endLoadMoreWithNoMoreData:YES];
        }
        else
        {
            [tableView endLoadMoreWithNoMoreData:NO];
        }

    }
    
      
}


@end
