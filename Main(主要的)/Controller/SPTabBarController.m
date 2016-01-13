//
//  SPTabBarController.m
//  WildTo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
#import "Define.h"
#import "HomeViewController.h"
#import "SPChartViewController.h"
#import "SPDiscoverViewController.h"
#import "SPMineViewController.h"
#import "SPTabBarController.h"
#import "SPTabBar.h"
#import "SPTrackViewController.h"

@interface SPTabBarController ()<UITabBarControllerDelegate>

{
    SPTrackViewController *_track;
}

@end

@implementation SPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *home =[[HomeViewController alloc]init];
    [self addOneChildVc:home andTitle:@"赛事" andImageName:@"tab_match_unpress" andSelectedImage:@"tab_match_press"];
    
    SPChartViewController *chart =[[SPChartViewController alloc]init];
    [self addOneChildVc:chart andTitle:@"排行榜" andImageName:@"tab_msg_unpress" andSelectedImage:@"tab_msg_press"];

    
    SPDiscoverViewController *discover =[[SPDiscoverViewController alloc]init];
    [self addOneChildVc:discover andTitle:@"发现" andImageName:@"tab_info_unpress" andSelectedImage:@"tab_info_press"];
    
    SPMineViewController *mine =[[SPMineViewController alloc]init];
    [self addOneChildVc:mine andTitle:@"我的" andImageName:@"tab_mine_unpress" andSelectedImage:@"tab_mine_press"];
    
    //调整tabBar
    SPTabBar *customTabBar =[[SPTabBar alloc]init];
    
    //更换系统自带的tabBar
    [self setValue:customTabBar forKey:@"tabBar"];
    
    //设置代理
    self.delegate =self;
    //怎么改searchBar的背景图片？ok
    //当track按钮被点击之后，传入block
    _track =[[SPTrackViewController alloc]init];
    UINavigationController *nav1 =[[UINavigationController alloc]initWithRootViewController:_track];

    
    [customTabBar clickTrackButton:^(SPTrackViewController *track) {
    
        _track =track;
    [self presentViewController:nav1 animated:NO completion:nil];
        

    }];
    
}

-(void)addOneChildVc:(UIViewController *)childVc andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectedImage:(NSString *)selectedImage
{
    
    childVc.tabBarItem.image =[UIImage imageNamed:imageName];
    childVc.title =title;
    //设置选中图标 不再渲染
    UIImage *selectImage =[UIImage imageNamed:selectedImage];
    if(ios7)
    {
        
        selectImage =[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage =selectImage;
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
    
}
#pragma mark tabBarControllerDelegate代理方法

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
        //强制重新布局子控件（内部会调用layoutSubViews）
    [self.tabBar setNeedsLayout];
}

@end
