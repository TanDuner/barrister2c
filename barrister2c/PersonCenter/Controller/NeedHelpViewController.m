//
//  NeedHelpViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "NeedHelpViewController.h"

@interface NeedHelpViewController ()

@property (nonatomic,strong) UITextField *nameTextField;

@property (nonatomic,strong) UITextField *contactTextField;

@property (nonatomic,strong) UITextField *titleTextField;

@property (nonatomic,strong) UITextField *introTextField;

@end

@implementation NeedHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要求助";
    
    [self createView];
    
}


-(void)createView
{
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(10, 10, 200, 12)];
    label.text = @"姓名";
    label.font = SystemFont(14.0f);
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    
    
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
    
}



@end
