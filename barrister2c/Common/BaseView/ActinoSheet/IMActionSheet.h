//
//  IMActionSheet.h
//  imuicomponentdemo
//
//  Created by 赵露 on 14-9-1.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IMActionSheetDelegate;

@interface IMActionSheet : UIView//UIActionSheet

@property(nonatomic,weak) id<IMActionSheetDelegate> delegate;

@property(nonatomic) UIActionSheetStyle actionSheetStyle;

@property(nonatomic,readonly) NSInteger numberOfButtons;
@property(nonatomic) NSInteger cancelButtonIndex;

@property(nonatomic) BOOL bRadioBoxMode;                 // 单选模式标志，默认为NO
@property(nonatomic) NSInteger selectedIndex;            // 单选模式时，选中的按钮索引

- (instancetype)initWithTitle:(NSString *)title delegate:(id<IMActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)showInView:(UIView *)view;

- (NSInteger)addButtonWithTitle:(NSString *)title;

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

/**
 *  按钮颜色，默认为 #ff704f
 */
@property (nonatomic, strong) UIColor * btnColor;

@end

@protocol IMActionSheetDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(IMActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)actionSheet:(IMActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)actionSheet:(IMActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end