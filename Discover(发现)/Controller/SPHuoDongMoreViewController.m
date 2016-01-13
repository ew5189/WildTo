//
//  SPHuoDongMoreViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "SPHuoDongMoreViewController.h"
#import "MBProgressHUD+MJ.h"

@interface SPHuoDongMoreViewController ()<UIWebViewDelegate>

@end

@implementation SPHuoDongMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent =NO;
    self.navigationItem.title =@"活动专区";
    
    
    [self creatWebView];
}

-(void)creatWebView
{
    NSString *urlStr =@"http://www.wildto.com/activity/waiting2.html";
    NSURL *url =[NSURL URLWithString:urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH )];
    
    [MBProgressHUD showMessage:@"努力加载中。。"];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

@end
