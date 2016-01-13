//
//  MatchXuZhiController.m
//  WildTo
//
//  Created by 千锋 on 16/1/7.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import "MatchXuZhiController.h"

@interface MatchXuZhiController ()<UIWebViewDelegate>

//@property(strong ,nonatomic) UIActivityIndicatorView *indicator;

@property (strong ,nonatomic)UIWebView *webView;

@end

@implementation MatchXuZhiController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *urlStr =@"http://www.wildto.com/m/event_intro/event?id=857";
    NSURL *url =[NSURL URLWithString:urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height -64)];
    
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    view.backgroundColor =[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1];
    [self.view addSubview:view];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.center =CGPointMake(self.view.bounds.size.width*0.5, 22);
    label.textColor= [UIColor blackColor];
    label.text =@"赛事须知";
    label.font =[UIFont boldSystemFontOfSize:16];
    [view addSubview:label];
    
    UIButton *backBtn =[[UIButton alloc]init];
    backBtn.frame =CGRectMake(5, 13, 72, 18);
    [backBtn setImage:[UIImage imageNamed:@"btn_back_unpress"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    
}
-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [[[UIAlertView alloc]initWithTitle:@"网络异常" message:error.localizedDescription delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
    
    
}




@end
