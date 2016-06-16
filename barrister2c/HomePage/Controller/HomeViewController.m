//
//  HomeViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/15.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "HomeViewController.h"
#import "DCPicScrollView.h"
#import "HomePageProxy.h"

@interface HomeViewController ()

@property (nonatomic,strong) NSMutableArray *areaItems;
@property (nonatomic,strong) NSMutableArray *typeItems;
@property (nonatomic,strong) HomePageProxy *proxy;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self configData];
    [self createView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:YES];
}

#pragma -mark ----UI---------

-(void)createView
{
    [self createBaseView];
}

-(void)createBaseView
{
    [self initNavigationRightTextButton:@"登录" action:@selector(toLoginAction:)];
}

-(void)createTableView
{
    NSArray *UrlStringArray = @[@"http://e.hiphotos.baidu.com/lvpics/h=800/sign=61e9995c972397ddc97995046983b216/35a85edf8db1cb134d859ca8db54564e93584b98.jpg", @"http://e.hiphotos.baidu.com/lvpics/h=800/sign=1d1cc1876a81800a71e5840e813533d6/5366d0160924ab185b6fd93f33fae6cd7b890bb8.jpg", @"http://f.hiphotos.baidu.com/lvpics/h=800/sign=8430a8305cee3d6d3dc68acb73176d41/9213b07eca806538d9da1f8492dda144ad348271.jpg", @"http://d.hiphotos.baidu.com/lvpics/w=1000/sign=81bf893e12dfa9ecfd2e521752e0f603/242dd42a2834349b705785a7caea15ce36d3bebb.jpg", @"http://f.hiphotos.baidu.com/lvpics/w=1000/sign=4d69c022ea24b899de3c7d385e361c95/f31fbe096b63f6240e31d3218444ebf81a4ca3a0.jpg"];
    
    DCPicScrollView  *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140) WithImageUrls:UrlStringArray];
    
    self.tableView.tableHeaderView = picView;
    
}

#pragma -mark -------Data---------

-(void)initData
{
    self.areaItems = [NSMutableArray arrayWithCapacity:1];
    self.typeItems = [NSMutableArray arrayWithCapacity:1];}

-(void)configData
{
    
    [self loadData];
    
}

-(void)loadData
{

    [self.proxy getHomePageDataWithParams:nil Block:^(id returnData, BOOL success) {
        if (success) {
            [self handleDataWithDict:nil];
        }
        else
        {
            [XuUItlity showFailedHint:@"请求失败" completionBlock:nil];
        }
    }];
}

-(void)handleDataWithDict:(NSMutableDictionary *)dict
{

}

#pragma -mark -Action-

-(void)toLoginAction:(UIButton *)button
{
    
}

#pragma -mark ---Proxy----

-(HomePageProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[HomePageProxy alloc] init];
    }
    return _proxy;
}



@end
