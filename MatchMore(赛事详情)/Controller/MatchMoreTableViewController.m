//
//  MatchMoreTableViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "MatchMoreDataList.h"
#import "News_Detail.h"
#import "SPPhoto.h"
#import "MatchMoreCell.h"
#import "MatchXuZhiController.h"
#import "MoneySearchViewController.h"
#import "GroupSearchViewController.h"
#import "MatchMoreTableViewController.h"

@interface MatchMoreTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong ,nonatomic) UITableView *tableView;
@property(strong ,nonatomic) UIImageView *tableHeaderView;

@property(strong ,nonatomic) UIView *navbar;
@property(strong ,nonatomic) UIButton *backBtn;
@property(strong ,nonatomic) UILabel *navLabel;
@property(strong ,nonatomic) UIButton *navLeftButton;
@property(strong ,nonatomic) UIButton *navRightButton;

@property(strong ,nonatomic) UIImageView *bgImage;
//模型数组
@property(strong ,nonatomic) NSMutableArray *dataArray;
@property(strong ,nonatomic) NSMutableDictionary *dataDict;

@end

@implementation MatchMoreTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTableView];
    [self creatTableHeaderView];
    [self creatNavBar];
    [self creatNavLabel];
    [self creatNavLeftButton];
    [self creatNavRightButton];
    
    [MBProgressHUD showMessage:@"正在为您加载。。"];
    //请求数据
    [self creatMatchMoreData];
    
    
}



-(void)creatMatchMoreData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:KMore_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.dataDict = [[NSMutableDictionary alloc]initWithDictionary:BigDict[@"data"]];
        
        [MBProgressHUD hideHUD];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"详情。。请求错误");
    }];


}

-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}


-(void)creatNavRightButton
{
    _navRightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _navRightButton.frame =CGRectMake(ScreenW -30, 13, 20, 15);
    [_navRightButton setImage:[UIImage imageNamed:@"ic_new_share_unpress"] forState:UIControlStateNormal];
    [_navRightButton addTarget:self action:@selector(pressRightNavBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_navbar addSubview:_navRightButton];

}

-(void)creatNavLeftButton
{
    
    _navLeftButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _navLeftButton.frame =CGRectMake(10, 13, 15, 20);
    [_navLeftButton setImage:[UIImage imageNamed:@"icon_go_right.png"] forState:UIControlStateNormal];
    [_navLeftButton addTarget:self action:@selector(pressLeftNavBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_navbar addSubview:_navLeftButton];
}

-(void)pressLeftNavBtn:(UIButton *)button
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)pressRightNavBtn:(UIButton *)button
{
    NSLog(@"share....");

}

-(void)creatNavLabel
{
    _navLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    _navLabel.center =CGPointMake(ScreenW*0.5, 44*0.5);
    _navLabel.text =@"赛事详情";
    _navLabel.textAlignment =NSTextAlignmentCenter;
    _navLabel.font =[UIFont systemFontOfSize:14];
    [_navbar addSubview:_navLabel];
}
-(void)creatNavBar
{
    _navbar =[[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, 44)];
    _navbar.backgroundColor =[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    _navbar.alpha =0;
    [self.view addSubview:_navbar];
    
    _backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame =CGRectMake(10, 33, 25, 25);
    [_backBtn setImage:[UIImage imageNamed:@"btn_back_unpress_white"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
}
-(void)clickBack:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)creatTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, ScreenH-20) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
   
    _tableView.userInteractionEnabled =YES;
    _tableView.sectionFooterHeight =5;
    _tableView.sectionHeaderHeight =5;
    [self.view addSubview:_tableView];
    
}

-(void)creatTableHeaderView
{
    _tableHeaderView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, 140)];
    [_tableHeaderView sd_setImageWithURL:[NSURL URLWithString:@"http://www.wildto.com//images//index//banner_01_sd02.jpg"]];
    self.tableView.tableHeaderView =_tableHeaderView;
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 180;
    }
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *reuseID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    //容错，预防刚进入 字典为空
    if (_dataDict ==nil) {
        return cell;
    }
    if (indexPath.section ==0) {
        //点击cell 不变色
        cell.selectionStyle =UITableViewCellAccessoryNone;
        
        [self addLabelWithTitle:_dataDict[@"name"] rect:CGRectMake(5, 10, ScreenW-20, 40) font:[UIFont boldSystemFontOfSize:15] color:[UIColor blackColor] cell:cell];
        [self addLabelWithTitle:@"赛事级别：" rect:CGRectMake(5, 50, 60, 15) font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor] cell:cell];
        [self addLabelWithTitle:[self setEventLevel_text:_dataDict[@"event_level"]] rect:CGRectMake(70, 50, ScreenW-70, 15) font:[UIFont systemFontOfSize:12] color:[UIColor blackColor] cell:cell];
        [self addLabelWithTitle:@"主 办 方：" rect:CGRectMake(5, 70, 60, 15) font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor] cell:cell];
        [self addLabelWithTitle:_dataDict[@"organizer"] rect:CGRectMake(68, 70, ScreenW-70, 15) font:[UIFont systemFontOfSize:12] color:[UIColor blackColor] cell:cell];
        [self addLabelWithTitle:@"赛事时间：" rect:CGRectMake(5, 90, 60, 15) font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor] cell:cell];
        
        [self addLabelWithTitle:[NSString stringWithFormat:@"%@-%@",_dataDict[@"apply_begin_time"],_dataDict[@"apply_end_time"]] rect:CGRectMake(68, 90, ScreenW-75, 15) font:[UIFont systemFontOfSize:12] color:[UIColor blackColor] cell:cell];
        [self addLabelWithTitle:@"报名时间：" rect:CGRectMake(5, 110, 60, 15) font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor] cell:cell];
        [self addLabelWithTitle:[NSString stringWithFormat:@"%@-%@",_dataDict[@"event_begin_time"],_dataDict[@"event_end_time"]] rect:CGRectMake(68, 110, ScreenW-75, 15) font:[UIFont systemFontOfSize:12] color:[UIColor blackColor] cell:cell];
        [self addLabelWithTitle:@"赛事地点：" rect:CGRectMake(5, 130, 60, 15) font:[UIFont systemFontOfSize:12] color:[UIColor grayColor] cell:cell];
        [self addLabelWithTitle:_dataDict[@"address"] rect:CGRectMake(68, 122, ScreenW -75, 30) font:[UIFont systemFontOfSize:12] color:[UIColor blackColor] cell:cell];
    }
    if (indexPath.section ==1) {
        cell.selectionStyle =UITableViewCellAccessoryNone;
        
        NSArray *mArr =@[@"赛事须知",@"奖金查询",@"组别查询",@"成绩查询"];
        CGFloat leftSpace =(ScreenW-200)/3/2;
        CGFloat space =(ScreenW-200-2*leftSpace)/3;
        for (int i =0; i<4; i++) {
       
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(15+i*(50+space), 15, 50, 50);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_event_%02d",i+1]] forState:UIControlStateNormal];
            [button addTarget:self  action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag =100+i;
        [cell.contentView addSubview:button];
            
            UILabel *label =[[UILabel alloc]init];
            label.frame =CGRectMake(15+i*(50+space), 60, 55, 50);
            label.text =mArr[i];
            label.font =[UIFont systemFontOfSize:13];
            label.textColor  =[UIColor blackColor];
            [cell.contentView addSubview:label];
            if (i==3) {
                label.enabled =NO;
            }

         }
        
    }
    
    
    
    return cell;
}

-(void)pressButton:(UIButton *)button
{
    switch (button.tag) {
        case 100:{
            MatchXuZhiController *xuzhi =[[MatchXuZhiController alloc]init];
            [self presentViewController:xuzhi animated:NO completion:nil];
        
        break;}
        case 101:{
            MoneySearchViewController *moneySearch =[[MoneySearchViewController alloc]init];
            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:moneySearch];
            [self presentViewController:nav animated:NO completion:nil];
            break;}

        case 102:{
            GroupSearchViewController *groupSearch =[[GroupSearchViewController alloc]init];
            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:groupSearch];
            [self presentViewController:nav animated:YES completion:nil];
            break;}

    
        default:
            break;
    }
}

#pragma mark  监听tableView滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView.contentOffset.y>30) {
        [UIView animateWithDuration:0.8 animations:^{
            _navbar.alpha =1;
            _backBtn.alpha =0;
        }];
    }else
    {
        [UIView animateWithDuration:0.8 animations:^{
            _navbar.alpha =0;
            _backBtn.alpha =1;
        }];
    }
    
    }

-(void)addLabelWithTitle:(NSString *)title rect:(CGRect)rect font:(UIFont *)font color:(UIColor *)color cell:(UITableViewCell *)cell
{
    UILabel *label =[[UILabel alloc]initWithFrame:rect];
    label.text =title;
    label.font =font;
    label.textColor =color;
    label.numberOfLines =0;
    [cell.contentView addSubview:label];

}

-(NSString *)setEventLevel_text:(NSString *)event_level
{
    switch ([event_level intValue]) {
        case 1:
            return [NSString stringWithFormat:@"A级"];
            break;
        case 2:
            return [NSString stringWithFormat:@"B级"];
            break;
            
        case 3:
            return [NSString stringWithFormat:@"C级"];
            break;
        case 4:
            return [NSString stringWithFormat:@"D级"];
            break;
        case 0:
            return [NSString stringWithFormat:@" "];
            break;
            
        default:
            break;
    }
    
    
    return @"";
}


@end
