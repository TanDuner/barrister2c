//
//  PagerView.h
//  NinaPagerView
//
//  Created by RamWire on 15/9/22.
//  Copyright © 2015年 RamWire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NinaBaseView : UIView <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) NSInteger currentPage; /**<  页码   **/
@property (strong, nonatomic) UIScrollView *topTab; /**<  顶部tab   **/
@property (strong, nonatomic) NSArray *titleArray; /**<  标题   **/
@property (assign, nonatomic) CGFloat titleScale; /**< 标题缩放比例 **/

@property (nonatomic,assign) BOOL isAlertShow; //是否是弹框展示

- (instancetype)initWithFrame:(CGRect)frame WithSelectColor:(UIColor *)selectColor WithUnselectorColor:(UIColor *)unselectColor WithUnderLineColor:(UIColor *)underlineColor WithtopTabColor:(UIColor *)topTabColor isAlertShow:(BOOL)isAlertShow;
@end
