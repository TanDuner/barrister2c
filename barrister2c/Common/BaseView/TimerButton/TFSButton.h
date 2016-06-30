//
//  TFSButton.h
//  验证码按钮
//
//  Created by tfs_ios on 16/5/11.
//  Copyright © 2016年 tritonsfs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFSButton;


@interface TFSButton : UIButton


@property (strong, nonatomic) NSString* title_normal;

/**
 * @brief  创建一个倒计是Button并添加回调Block
 */

- (TFSButton* )initWithFrame:(CGRect)rect;


/**
 *  点击事件
 *
 *  @param btn 
 */
- (void)clickSelfBtn:(TFSButton*)btn;
@end
