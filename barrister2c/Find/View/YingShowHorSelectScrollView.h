//
//  YingShowHorSelectScrollView.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/13.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YingShowHorSelectScrollView;


@protocol YingShowHorScrollViewDelegate <NSObject>

//点击事件
-(void)didSelectItemWithSelectObject:(NSString *)selectObject ScrollView:(YingShowHorSelectScrollView *)horScrollView;

@end


@interface YingShowHorSelectScrollView : UIScrollView

@property (nonatomic,strong) NSString *selectObject;

@property (nonatomic,assign) id<YingShowHorScrollViewDelegate> horScrollDelegate;


-(id)initWithFrame:(CGRect)frame items:(NSMutableArray *)items;



@end
