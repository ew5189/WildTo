//
//  SPDiscoverViewController.m
//  WildTo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
//
#import "Define.h"
#import "SPDiscoverViewController.h"
#import "UIImageView+WebCache.h"
#import "SPCommonItem.h"
#import "SPCommonGroup.h"
#import "RideCircleViewController.h"
#import "SPZiXunViewController.h"
#import "SPShiPinViewController.h"
#import "SPHuoDongViewController.h"
#import "DiscoverTableViewCell.h"

@interface SPDiscoverViewController ()

@property(strong ,nonatomic) UIImageView *imageView;
@property(strong ,nonatomic) UIPageControl *pageControl;
@property(strong ,nonatomic) UIView *pageControlBackView;

@property(strong ,nonatomic) NSMutableArray *groups;

@end

@implementation SPDiscoverViewController
/**
 用一个模型来描述每组的信息：组头、组尾、这组的所有行模型
 用一个模型来描述每行的信息：图标、标题、子标题、右边的样式（箭头、文字、数字、开关、打钩）
 */
-(NSMutableArray *)groups
{
    if (_groups ==nil) {
        _groups =[NSMutableArray array];
    }
    return _groups;
}

-(instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent =YES;
    self.tableView.showsHorizontalScrollIndicator =NO;
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.bounces =NO;
    self.tableView.sectionHeaderHeight =3;
    self.tableView.sectionFooterHeight =3;
    self.tableView.backgroundColor =[UIColor colorWithRed:208/255.0f green:208/255.0f blue:208/255.0f alpha:0.6];
    [self creatTableHeaderView];
    [self creatPageControl];
    [self creatTableHeaderViewLabel];
    
    //初始化模型
    [self setupGroups];
    
}
-(void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];

}
-(void)setupGroup0
{
//   1， 创建组
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groups addObject:group];
    
//    2,设置组头 组尾
    //3，设置组的所有行数据
    SPCommonItem *quan =[SPCommonItem itemWithTitle:@"骑行圈" icon:@"icon_faxian_dongtai"];
    group.items =@[quan];
}

-(void)setupGroup1
{
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groups addObject:group];
    
    SPCommonItem *zixun =[SPCommonItem itemWithTitle:@"资讯" icon:@"icon_faxian_zixun"];
    group.items =@[zixun];

}

-(void)setupGroup2
{
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groups addObject:group];
    
    SPCommonItem *shipin =[SPCommonItem itemWithTitle:@"视频" icon:@"icon_shipin"];
    group.items =@[shipin];
    
}
-(void)setupGroup3
{
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groups addObject:group];
    
    SPCommonItem *huodong =[SPCommonItem itemWithTitle:@"活动专区" icon:@"icon_activities"];
    group.items =@[huodong];


}
-(void)setupGroup4
{
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groups addObject:group];
    
    SPCommonItem *fujin =[SPCommonItem itemWithTitle:@"附近车队" icon:@"icon_nearteam"];
    group.items =@[fujin];
    
}

-(void)creatTableHeaderViewLabel
{
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(3, 0, ScreenW*0.7, 15)];
    label.text =@"青海卫视.野途 2015中国自行车运动年度盛典";
    label.textColor =[UIColor whiteColor];
    label.font =[UIFont systemFontOfSize:10];
    [_pageControlBackView addSubview:label];
}

-(void)creatTableHeaderView
{
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 140)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.wildto.com//images//index//banner_01_sd02.jpg"]];
    self.tableView.tableHeaderView =_imageView;
    
}

-(void)creatPageControl
{
    _pageControlBackView =[[UIView alloc]initWithFrame:CGRectMake(0, _imageView.bounds.size.height -15, ScreenW, 15)];
    _pageControlBackView.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [self.tableView addSubview:_pageControlBackView];
    
    _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.8, 0, ScreenW*0.2, 15)];
    _pageControl.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl.numberOfPages =1;
    [_pageControlBackView addSubview:_pageControl];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        SPCommonGroup *group =self.groups[section];
        return group.items.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverTableViewCell *cell =[DiscoverTableViewCell cellWithTableView:tableView];
    SPCommonGroup *group =self.groups[indexPath.section];
    cell.item =group.items[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            
            RideCircleViewController *rideCircle =[[RideCircleViewController alloc]init];
            [self.navigationController pushViewController:rideCircle animated:YES];
            break;}
        case 1:{
            SPZiXunViewController *zixun =[[SPZiXunViewController alloc]init];
            [self.navigationController pushViewController:zixun animated:YES];
            break;}
        case 2:{
            SPShiPinViewController *shipin =[[SPShiPinViewController alloc]init];
            [self.navigationController pushViewController:shipin animated:YES];
            
            break;}
        case 3:{
            SPHuoDongViewController *huodong =[[SPHuoDongViewController alloc]init];
            [self.navigationController pushViewController:huodong animated:YES];
            
            break;}
        case 4:
            NSLog(@"附近车队");
            break;
            
        default:
            break;
    }
    

}


@end
