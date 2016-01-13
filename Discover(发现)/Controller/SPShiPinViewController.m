//
//  SPShiPinViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "SPShiPinViewController.h"

@interface SPShiPinViewController ()<UIWebViewDelegate>

@end

@implementation SPShiPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"视频";
    [MBProgressHUD showMessage:@"努力加载中。。"];
    [self creatWebView];
}
-(void)creatWebView
{
    NSString *urlStr =@"http://www.wildto.com/tube/list.php";
    NSURL *url =[NSURL URLWithString:urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height -64)];
    
    [webView loadRequest:request];
    [self.view addSubview:webView];


}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD showError:@"加载失败"];
    [MBProgressHUD hideHUD];
}

@end
