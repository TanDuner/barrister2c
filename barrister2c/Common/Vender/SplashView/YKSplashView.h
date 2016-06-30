//
//  YKSplashView.h
//  LafasoGroupBuy
//
//  Created by HQS on 12-10-30.
//
//

#import <UIKit/UIKit.h>

@interface YKSplashView : UIScrollView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}

+ (BOOL)getIsOpenGuideView;

@end
