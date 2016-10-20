//
//  YingShowHorSelectItemView.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/13.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YingShowHorSelectFont SystemFont(13.0)

@class YingShowHorSelectItemView;

@protocol YingShowItemViewSelectDelegate <NSObject>

-(void)yingShowDidSelectItemView:(YingShowHorSelectItemView *)itemView;

@end


@interface YingShowHorSelectItemView : UIView

@property (nonatomic,weak) id <YingShowItemViewSelectDelegate> delegate;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,assign) CGFloat textWidth;

@property (nonatomic,strong) NSString *titleStr;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title withFont:(UIFont *)font;

@end
