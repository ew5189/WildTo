//
//  SPTabBar.m
//  WildTo
//tracking_unpress.9
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
#import "SPTrackViewController.h"
#import "Define.h"
#import "SPTabBar.h"
#import "SPTabBarController.h"

@interface SPTabBar()
@property(strong ,nonatomic) UIButton *bikeButton;

@end

@implementation SPTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        //添加自行车按钮
        [self addBikeButton];
        
    }
    return self;
}
-(void)addBikeButton
{
    UIButton *bikeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [bikeButton setBackgroundImage:[UIImage imageNamed:@"tracking_unpress.9"] forState:UIControlStateNormal];
    [bikeButton setImage:[UIImage imageNamed:@"tracking_unpress.9"] forState:UIControlStateNormal];
    [bikeButton setImage:[UIImage imageNamed:@"tracking_press.9"] forState:UIControlStateHighlighted];
    
    [bikeButton addTarget:self action:@selector(bikeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bikeButton];
    self.bikeButton =bikeButton;
    
}
//点击了中间按钮
-(void)bikeButtonClick
{
    SPTrackViewController *track =[[SPTrackViewController alloc]init];
    
    _block(track);
}

-(void)clickTrackButton:(clickTrackBlock)block
{
    self.block =block;
}

//布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置bikeButton的frame
    [self setupBikeButtonFrame];
    //设置所有tabbarButton的frame
    [self setupAllTabBarButtonFrame];
}
-(void)setupBikeButtonFrame
{
    self.bikeButton.bounds =CGRectMake(0, 0, self.bikeButton.currentBackgroundImage.size.width, self.bikeButton.currentBackgroundImage.size.height);
    
    self.bikeButton.center =CGPointMake(self.frame.size.width *0.5, self.frame.size.height *0.5);
}
//设置所有tabbarButton的frame
-(void)setupAllTabBarButtonFrame
{
    int index =0;
    //遍历所有的button
    for (UIView *tabBarButton  in self.subviews) {
        //如果不是UITabBarButton，直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        //根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        //遍历UITabBarButton中所有子控件
        [self setupTabBarButtonTextColor:tabBarButton atIndex:index];
        index++;
    }
    
    
}
-(void)setupTabBarButtonTextColor:(UIView *)tabBarButton atIndex:(int)index
{
    int selectedIndex =[self.items indexOfObject:self.selectedItem];
    for (UILabel *label in tabBarButton.subviews) {
        if (![label isKindOfClass:[UILabel class]]) {
            continue;
        }
        if (selectedIndex ==index) {
            label.textColor =[UIColor colorWithRed:117/255.0f green:190/255.0f blue:68/255.0f alpha:1.0];
            
        }
    }
}

//根据索引调整位置
-(void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    CGFloat buttonW =self.bounds.size.width /(self.items.count +1);
    CGFloat buttonH =self.bounds.size.height;
    
    tabBarButton.bounds =CGRectMake(0, 0, buttonW, buttonH);
    
    if (index>=2) {
        
        tabBarButton.x =buttonW *(index +1);
        
    }else{
        tabBarButton.x =buttonW *index;
    }
    tabBarButton.y =0;
}

//-(void)setupTabBarButtonTextColor:(UIView *)tabBarButton atIndex:(int)index
//{

    
//}
@end
