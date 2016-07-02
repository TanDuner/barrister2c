//
//  IMPullDownMenu.h
//  BangBang
//
//  Created by 赵露 on 14-9-29.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMPullDownMenu;

/**
 *  菜单项类
 */
@interface IMPullDownMenuItem : NSObject

// 菜单标题
@property (nonatomic, strong) NSString * title;

// 当下拉菜单中的第一项为“不限”时，需要设置此属性的字符串，如：“不限”
@property (nonatomic, strong) NSString * unlimitedBtnText;

// 下拉菜单项中的各选项字符串数组，当unlimitedBtnText不为空时，字符串数组从下拉列表的第二项开始显示
@property (nonatomic, strong) NSArray * listItemArray;

// 下拉菜单中的各项所对应的用户数据数组
@property (nonatomic, strong) NSArray * userDataArray;

// 下拉菜单默认选中项的索引
@property (nonatomic, assign) NSInteger defaultIndex;

@end

/**
 *  下拉菜单点击选项回调类
 */
@protocol IMPullDownMenuDelegate <NSObject>

@optional
/**
 *  点击下拉菜单项后的回调函数
 *
 *  @param pullDownMenu 下拉菜单类实例
 *  @param column       当前点击的菜单列数
 *  @param row          当前点击的菜单行数
 */
- (void)PullDownMenu:(IMPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row;

/**
 *  点击下拉菜单项后的回调函数
 *
 *  @param pullDownMenu 下拉菜单类实例
 *  @param column       当前点击的菜单列数
 *  @param row          当前点击的菜单行数
 *  @param userData     当前菜单项所对应的用户数据
 */
- (void)PullDownMenu:(IMPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row userData:(id)userData;

/**
 *  点击下拉菜单标题时的回调函数
 *
 *  @param pullDownMenu 下拉菜单类实例
 *  @param column       当前点击的菜单列数
 */
- (void)PullDownMenu:(IMPullDownMenu *)pullDownMenu willPullDownAtColumn:(NSInteger)column;

@end

/**
 *  下拉菜单类
 */
@interface IMPullDownMenu : UIView

// 下拉菜单回调代理
@property (nonatomic, weak) id<IMPullDownMenuDelegate> delegate;

// 下拉菜单条与弹出的TableView间的空隙像素数，默认为1像素，可用来显示菜单父View下面的分割线
@property (nonatomic, assign) NSUInteger menuToTableViewSpace;

// 下拉菜单文字颜色 默认为 darkTextColor
@property (nonatomic, strong) UIColor * menuColor;

// 下拉菜单点击时的文字颜色，和选中标志的颜色 默认为 imYellowFontColor
@property (nonatomic, strong) UIColor * menuHighLightColor;

// 文字字体默认为 14号字
@property (nonatomic, strong) UIFont * menuFont;

/**
 *  下拉菜单初始化函数
 *
 *  @param array            菜单数组（IMPullDownMenuItem 数组）
 *  @param frame            菜单条Frame
 *  @param parentController 菜单所在的ViewController实例句柄
 *
 *  @return 下拉菜单类实例
 */
- (IMPullDownMenu *)initWithArray:(NSArray *)array frame:(CGRect)frame viewController:(UIViewController *)parentController;

- (IMPullDownMenu *)initWithArray:(NSArray *)array
                            frame:(CGRect)frame
                   viewController:(UIViewController *)parentController
                        menuColor:(UIColor *)aMenuColor
                      hlMenuColor:(UIColor *)aHlMenuColor
                         menuFont:(UIFont *)aMenuFont;

/**
 *  重新设置下拉菜单数据
 *
 *  @param array 菜单数组（IMPullDownMenuItem 数组）
 */
- (void)resetDataArray:(NSArray *)array;

/**
 *  收起弹出的菜单
 */
- (void)rollbackPullDownMenu;


/**
 设置列 行
 
 - returns:
 */

-(void)setColumn:(NSInteger)column row:(NSInteger)row;

@end

@interface IMPullDownMenuGroup : NSObject

- (IMPullDownMenuGroup *)initWithMenuObjects:(IMPullDownMenu *)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

@end
