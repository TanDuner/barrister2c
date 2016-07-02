//
//  LearnCenterViewController.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LearnCenterViewController.h"
#import "LearnCenterModel.h"
#import "LearnCenterCell.h"
#import "LearnCenterProxy.h"
#import "LearnCenterChannelModel.h"
#import "LearnCenterContentView.h"
#import "NinaPagerView.h"


@interface LearnCenterViewController ()

@property (nonatomic,strong) LearnCenterProxy *proxy;

@property (nonatomic,strong) NSMutableArray *chanelItems;

@property (nonatomic,strong) NSMutableArray *titleStrArray;

@property (nonatomic,strong) NinaPagerView *slideView;


@end

@implementation LearnCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma -mark -----UI-------
-(void)createSlideView
{
    
    NSMutableArray *vcArray = [NSMutableArray array];
    for (int i = 0; i < self.titleStrArray.count; i ++) {
        if (self.chanelItems.count > i) {
            LearnCenterChannelModel *model =(LearnCenterChannelModel *)[self.chanelItems objectAtIndex:i];
            LearnCenterContentView *contentVC = [[LearnCenterContentView alloc] init];
            contentVC.chanelId = model.channelId;
            [vcArray addObject:contentVC];
        }
    }
    
    NSArray *colorArray = @[
                            kNavigationBarColor, /**< 选中的标题颜色 Title SelectColor  **/
                            KColorGray666, /**< 未选中的标题颜色  Title UnselectColor **/
                            kNavigationBarColor, /**< 下划线颜色 Underline Color   **/
                            [UIColor whiteColor], /**<  上方菜单栏的背景颜色 TopTab Background Color   **/
                            ];
    
    _slideView = [[NinaPagerView alloc] initWithTitles:self.titleStrArray WithVCs:vcArray WithColorArrays:colorArray isAlertShow:NO];
    [self.view addSubview:_slideView];

}



#pragma -mark -----Data-----

-(void)configData
{
    
    __weak typeof(*&self)weakself = self;
    [self.proxy getLearnChannelWithParams:nil block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            NSArray *items = [dict objectForKey:@"items"];
            if ([XuUtlity isValidArray:items]) {
                [weakself handleChannelDataWithArray:items];
            }else
            {
                [weakself showNoContentView];
            }

        }
        else
        {
            [XuUItlity showFailedHint:CommonNetErrorTip completionBlock:nil];
        }
    }];
}


-(void)handleChannelDataWithArray:(NSArray *)arrray
{
    for (int i = 0; i < arrray.count; i ++) {
        NSDictionary *dict = [arrray objectAtIndex:i];
        LearnCenterChannelModel *model = [[LearnCenterChannelModel alloc] initWithDictionary:dict];
        [self.chanelItems addObject:model];
        [self.titleStrArray addObject:model.title];
    }
    

    [self createSlideView];
    
}




#pragma -mark --Getter---

-(LearnCenterProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[LearnCenterProxy alloc] init];
    }
    return _proxy;
    
}

-(NSMutableArray *)chanelItems
{
    if (!_chanelItems) {
        _chanelItems = [NSMutableArray arrayWithCapacity:0];
    }
    return _chanelItems;
}

-(NSMutableArray *)titleStrArray
{
    if (!_titleStrArray) {
        _titleStrArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _titleStrArray;
}

@end
