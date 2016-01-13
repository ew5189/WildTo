//
//  SPChartViewController.m
//  WildTo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
//
#import "Define.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "SPChartModel.h"
#import "SPChartCell.h"
#import "SPChartViewController.h"

@interface SPChartViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong ,nonatomic) UITableView *tableView;

@property(strong ,nonatomic) UIScrollView *top1ScrollView;
@property(strong ,nonatomic) UIScrollView *top2ScrollView;
@property(strong ,nonatomic) UIScrollView *top3ScrollView;
@property(strong ,nonatomic) UIScrollView *top4ScrollView;

@property(strong ,nonatomic) NSMutableArray *dataArray;
@end

@implementation SPChartViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"积分规则" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarBtn)];
    self.navigationItem.rightBarButtonItem.tintColor =[UIColor blackColor];
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 32, 32);
    
    [button setImage:[UIImage imageNamed:@"club_search@2x"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:button];
    
    [self creatTableView];
    [self creatTableHeaderView];
    
    [MBProgressHUD showMessage:@"努力加载中。。"];
    
    //请求排行榜数据
    [self getData];
}


-(void)getData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:KSPChart_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSArray *mArr = BigDict[@"data"];
       
        for (NSDictionary *dict in mArr) {
            
            SPChartModel *model =[SPChartModel mj_objectWithKeyValues:dict];
            
            [self.dataArray addObject:model];
        }
        
        [MBProgressHUD hideHUD];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"排行榜请求失败");
        [MBProgressHUD hideHUD];
        
    }];
    
}
-(void)creatTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-49) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    

}

-(void)creatTableHeaderView
{
    UIView *view  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 110)];
    view.backgroundColor =[UIColor clearColor];
    _tableView.tableHeaderView =view;
    
    //top1滚动
    _top1ScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    _top1ScrollView.delegate =self;
    _top1ScrollView.tag =101;
    _top1ScrollView.showsHorizontalScrollIndicator =NO;
    _top1ScrollView.showsVerticalScrollIndicator =NO;
    [_top1ScrollView setBackgroundColor:[UIColor colorWithRed:117/255.0f green:190/255.0f blue:68/255.0f alpha:1]];
    [view addSubview:_top1ScrollView];
    
    NSArray *top1Arr =@[@"赛事积分",@"里程"];
    for (int i =0; i<2; i++) {
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        label.center =CGPointMake(ScreenW*0.5+i*ScreenW*0.4, label.frame.size.height*0.5);
        label.text =top1Arr[i];
        label.font =[UIFont boldSystemFontOfSize:14];
        label.textColor =[UIColor whiteColor];
        
        [_top1ScrollView addSubview:label];
        
    }
    _top1ScrollView.contentSize =CGSizeMake(ScreenW*1.35, 0);
    
    //top2滚动
    
    _top2ScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, _top1ScrollView.frame.size.height, ScreenW, _top1ScrollView.frame.size.height-5)];
    _top2ScrollView.delegate =self;
    _top2ScrollView.showsVerticalScrollIndicator =NO;
    _top2ScrollView.showsHorizontalScrollIndicator =NO;
    _top2ScrollView.tag =102;
  
    [view addSubview:_top2ScrollView];
    
    UIImageView *top2View =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, _top2ScrollView.frame.size.height)];
    top2View.center =CGPointMake(ScreenW*0.5, _top2ScrollView.frame.origin.y+10);
    top2View.image =[UIImage imageNamed:@"board_bg_secend.9"];
    top2View.alpha =0.5;
    [_tableView addSubview:top2View];


    NSArray *top2Arr =@[@"好友",@"男",@"女",@"车队"];
    
    for (int i=0; i<4; i++) {
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, _top2ScrollView.frame.size.height)];
        label.center =CGPointMake(ScreenW*0.5+i*ScreenW*0.3, label.frame.size.height*0.5);
        label.text =top2Arr[i];
        label.font =[UIFont systemFontOfSize:12];
        label.textColor =[UIColor blackColor];
        [_top2ScrollView addSubview:label];
        
    }
    _top2ScrollView.contentSize =CGSizeMake(ScreenW*1.9, 0);
    
    //top3滚动
    _top3ScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_top2ScrollView.frame), ScreenW, _top1ScrollView.frame.size.height-5)];
    _top3ScrollView.delegate =self;
    _top3ScrollView.tag =103;
    _top3ScrollView.showsHorizontalScrollIndicator =NO;
    _top3ScrollView.showsVerticalScrollIndicator =NO;
    _top3ScrollView.backgroundColor =[UIColor colorWithRed:218/255.0f green:218/255.0f blue:218/255.0f alpha:1];
    [view addSubview:_top3ScrollView];
    
    UITextField *text =[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    text.enabled =NO;
    text.alpha =0.5;
    text.center =CGPointMake(ScreenW*0.5, _top3ScrollView.frame.origin.y+10);
    text.background =[UIImage imageNamed:@"board_bg_4.9"];
    [_tableView addSubview:text];
    
    NSArray *top3Arr =@[@"公路",@"山地",@"速降",@"小轮"];
    for (int i=0; i<4; i++) {
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, _top3ScrollView.frame.size.height-5)];
        label.center =CGPointMake(ScreenW*0.5+i*ScreenW*0.18, label.frame.size.height*0.5);
        label.text =top3Arr[i];
        label.font =[UIFont systemFontOfSize:12];
        label.textColor =[UIColor blackColor];
        [_top3ScrollView addSubview:label];
        
    }
    _top3ScrollView.contentSize =CGSizeMake(ScreenW*1.53, 0);
    
    //top4
    _top4ScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_top3ScrollView.frame), ScreenW, 25)];
    _top4ScrollView.delegate =self;
    _top4ScrollView.showsHorizontalScrollIndicator =NO;
    _top4ScrollView.showsVerticalScrollIndicator =NO;
    _top4ScrollView.backgroundColor =[UIColor colorWithRed:205/255.0f green:205/255.0f blue:205/255.0f alpha:1];
    [view addSubview:_top4ScrollView];
    
    NSArray *top4Arr =@[@"全国",@"陕西省",@"其他地区"];
    for (int i=0; i<3; i++) {
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, _top4ScrollView.frame.size.height-5)];
        label.center =CGPointMake(ScreenW*0.5+i*ScreenW*0.25, label.frame.size.height*0.5);
        label.text =top4Arr[i];
        label.font =[UIFont systemFontOfSize:12];
        label.textColor =[UIColor blackColor];
        [_top4ScrollView addSubview:label];

    }
     _top4ScrollView.contentSize =CGSizeMake(ScreenW*1.5, 0);
    
}

-(void)clickRightBarBtn
{
    NSLog(@"积分规则");
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"UITableViewCell";
    
    SPChartCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SPChartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    cell.model =self.dataArray[indexPath.row];
    
    return cell;
}

@end
