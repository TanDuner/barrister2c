//
//  BaseSegmentViewController.m
//  WXD
//
//  Created by Fantasy on 12/24/14.
//  Copyright (c) 2014 JD.COM. All rights reserved.
//

#import "BaseSegmentViewController.h"
#import "TabItemView.h"

#define kTabHeight          40
static const NSInteger kTagOffset = 1000;


@interface BaseSegmentViewController ()

@end

@implementation BaseSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.tabsArray = [[NSMutableArray alloc] init];
    self.vcArray = [[NSMutableArray alloc] init];
    
    [self configure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)configure
{
    [self initViewControllers];
    [self initTabViewContainerView];
    [self initTabButtons];
    
    if (self.selectedIndex < 0 || self.selectedIndex >= _vcArray.count)
        self.selectedIndex = 0;
    [self selectTabIndex:0 animated:NO];
}

#pragma mark -
#pragma mark - Initialize TabView

- (void)initTabViewContainerView
{
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, kTabHeight);
    
    _tabScrollView = [[UIScrollView alloc] initWithFrame:rect];
    _tabScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tabScrollView.backgroundColor = [UIColor whiteColor];
    _tabScrollView.showsHorizontalScrollIndicator = NO;
    _tabScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tabScrollView];
    
    rect.origin.y = kTabHeight;
    rect.size.height = self.view.bounds.size.height - kTabHeight;
    self.contentView = [[UIView alloc] initWithFrame:rect];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.contentView];
}

- (void)initTabButtons
{
    NSUInteger index = 0;
    
    CGFloat width = self.view.bounds.size.width / 2;
    CGRect rect = CGRectMake(0, 0, width, kTabHeight);
    
    for (NSString *title in _tabsArray)
    {
        TabItemView *tabItem = [[TabItemView alloc] initWithFrame:rect handel:^(TabItemView *tabItem) {
            [self tabItemClick:tabItem];
        }];
        tabItem.tag = kTagOffset + index;
        tabItem.tabTitle = title;
        [self.tabScrollView addSubview:tabItem];
        
        rect.origin.x += rect.size.width;
        ++index;
    }
}

- (void)initViewControllers
{
    for (UIViewController *vc in _vcArray) {
        vc.view.frame = self.contentView.bounds;
        [self addChildViewController:vc];
    }
}

#pragma mark -
#pragma mark - TabView Switch action

- (void)selectTabIndex:(NSInteger)index animated:(BOOL)animated
{
    TabItemView *tabItemTo = [self tabItemAtIndex:index];
    if (!tabItemTo || tabItemTo.selected)
        return;
    
    UIViewController *vcTo = [self viewControllerAtIndex:index];
    if (!vcTo)
        return;
    
    TabItemView *tabItemFrom = [self tabItemAtIndex:_selectedIndex];
    UIViewController *vcFrom = [self viewControllerAtIndex:self.selectedIndex];
    
    BOOL bAnimated = animated;
    if (vcFrom == nil)
        bAnimated = NO;
    
    if (bAnimated)
    {
        CGRect rect = self.contentView.bounds;
        if (self.selectedIndex < index)
            rect.origin.x = rect.size.width;
        else
            rect.origin.x = -rect.size.width;
        
        vcTo.view.frame = rect;
        self.tabScrollView.userInteractionEnabled = NO;
        
        [self transitionFromViewController:vcFrom toViewController:vcTo duration:0.3f options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut animations:^{
            
            CGRect rect = vcFrom.view.frame;
            if (self.selectedIndex < index)
                rect.origin.x = -rect.size.width;
            else
                rect.origin.x = rect.size.width;
            
            vcFrom.view.frame = rect;
            CGRect frame = self.contentView.bounds;
            vcTo.view.frame = frame;
        }
                                completion:^(BOOL finished)
         {
             self.tabScrollView.userInteractionEnabled = YES;
         }];
    }
    else
    {
        // Don't animated
        [vcFrom.view removeFromSuperview];
        vcTo.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vcTo.view];
    }
    
    if (tabItemFrom)
        [self unselectTabItem:tabItemFrom];
    [self selectTabItem:tabItemTo];
    
    _selectedIndex = index;
    
    [self scrollToCurrentTab];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index
{
    if (self.vcArray && 0 <= index && index < self.vcArray.count)
        return [self.vcArray safeObjectAtIndex:index];
    
    return nil;
}

- (TabItemView *)tabItemAtIndex:(NSInteger)index
{
    return (TabItemView *)[self.tabScrollView viewWithTag:kTagOffset + index];
}

#pragma mark -
#pragma mark - TabItemView tap action

- (void)tabItemClick:(TabItemView *)tabItem
{
    NSInteger index = tabItem.tag - kTagOffset;
    [self selectTabIndex:index animated:YES];
}

#pragma mark -
#pragma mark - select / unselect

- (void)selectTabItem:(TabItemView *)item
{
    [item setSelected:YES];
}

- (void)unselectTabItem:(TabItemView *)item
{
    [item setSelected:NO];
}

#pragma mark -
#pragma mark - scroll to center

- (void)scrollToCurrentTab
{
    TabItemView *tabItem = [self tabItemAtIndex:self.selectedIndex];
    CGRect frame = tabItem.frame;
    frame.origin.x += (frame.size.width / 2);
    frame.origin.x -= self.tabScrollView.frame.size.width / 2;
    frame.size.width = self.tabScrollView.frame.size.width;
    
    if (frame.origin.x < 0)
    {
        frame.origin.x = 0;
    }
    
    if ((frame.origin.x + frame.size.width) > self.tabScrollView.contentSize.width) {
        frame.origin.x = (self.tabScrollView.contentSize.width - self.tabScrollView.frame.size.width);
    }
    [self.tabScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark -
#pragma mark - Data



@end
