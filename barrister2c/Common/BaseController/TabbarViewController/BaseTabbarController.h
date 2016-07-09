//
//  BaseTabbarController.h
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabbarController : UITabBarController
{
    UIImageView * imagView;
    UILabel * label;
}
@property (nonatomic,strong) NSMutableArray * btnArray;
@property (nonatomic,strong) NSMutableArray * imageViewArray;
@property (nonatomic,strong) NSMutableArray * newsMsgLabelArray;
@property (nonatomic,strong) NSMutableArray * titleArray;
@property (nonatomic,strong) UIImageView * selectView;
@property (nonatomic,strong) UIImageView * tabBarBG;



- (void)changeViewController:(UIButton *)button;
- (void)showTabBar;
- (void)hiddenTabBar;

@end
