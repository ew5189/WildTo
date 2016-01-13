//
//  GroupSearchViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
#import "Define.h"
#import "AFNetworking.h"
#import "MoneySearchModel.h"
#import "MoneySearchCell.h"
#import "GroupSearchViewController.h"

@interface GroupSearchViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(strong ,nonatomic) UITableView *tableView;

@property(strong ,nonatomic) NSMutableArray *dataArray;

@end

@implementation GroupSearchViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"组别列表";
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds =CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:@"btn_back_unpress_white"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:button];
    
    [self creatTableView];
    
    //请求数据
    [self getData];
    
}

-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KGroupList_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *mArr =BigDict[@"data"];
        for (NSDictionary *dict in mArr) {
            MoneySearchModel *model =[MoneySearchModel searchWithDict:dict];
            [self.dataArray addObject:model];
            
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"组别查询--请求失败");
    }];
    
}

-(void)creatTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, ScreenH-20) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    [self.view addSubview:_tableView];
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
    
    MoneySearchCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[MoneySearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    [cell setModel:self.dataArray[indexPath.row]];
    
    return cell;
}


@end
