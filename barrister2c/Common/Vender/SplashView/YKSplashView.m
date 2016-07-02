//
//  YKSplashView.m
//  LafasoGroupBuy
//
//  Created by HQS on 12-10-30.
//
//


#import "YKSplashView.h"
#import "AppDelegate.h"
#import "UIImage+Additions.h"

//iphone型号判断
#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define SPLASHCOUNT 3  //chark add 2015/03/13

#define storeKey @"ishasOpenapp321"

@implementation YKSplashView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //先判断是否是第一次使用
        if (![YKSplashView getIsOpenGuideView]) {
            //加载引导图
//            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            
            _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
            _scrollView.delegate = self;
            _scrollView.bounces = NO;
            [_scrollView setShowsHorizontalScrollIndicator:NO];
            [_scrollView setShowsVerticalScrollIndicator:NO];
            [_scrollView setPagingEnabled:YES];
            [self addSubview:_scrollView];
            [self loadView];
        }
    }
    return self;
}


+ (BOOL)getIsOpenGuideView
{
    BOOL isOneOpen = [[NSUserDefaults standardUserDefaults] boolForKey:storeKey];
    
    return isOneOpen;
}



//登录主界面
- (void)btnGuideClick:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:storeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app createTabbar];
    [self removeFromSuperview];
}


- (void)loadView
{
    int num = SPLASHCOUNT;
    for (int i = 0 ; i < num; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
        imgView.userInteractionEnabled = YES;
        imgView.backgroundColor = RGBCOLOR(232, 233, 234);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d",i + 1]];
        UIImageView *contentViewImage = [[UIImageView alloc] initWithFrame:RECT((SCREENWIDTH - image.size.width)/2.0, (SCREENHEIGHT - image.size.height)/2.0, image.size.width, image.size.height)];
        contentViewImage.image = image;

        if (i == 2) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(btnGuideClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setFrame:RECT((contentViewImage.width - 180)/2.0, contentViewImage.height - 40, 180, 40)];
            contentViewImage.userInteractionEnabled = YES;
            [contentViewImage addSubview:btn];
        }
        
        
        [imgView addSubview:contentViewImage];
        
        
        
        [_scrollView addSubview:imgView];
    }
    
    [_scrollView setContentSize:CGSizeMake(SCREENWIDTH*num, SCREENHEIGHT)];
    
}


/*

- (void)loadView
{
    //chark fixed.  2015/03/13
// 与赵辰设计成一套图----仅支持背景色为纯色的图片

//    int num = 2;
    int num = SPLASHCOUNT;
//    NSArray *colorArr = @[@"#f79361",@"#4a8ecc",@"#4cd3b9"];
    for (int i = 0 ; i < num; i++) {
//        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, ScreenHeight)];
//        bottomView.backgroundColor = [UIColor whiteColor];
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, ScreenHeight)];

//        CGRect rect = CGRectMake(10, 0, self.width - 20, self.height);
        CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);

        UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *tmpImgName = @"";
        if (isiPhone5) {
            [self rectTextWithIndex:i isPhone5H:YES imgView:imgView];
            tmpImgName = [NSString stringWithFormat:@"guide_0%d_6401136.png",i];
        } else {
            [self rectTextWithIndex:i isPhone5H:NO imgView:imgView];
            tmpImgName = [NSString stringWithFormat:@"guide_0%d_640960.png",i];
        }
        



//        [self rectTextWithIndex:i isPhone5H:YES imgView:imgView];
//        tmpImgName = [NSString stringWithFormat:@"guide_0%d_6401136.png",i];

        imgView.image = [UIImage imageNamed:tmpImgName];
//        [bottomView addSubview:imgView];
        [_scrollView addSubview:imgView];
//        [_scrollView addSubview:bottomView];

    }
    
    [_scrollView setContentSize:CGSizeMake(ScreenWidth*num, ScreenHeight)];
    
}
 
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSInteger page = scrollView.contentOffset.x / ScreenHeight;
    //    if (page < 3) {
    //    } else {
    //        [_pageControl setHidden:YES];
    //    }
}

@end
