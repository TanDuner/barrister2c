//
//  UIButton+EnlargeEdge.h
//  barrister
//
//  Created by 徐书传 on 16/6/5.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
