//
//  SPHuoDongViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "HuoDongModel.h"
#import "SPHuoDongCell.h"
#import "SPHuoDongMoreViewController.h"
#import "SPHuoDongViewController.h"

@interface SPHuoDongViewController ()

@property(strong ,nonatomic) NSMutableArray *dataArray;

@end

@implementation SPHuoDongViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBarController.tabBar.hidden =YES;
    self.navigationItem.title =@"活动专区";
    self.tableView.bounces =NO;
    
    [self getData];
    
    
}
-(void)getData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KSPHuoDong_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       NSArray *imgArray = BigDict[@"data"];
        
        for (NSDictionary *dict  in imgArray) {
            HuoDongModel *model =[HuoDongModel mj_objectWithKeyValues:dict];
            [self.dataArray addObject:model];
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"活动专区页----- 请求失败");
    }];


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
    return 190;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"UITableViewCell";
    
    SPHuoDongCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SPHuoDongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    cell.model =self.dataArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPHuoDongMoreViewController *more =[[SPHuoDongMoreViewController alloc]init];
    [self.navigationController pushViewController:more animated:YES];
}

@end
