//
//  NewFeatureViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/16.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "SPTabBarController.h"
#import "LoginController.h"

#import "NewFeatureViewController.h"

@interface NewFeatureViewController ()

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    imageView.image =[UIImage imageNamed:@"qidongtu.9.jpg"];
    [self.view addSubview:imageView];
    
    NSTimer *timer =nil;
    timer =[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(gotoTabBar) userInfo:nil repeats:NO];
    
    
    
}

-(void)gotoTabBar
{
    LoginController *login =[[LoginController alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:login];
    
    [self presentViewController:nav animated:NO completion:^{
        
    }];

    
}

@end
