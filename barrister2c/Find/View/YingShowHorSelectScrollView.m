//
//  YingShowHorSelectScrollView.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/13.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowHorSelectScrollView.h"
#import "YingShowHorSelectItemView.h"
#import "YingShowHorSelectModel.h"


@interface YingShowHorSelectScrollView ()<YingShowItemViewSelectDelegate>

@property (nonatomic,strong) NSMutableArray *itemViewArray;

@end

@implementation YingShowHorSelectScrollView

-(id)initWithFrame:(CGRect)frame items:(NSMutableArray *)items
{
    if (self = [super initWithFrame:frame]) {
        
        [self createSelectViewWithItems:items];
        
    }
    return self;
}

-(void)createSelectViewWithItems:(NSMutableArray *)items
{
    int x = 0;
    for (int i = 0; i < items.count; i ++) {
        YingShowHorSelectModel *model = (YingShowHorSelectModel *)[items objectAtIndex:i];
        
        YingShowHorSelectItemView *itemView = [[YingShowHorSelectItemView alloc] initWithFrame:CGRectZero title:model.titleStr withFont:YingShowHorSelectFont];
        if (model.isSelected == YES) {
            self.selectObject = itemView.titleStr;
            itemView.isSelected = YES;
        }
        else{
            itemView.isSelected =  NO;
        }
        
        itemView.delegate = self;
        [itemView setFrame:RECT(x, 0, itemView.textWidth, 15)];
        x += itemView.textWidth + 15;
        x += 5;
        x += 5;
        
        [self.itemViewArray addObject:itemView];
        
        [self addSubview:itemView];
        
    }
    
    self.contentSize = CGSizeMake(x, 0);
    
}

-(NSMutableArray *)itemViewArray
{
    if (!_itemViewArray) {
        _itemViewArray = [NSMutableArray array];
    }
    return _itemViewArray;
}

-(void)yingShowDidSelectItemView:(YingShowHorSelectItemView *)itemView
{
    if ([self.selectObject isEqualToString:itemView.titleStr]) {
        return;
    }
    else{
        for (YingShowHorSelectItemView *itemTemp in self.itemViewArray) {
            if (itemView == itemTemp) {
                itemView.isSelected = YES;
                self.selectObject = itemView.titleStr;
            }
            else{
                itemTemp.isSelected = NO;
            }
        }
    }
    
    if (self.horScrollDelegate && [self.horScrollDelegate respondsToSelector:@selector(didSelectItemWithSelectObject:ScrollView:)]) {
        [self.horScrollDelegate didSelectItemWithSelectObject:self.selectObject ScrollView:self];
    }
   
}


@end
