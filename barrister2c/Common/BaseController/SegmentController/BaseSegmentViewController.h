//
//  BaseSegmentViewController.h
//  WXD
//
//  Created by Fantasy on 12/24/14.
//  Copyright (c) 2014 JD.COM. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseSegmentViewController : BaseViewController {
@private
    
}
@property (nonatomic, strong) UIScrollView *tabScrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *vcArray;
@property (nonatomic, strong) NSArray *tabsArray;
@property (nonatomic, assign) NSInteger selectedIndex;

- (void)initTabButtons;
- (void)initViewControllers;

@end
