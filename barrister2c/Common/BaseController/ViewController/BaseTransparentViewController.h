//
//  BaseTransparentViewController.h
//  barrister
//
//  Created by 徐书传 on 16/5/31.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNoDataView.h"

@interface BaseTransparentViewController : BaseViewController<BaseNoDataViewDelegate,UIScrollViewDelegate>


/* 列表  */
@property (nonatomic, strong) UITableView *tableView;

/* scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;

/* 头视图 */
@property (nonatomic, strong) UIView *headerBackView;

/* 头视图背景 */
@property (nonatomic, strong) UIImageView *headerBackImageView;

/* 头视图背景图片 */
@property (nonatomic, strong) UIImage *headerBackImage;

/* 导航变化高度 */
@property (nonatomic, assign) CGFloat naviagtion_change_height;

/* 头部图片高度 */
@property (nonatomic, assign) CGFloat headerImage_height;

/* 无数据页面 */
@property (nonatomic, strong) BaseNoDataView *noDataView;

/**
 *  初始化导航栏后退按钮文字和处理对象
 *
 *  @param target 实现方法的对象
 *  @param action  回调方法
 *  @param btnText 按钮文字
 */
- (void)addNavigationBackButton:(id)target action:(SEL)action btnText:(NSString *)btnText;

/**
 *  初始化导航栏右侧按钮文字和处理对象
 *
 *  @param target 实现方法的对象
 *  @param action  回调方法
 *  @param btnText 按钮文字
 */
- (void)addNavigationRightButton:(id)target action:(SEL)action btnText:(NSString *)btnText;


/**
 *  显示无数据占位图数据
 *
 *  @param str      描述文字
 *  @param btnText  按钮文字
 *  @param target   动作目标
 *  @param selector 按钮事件
 *
 */
- (void)showNoDataViewWithStr:(NSString *)str textBtn:(NSString *)btnText target:(id)target selector:(SEL)selector;

/**
 *  隐藏无数据占位图
 */
- (void)hideNoDataView;


#pragma mark - TableView or ScrollView 二选一
/**
 *  初始化列表
 */
- (void)initTableView;

/**
 *  初始化滑动视图
 */
- (void)initScrollView;


@end
