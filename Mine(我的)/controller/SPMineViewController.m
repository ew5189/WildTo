//
//  SPMineViewController.m
//  WildTo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
//
#import "SPCommonItem.h"
#import "SPCommonGroup.h"
#import "SPMineCell.h"


#import "SPMineViewController.h"

@interface SPMineViewController ()

@property(strong ,nonatomic) NSMutableArray  *groupArray;

@end

@implementation SPMineViewController

-(NSMutableArray *)groupArray
{
    if (_groupArray ==nil) {
        _groupArray =[NSMutableArray array];
    }
    return _groupArray;
}
-(instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent =NO;
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"报名资料" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBtn)];
    self.navigationItem.rightBarButtonItem.tintColor =[UIColor blackColor];
    
    self.tableView.sectionFooterHeight =3;
    self.tableView.sectionHeaderHeight =3;
    //ios7 以后用这个 去掉tableView 顶部空白
    self.automaticallyAdjustsScrollViewInsets =NO;
    //初始化模型
    [self setupGroups];

    
}

-(void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];


}
-(void)setupGroup0
{
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groupArray addObject:group];
    
    SPCommonItem *message =[SPCommonItem itemWithTitle:@"消息" icon:@"mesage"];
    SPCommonItem *newFriend =[SPCommonItem itemWithTitle:@"新的朋友" icon:@"new_friends"];
    SPCommonItem *whoCanMe =[SPCommonItem itemWithTitle:@"谁看过我" icon:@"seenme"];
    group.items =@[message,newFriend,whoCanMe];
    
    
}
-(void)setupGroup1
{
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groupArray addObject:group];
    
    SPCommonItem *myScore =[SPCommonItem itemWithTitle:@"我的成就" icon:@"ic_my_success"];
    SPCommonItem *myBaoming =[SPCommonItem itemWithTitle:@"我的报名" icon:@"ic_my_register"];
    SPCommonItem *myCarGroup =[SPCommonItem itemWithTitle:@"我的车队" icon:@"ic_my_club"];
    group.items =@[myScore,myBaoming,myCarGroup];


}
-(void)setupGroup2
{
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groupArray addObject:group];
    
    SPCommonItem *rule =[SPCommonItem itemWithTitle:@"积分规则" icon:@"ic_rank_rule"];
    SPCommonItem *social =[SPCommonItem itemWithTitle:@"社交关联" icon:@"ic_socical"];

    group.items =@[rule,social];

    
}
-(void)setupGroup3
{
    SPCommonGroup *group =[SPCommonGroup group];
    [self.groupArray addObject:group];
    
    SPCommonItem *set =[SPCommonItem itemWithTitle:@"设置" icon:@"ic_my_settings"];

    
    group.items =@[set];


}

-(void)clickRightBtn
{
    NSLog(@"报名资料");

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    
    return self.groupArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    SPCommonGroup *group =self.groupArray[section];
    return group.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"UITableViewCell";
    
    SPMineCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SPMineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    SPCommonGroup *group =self.groupArray[indexPath.section];
    cell.item =group.items[indexPath.row];
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *label =[[UILabel alloc]init];
//    label.text =@"sedsgjkl";
//    label.textAlignment =NSTextAlignmentCenter;
//    label.font =[UIFont systemFontOfSize:14];
//    
//    
//    return label;
//
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIButton *button =[UIButton buttonWithType:UIButtonTypeContactAdd];
//    return button;
//}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *str =@"hdsjklghhu";
//    return str;
//}
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    NSString *str =@"164532";
//    return str;
//}



@end
