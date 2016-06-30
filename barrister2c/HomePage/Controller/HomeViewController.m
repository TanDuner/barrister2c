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
#import "HomeMonenyCell.h"
#import "HomeAreaCell.h"
#import "BussinessAreaModel.h"
#import "HomeTypeCell.h"
#import "LawerListViewController.h"
#import "HomeBannerModel.h"
#import "DCWebImageManager.h"
#import "BarristerLoginManager.h"

@interface HomeViewController ()

@property (nonatomic,strong) NSMutableArray *areaItems;
@property (nonatomic,strong) NSMutableArray *typeItems;
@property (nonatomic,strong) HomePageProxy *proxy;
@property (nonatomic,strong) DCPicScrollView *bannerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:YES];
    

}


#pragma -mark -------Data---------

-(void)initData
{
    self.areaItems = [NSMutableArray arrayWithCapacity:1];
    self.typeItems = [NSMutableArray arrayWithCapacity:1];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginSuccessAciton:) name:NOTIFICATION_LOGIN_SUCCESS object:nil];
    [BarristerLoginManager shareManager].showController  = self;
    [[BarristerLoginManager shareManager] userAutoLogin];

}


-(void)LoginSuccessAciton:(NSNotification *)nsnotifi
{
    [self loadData];
}


-(void)configData
{
    [self.areaItems removeAllObjects];
    [self.typeItems removeAllObjects];
    _bannerView = nil;
    [self loadData];
    
}



-(void)loadData
{
    [self.proxy getHomePageDataWithParams:nil Block:^(id returnData, BOOL success) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            [self handleDataWithDict:dict];
        }
        else
        {
            [XuUItlity showFailedHint:@"请求失败" completionBlock:nil];
        }
    }];
}

-(void)handleDataWithDict:(NSDictionary *)dict
{
    NSArray *bizAreasArray = [dict objectForKey:@"bizAreas"];
    NSArray *bizTypesArray = [dict objectForKey:@"bizTypes"];
    NSArray *bannerListArray = [dict objectForKey:@"list"];
    
    for ( int i = 0; i < bizAreasArray.count; i ++) {
        NSDictionary *dictTemp = [bizAreasArray objectAtIndex:i];
        BussinessAreaModel *model = [[BussinessAreaModel alloc] initWithDictionary:dictTemp];
        [self.areaItems addObject:model];
    }
    
    for ( int i = 0; i < bizTypesArray.count; i ++) {
        NSDictionary *dictTemp = [bizTypesArray objectAtIndex:i];
        BussinessTypeModel *model = [[BussinessTypeModel alloc] initWithDictionary:dictTemp];
        [self.typeItems addObject:model];
    }
    
    NSMutableArray *imageUrls = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < bannerListArray.count; i ++) {
        NSDictionary *dict = [bannerListArray objectAtIndex:i];
        HomeBannerModel *model = [[HomeBannerModel alloc] initWithDictionary:dict];
        [imageUrls addObject:model.image];
        [imageUrls addObject:model.image];
    }
    
    [self.tableView reloadData];
    
    [self setBannerViewWithUrls:imageUrls];

}

-(DCPicScrollView *)setBannerViewWithUrls:(NSArray *)urlStrings
{
    if (!_bannerView) {
        _bannerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140) WithImageUrls:urlStrings];
        _bannerView.placeImage = [UIImage imageNamed:@"timeline_image_loading.png"];
        
        [_bannerView setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("第%zd张图片\n",index);
        }];
        
        _bannerView.AutoScrollDelay = 2.0f;
        
        //下载失败重复下载次数,默认不重复,
        [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
        
        //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
        [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
            
        }];
        
        self.tableView.tableHeaderView = _bannerView;
        
        [self.tableView reloadData];
    }
    return _bannerView;
}



#pragma -mark ---UITableView Delegate Methods------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else if(section == 1)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headVIew = [self getLineViewWithFrame:RECT(0, 0, SCREENWIDTH, 10)];
        headVIew.backgroundColor = RGBCOLOR(239, 239, 246);
        return headVIew;
    }
    else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HomeMonenyCell *cell = [[HomeMonenyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if(indexPath.row == 1)
        {
            HomeAreaCell *areaCell = [[HomeAreaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            areaCell.items = self.areaItems;
            __weak typeof(*&self)weakSelf = self;
            areaCell.block = ^(NSInteger index)
            {
                [weakSelf toLawerListVCWithIndex:index isArea:YES];
            };
            [areaCell createAreaViews];
            return areaCell;
        }
        else
        {
            return [UITableViewCell new];
        }

    }
    else if (indexPath.section == 1) {
        HomeTypeCell *cell = [[HomeTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.items = self.typeItems;
        [cell createTypeDatas];
        __weak typeof(*&self)weakSelf = self;

        cell.block = ^(NSInteger index)
        {
            [weakSelf toLawerListVCWithIndex:index isArea:NO];
        };
        return cell;
    }
    else
    {
        return [UITableViewCell new];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [HomeMonenyCell getCellHeight];
        }
        else if (indexPath.row == 1)
        {
            return  [HomeAreaCell getCellHeightWithArray:self.areaItems];
        }
        else
        {
            return 0;
        }
    }
    else if (indexPath.section == 1)
    {
        return [HomeTypeCell getCellHeightWithArray:self.typeItems];
    }
    else
    {
        return 0;
    }
}


#pragma -mark -Action-

-(void)toLoginAction:(UIButton *)button
{
    
}


-(void)toLawerListVCWithIndex:(NSInteger)index isArea:(BOOL)isArea
{
    if (isArea) {
        LawerListViewController *lawerList = [[LawerListViewController alloc] init];
        [self.navigationController pushViewController:lawerList animated:YES];
    }
    else
    {
        LawerListViewController *lawerList = [[LawerListViewController alloc] init];
        [self.navigationController pushViewController:lawerList animated:YES];
        
    }
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
