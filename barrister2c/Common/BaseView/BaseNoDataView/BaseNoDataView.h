//
//  BaseNoDataView.h
//  barrister
//
//  Created by 徐书传 on 16/5/31.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BaseNoDataViewDelegate <NSObject>

@optional

/**
 *  点击页面上除按钮以外其他位置的事件
 */
- (void)jobNoDataClick;

@end


@interface BaseNoDataView : UIView

@property (nonatomic, weak) id<BaseNoDataViewDelegate>delegate;

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
 *  显示无数据占位图
 */
- (void)showNoDataView;

/**
 *  隐藏无数据占位图
 */
- (void)hideNoDataView;


@end
