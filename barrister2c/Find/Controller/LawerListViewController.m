//
//  LawerListViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//
#import "LawerListViewController.h"
#import "RefreshTableView.h"
#import "LawerListCell.h"
#import "IMPullDownMenu.h"
#import "LawerDetailViewController.h"

@interface LawerListViewController ()<UITableViewDataSource,UITableViewDelegate,IMPullDownMenuDelegate>

@property (nonatomic,strong) IMPullDownMenu *pullDownMenu;

@end

@implementation LawerListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configView];
}

-(void)loadItems
{

    BarristerLawerModel *model = [[BarristerLawerModel alloc] init];
    model.name = @"张大强";
    model.workingStartYear = @"1990";
    model.workYears = @"17";
    model.rating = 4.5;
    model.area = @"北京朝阳";
    model.company = @"振华律师事务所";
    model.userIcon = @"http://img4.duitang.com/uploads/item/201508/26/20150826212734_ST5BC.thumb.224_0.jpeg";
    model.goodAt = @"民事诉讼|金融|财产纠纷";

    BarristerLawerModel *model1 = [[BarristerLawerModel alloc] init];
    model1.name = @"李言";
    model1.workingStartYear = @"2008";
    model1.workYears = @"8";
    model1.rating = 3.5;
    model1.goodAt = @"经济犯罪|法律顾问|家庭";
    model1.area = @"北京丰台";
    model1.company = @"京城律师事务所";
    model1.userIcon = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=327417392,2097894166&fm=116&gp=0.jpg";

    
    
    [self.items addObject:model];
    [self.items addObject:model1];
    
    [self.tableView reloadData];
    
    [self endRefreshing];
}


-(void)loadMoreData
{

    BarristerLawerModel *model = [[BarristerLawerModel alloc] init];
    model.name = @"张大强";
    model.workingStartYear = @"1990";
    model.workYears = @"17";
    model.rating = 4.5;
    model.area = @"北京朝阳";
    model.company = @"振华律师事务所";
    model.userIcon = @"http://img4.duitang.com/uploads/item/201508/26/20150826212734_ST5BC.thumb.224_0.jpeg";
    model.goodAt = @"民事诉讼|金融|财产纠纷";
    
    BarristerLawerModel *model1 = [[BarristerLawerModel alloc] init];
    model1.name = @"李言";
    model1.workingStartYear = @"2008";
    model1.workYears = @"8";
    model1.rating = 3.5;
    model.goodAt = @"经济犯罪|法律顾问|家庭";
    model1.area = @"北京丰台";
    model1.company = @"京城律师事务所";
    model1.userIcon = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=327417392,2097894166&fm=116&gp=0.jpg";
    
    BarristerLawerModel *model2 = [[BarristerLawerModel alloc] init];
    model2.name = @"李言";
    model2.workingStartYear = @"2008";
    model2.workYears = @"8";
    model2.rating = 3.5;
    model2.goodAt = @"经济犯罪|法律顾问|家庭";
    model2.area = @"北京丰台";
    model2.company = @"京城律师事务所";
    model2.userIcon = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=327417392,2097894166&fm=116&gp=0.jpg";
    
    [self.items addObject:model];
    [self.items addObject:model1];
    [self.items addObject:model2];
    
    [self.tableView reloadData];
    
    [self endLoadMoreWithNoMoreData:NO];

}


#pragma - mark ---ConfigView

-(void)configView
{
    self.title = @"律师列表";
    
    self.pullDownMenu = [[IMPullDownMenu alloc] initWithArray:@[] frame:CGRectMake(0, 0, SCREENWIDTH, 44) viewController:self];
    self.pullDownMenu.backgroundColor = [UIColor whiteColor];
    self.pullDownMenu.delegate = self;

    NSMutableArray *sortArray = [NSMutableArray arrayWithCapacity:0];
    
    IMPullDownMenuItem *sortItem = [[IMPullDownMenuItem alloc] init];
    sortItem.unlimitedBtnText = @"不限";
    sortItem.listItemArray =  @[@"北京",@"上海",@"重庆",@"天津"];
    sortItem.title = @"地区";
    [sortArray addObject:sortItem];
    
    
    
    IMPullDownMenuItem *sortItem1 = [[IMPullDownMenuItem alloc] init];
    sortItem1.unlimitedBtnText = @"不限";
    sortItem1.listItemArray =  @[@"合同文书",@"经济纠纷",@"民事诉讼",@"财产纠纷"];
    sortItem1.title = @"领域";
    [sortArray addObject:sortItem1];
    
    IMPullDownMenuItem *sortItem2 = [[IMPullDownMenuItem alloc] init];
    sortItem2.unlimitedBtnText = @"不限";
    sortItem2.listItemArray =  @[@"合同起草和审核",@"法律文书",@"法律论证",@"案件代理"];
    sortItem2.title = @"业务";
    [sortArray addObject:sortItem2];
    
    IMPullDownMenuItem *sortItem3 = [[IMPullDownMenuItem alloc] init];
    sortItem3.unlimitedBtnText = @"不限";
    sortItem3.listItemArray =  @[@"1年以下",@"1-3年",@"3-5年",@"5年以上"];
    sortItem3.title = @"年限";
    [sortArray addObject:sortItem3];
    
    
    [self.pullDownMenu resetDataArray:sortArray];

    [self.pullDownMenu addSubview:[self getLineViewWithFrame:RECT(0, self.pullDownMenu.bounds.size.height - .5, SCREENWIDTH, .5)]];
    
    [self.view addSubview:self.pullDownMenu];
    
    
    
    
    
    [self.tableView setFrame:RECT(0, self.pullDownMenu.y + self.pullDownMenu.height, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT - self.pullDownMenu.height)];
    
    [self addRefreshHeader];
    [self addLoadMoreFooter];
    
}

#pragma -mark  --UitableVIew delegate 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"identif";
    LawerListCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[LawerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    if (self.items.count > indexPath.row) {
        BarristerLawerModel *model = [self.items objectAtIndex:indexPath.row];
        cell.model = model;
    }

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LawerListCell getCellHeight];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LawerDetailViewController *detailVC = [[LawerDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
