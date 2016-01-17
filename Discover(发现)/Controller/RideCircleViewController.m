//
//  RideCircleViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "RideCircleModel.h"
#import "RideCircleFrame.h"
#import "RideCircleCell.h"
#import "RideCircleViewController.h"

@interface RideCircleViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong ,nonatomic) UITableView *tableView;
//@property(strong ,nonatomic) NSArray *dataArray;
@property(strong ,nonatomic) NSMutableArray *dataFrameArray;

@end

@implementation RideCircleViewController

-(NSMutableArray *)dataFrameArray
{
    if (_dataFrameArray ==nil) {
        _dataFrameArray =[NSMutableArray array];
    }
    return _dataFrameArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"骑行圈";
    
    [MBProgressHUD showMessage:@"正在为您加载.."];

    [self creatTableView];
    
    [self getData];
    
}

-(void)getData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KRideCircle parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *mArr =BigDict[@"data"];
        
        NSMutableArray *frameArray =[NSMutableArray array];
        for (NSDictionary *dict in mArr) {
            
            RideCircleModel *model =[RideCircleModel circleWithDict:dict];
            RideCircleFrame *circleFrame =[[RideCircleFrame alloc]init];
            
            [circleFrame setModel:model];
            
            [frameArray addObject:circleFrame];
            
        }
        self.dataFrameArray =frameArray;
         [MBProgressHUD hideHUD];
     
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求错误");
        [MBProgressHUD hideHUD];
    }];
    
    
}


-(void)creatTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-44) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    [self.view addSubview:_tableView];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataFrameArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RideCircleFrame *circleFrame =self.dataFrameArray[indexPath.row];
    return circleFrame.cellHeight;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"UITableViewCell";
    
    RideCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[RideCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    cell.circleFrame =self.dataFrameArray[indexPath.row];
    
    return cell;
    
}


@end
