//
//  BorderTextFieldView.h
//  barrister
//
//  Created by 徐书传 on 16/3/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorderTextFieldView : UITextField

@property(nonatomic,assign) int row;
@property(nonatomic,assign)CGFloat cleanBtnOffset_x;
@property(nonatomic,assign)CGFloat textOffset_width;

@property (nonatomic,assign) CGFloat textLeftOffset;
@end
