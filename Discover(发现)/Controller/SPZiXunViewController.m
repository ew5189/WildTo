//
//  SPZiXunViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/9.
//  Copyright (c) 2016年 LSP. All rights reserved.
#define SPButtonLabelW 35

#import "AFNetworking.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
#import "MatchHeadModel.h"
#import "SPZiXunModel.h"
#import "SPZiXunCell.h"
#import "SPZiXunViewController.h"

@interface SPZiXunViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong ,nonatomic) UIScrollView *bigScrollView;

@property(strong ,nonatomic) UIScrollView *headerScroll;
@property(strong ,nonatomic) UIButton *navButton;
@property(strong ,nonatomic) UIView *shortView;
@property(strong ,nonatomic) UITableView *matchTableView;
@property(strong ,nonatomic) UITableView *tiesanTableView;
@property(strong ,nonatomic) UITableView *qiwenTableView;
@property(strong ,nonatomic) UITableView *yejieTableView;
@property(strong ,nonatomic) UITableView *chanpinTableView;
@property(strong ,nonatomic) UITableView *lvxingTableView;
@property(strong ,nonatomic) UITableView *zhishiTableView;
@property(strong ,nonatomic) UIScrollView *matchTableHeaderView;
@property(strong ,nonatomic) UIScrollView *tiesanTableHeaderView;
@property(strong ,nonatomic) UIScrollView *qiwenTableHeaderView;
@property(strong ,nonatomic) UIScrollView *yejieTableHeaderView;
@property(strong ,nonatomic) UIScrollView *chanpinTableHeaderView;
@property(strong ,nonatomic) UIScrollView *lvxingTableHeaderView;
@property(strong ,nonatomic) UIScrollView *zhishiTableHeaderView;
@property(strong ,nonatomic) NSTimer *timer1;
@property(strong ,nonatomic) NSTimer *timer2;
@property(strong ,nonatomic) NSTimer *timer3;
@property(strong ,nonatomic) NSTimer *timer4;
@property(strong ,nonatomic) NSTimer *timer5;
@property(strong ,nonatomic) NSTimer *timer6;
@property(strong ,nonatomic) NSTimer *timer7;
@property(strong ,nonatomic) UIPageControl *pageControl1;
@property(strong ,nonatomic) UIPageControl *pageControl2;
@property(strong ,nonatomic) UIPageControl *pageControl3;
@property(strong ,nonatomic) UIPageControl *pageControl4;
@property(strong ,nonatomic) UIPageControl *pageControl5;
@property(strong ,nonatomic) UIPageControl *pageControl6;
@property(strong ,nonatomic) UIPageControl *pageControl7;
@property(strong ,nonatomic) UILabel *matchHeaderLabel;
@property(strong ,nonatomic) UIView *pageControlBackView;
@property(strong ,nonatomic) UIView *pageControlBackView2;
@property(strong ,nonatomic) UIView *pageControlBackView3;
@property(strong ,nonatomic) UIView *pageControlBackView4;
@property(strong ,nonatomic) UIView *pageControlBackView5;
@property(strong ,nonatomic) UIView *pageControlBackView6;
@property(strong ,nonatomic) UIView *pageControlBackView7;
//头部广告栏模型数组
@property(strong ,nonatomic) NSMutableArray *headArray;
@property(strong ,nonatomic) NSMutableArray *headTieSanArray;
@property(strong ,nonatomic) NSMutableArray *headQiWenArray;
@property(strong ,nonatomic) NSMutableArray *headYeJieArray;
@property(strong ,nonatomic) NSMutableArray *headChanPinArray;
@property(strong ,nonatomic) NSMutableArray *headLvXingArray;
@property(strong ,nonatomic) NSMutableArray *headZhiShiArray;
@property(strong ,nonatomic) NSMutableArray *matchDataArray;
@property(strong ,nonatomic) NSMutableArray *tiesanDataArray;
@property(strong ,nonatomic) NSMutableArray *qiwenDataArray;
@property(strong ,nonatomic) NSMutableArray *yejieDataArray;
@property(strong ,nonatomic) NSMutableArray *chanpinDataArray;
@property(strong ,nonatomic) NSMutableArray *lvxingDataArray;
@property(strong ,nonatomic) NSMutableArray *zhishiDataArray;
@end

@implementation SPZiXunViewController
//icon_banner_default
//icon_default_head_rectangle.jpg

-(NSMutableArray *)headZhiShiArray
{
    if (_headZhiShiArray ==nil) {
        _headZhiShiArray =[NSMutableArray array];
    }
    return _headZhiShiArray;

}

-(NSMutableArray *)zhishiDataArray
{
    if (_zhishiDataArray ==nil) {
        _zhishiDataArray =[NSMutableArray array];
    }
    return _zhishiDataArray;

}

-(NSMutableArray *)headLvXingArray
{
    if (_headLvXingArray ==nil) {
        _headLvXingArray =[NSMutableArray array];
    }
    return _headLvXingArray;

}
-(NSMutableArray *)lvxingDataArray
{
    if (_lvxingDataArray ==nil) {
        _lvxingDataArray =[NSMutableArray array];
    }
    return _lvxingDataArray;

}

-(NSMutableArray *)headChanPinArray
{
    if (_headChanPinArray ==nil) {
        _headChanPinArray =[NSMutableArray array];
    }
    return _headChanPinArray;
}
-(NSMutableArray *)chanpinDataArray
{
    if (_chanpinDataArray ==nil) {
        _chanpinDataArray =[NSMutableArray array];
    }
    return _chanpinDataArray;

}

-(NSMutableArray *)headYeJieArray
{
    if (_headYeJieArray ==nil) {
        _headYeJieArray =[NSMutableArray array];
    }
    return _headYeJieArray;
}
-(NSMutableArray *)yejieDataArray
{
    if (_yejieDataArray ==nil) {
        _yejieDataArray =[NSMutableArray array];
    }
    return _yejieDataArray;

}

-(NSMutableArray *)headQiWenArray
{
    if (_headQiWenArray ==nil) {
        _headQiWenArray =[NSMutableArray array];
    }
    return _headQiWenArray;

}
-(NSMutableArray *)qiwenDataArray
{
    if (_qiwenDataArray ==nil) {
        _qiwenDataArray =[NSMutableArray array];
    }
    return _qiwenDataArray;

}
//matchHead数组
-(NSMutableArray *)headArray
{
    if (_headArray ==nil) {
        _headArray =[NSMutableArray array];
    }
    return _headArray;
}
-(NSMutableArray *)headTieSanArray
{
    if (_headTieSanArray ==nil) {
        _headTieSanArray =[NSMutableArray array];
    }
    return _headTieSanArray;
}
//tiesanList数组
-(NSMutableArray *)tiesanDataArray
{
    if (_tiesanDataArray ==nil) {
        _tiesanDataArray =[NSMutableArray array];
    }
    return _tiesanDataArray;
}
//matchList数组
-(NSMutableArray *)matchDataArray
{
    if (_matchDataArray ==nil) {
        _matchDataArray =[NSMutableArray array];
        
    }
    return _matchDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent =NO;
//    self.tabBarController.tabBar.hidden =YES;
    self.navigationItem.title =@"资讯";
    self.view.backgroundColor =[UIColor whiteColor];
    [self creatHomeScrollView];
    
    [self creatHeaderScroll];
    
    [MBProgressHUD showMessage:@"努力加载中。。"];
   
    //请求赛事 数据
    [self creatMatchTableView];
    [self getData];
    
    //请求铁三tableView数据
    [self creatTieSanTableView];
    [self getTieSanData];
    
    //请求骑闻tableView数据
    [self creatQiWenTableView];
    [self getQiWenData];
    
    //请求业界tableView数据
    [self creatYeJieTableView];
    [self getYeJieData];
    
    //请求产品tableView数据
    [self creatChanPinTableView];
    [self getChanPinData];
    //请求 旅行TableView数据
    [self creatLvXingTableView];
    [self getLvXingData];
    
    //请求知识 tableView数据
    [self creatZhiShiTableView];
    [self getZhiShiData];
    
}

-(void)creatZhiShiTableView
{
    _zhishiTableView =[[UITableView alloc]initWithFrame:CGRectMake(ScreenW*6, 0, ScreenW, ScreenH-104) style:UITableViewStylePlain];
    _zhishiTableView.delegate =self;
    _zhishiTableView.dataSource =self;
    _zhishiTableView.tag =1007;
    [_bigScrollView addSubview:_zhishiTableView];

}

-(void)getZhiShiData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KSPZhiShi_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *mDict = BigDict[@"data"];
        //头部广告栏数组
        NSArray *headArray =mDict[@"recommend"];
        
        for (NSDictionary *dict  in headArray) {
            MatchHeadModel *headModel =[MatchHeadModel mj_objectWithKeyValues:dict];
            [self.headZhiShiArray addObject:headModel];
            
        }
        //列表内容模型数组
        NSArray *listArray =  mDict[@"list"];
        for (NSDictionary *listDict in listArray) {
            //根据字典来创建一个模型
            SPZiXunModel *Listmodel =[SPZiXunModel mj_objectWithKeyValues:listDict];
            [self.zhishiDataArray addObject:Listmodel];
            
        }
        
        [_zhishiTableView reloadData];
        [self creatZhiShiTableHeaderView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"知识页----- 请求失败");
    }];

}

-(void)creatZhiShiTableHeaderView
{
    _zhishiTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _zhishiTableHeaderView.delegate =self;
    _zhishiTableHeaderView.pagingEnabled =YES;
    _zhishiTableHeaderView.showsHorizontalScrollIndicator =NO;
    _zhishiTableHeaderView.showsVerticalScrollIndicator =NO;
    _zhishiTableHeaderView.tag =307;
    _zhishiTableView.tableHeaderView =_zhishiTableHeaderView;
    
    int count = (int)self.headZhiShiArray.count;
    
    int i =0;
    for (i=0; i<count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        MatchHeadModel *headModel = _headZhiShiArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:headModel.image_url] placeholderImage:[UIImage imageNamed:@"icon_banner_default"]];
        
        [_zhishiTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    MatchHeadModel *headModel =_headZhiShiArray[0];
    NSString *imageStr =headModel.image_url;
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_zhishiTableHeaderView addSubview:imageView];
    i++;
    
    _zhishiTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //添加页签控制器
    _pageControlBackView7 =[[UIView alloc]initWithFrame:CGRectMake(0, _zhishiTableHeaderView.bounds.size.height - 20, ScreenW, 20)];
    _pageControlBackView7.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_zhishiTableView addSubview:_pageControlBackView7];
    
    _pageControl7 =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 20)];
    _pageControl7.center = CGPointMake(_pageControl7.center.x, _pageControlBackView7.frame.size.height/2);
    _pageControl7.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl7.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl7.numberOfPages =4;
    [_pageControlBackView7 addSubview:_pageControl7];
    
    
    //创建定时器
    [self creatZhiShiTableHeaderViewTimer];


}
-(void)creatZhiShiTableHeaderViewTimer
{
    _timer7 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer7Running) userInfo:nil repeats:YES];
    


}
-(void)timer7Running
{
    int page =_zhishiTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl7.currentPage =page;
    [_zhishiTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];

}

-(void)getLvXingData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KSPLvXing_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *mDict = BigDict[@"data"];
        //头部广告栏数组
        NSArray *headArray =mDict[@"recommend"];
        
        for (NSDictionary *dict  in headArray) {
            MatchHeadModel *headModel =[MatchHeadModel mj_objectWithKeyValues:dict];
            [self.headLvXingArray addObject:headModel];
            
        }
        //列表内容模型数组
        NSArray *listArray =  mDict[@"list"];
        for (NSDictionary *listDict in listArray) {
            //根据字典来创建一个模型
            SPZiXunModel *Listmodel =[SPZiXunModel mj_objectWithKeyValues:listDict];
            [self.lvxingDataArray addObject:Listmodel];
            
        }
        
        [_lvxingTableView reloadData];
        [self creatLvXingTableHeaderView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"旅行页----- 请求失败");
    }];
    

}
-(void)creatLvXingTableHeaderView
{
    _lvxingTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _lvxingTableHeaderView.delegate =self;
    _lvxingTableHeaderView.pagingEnabled =YES;
    _lvxingTableHeaderView.showsHorizontalScrollIndicator =NO;
    _lvxingTableHeaderView.showsVerticalScrollIndicator =NO;
    _lvxingTableHeaderView.tag =306;
    _lvxingTableView.tableHeaderView =_lvxingTableHeaderView;
    
    int count = (int)self.headLvXingArray.count;
    
    int i =0;
    for (i=0; i<count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        MatchHeadModel *headModel = _headLvXingArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:headModel.image_url] placeholderImage:[UIImage imageNamed:@"icon_banner_default"]];
        
        [_lvxingTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    MatchHeadModel *headModel =_headLvXingArray[0];
    NSString *imageStr =headModel.image_url;
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_lvxingTableHeaderView addSubview:imageView];
    i++;
    
    _lvxingTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //添加页签控制器
    _pageControlBackView6 =[[UIView alloc]initWithFrame:CGRectMake(0, _lvxingTableHeaderView.bounds.size.height - 20, ScreenW, 20)];
    _pageControlBackView6.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_lvxingTableView addSubview:_pageControlBackView6];
    
    _pageControl6 =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 20)];
    _pageControl6.center = CGPointMake(_pageControl6.center.x, _pageControlBackView6.frame.size.height/2);
    _pageControl6.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl6.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl6.numberOfPages =4;
    [_pageControlBackView6 addSubview:_pageControl6];
    
    
    //创建定时器
    [self creatLvXingTableHeaderViewTimer];

}
-(void)creatLvXingTableHeaderViewTimer
{
    _timer6 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer6Running) userInfo:nil repeats:YES];
    

}
-(void)timer6Running
{
    int page =_lvxingTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl6.currentPage =page;
    [_lvxingTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];

}

-(void)creatLvXingTableView
{
    _lvxingTableView =[[UITableView alloc]initWithFrame:CGRectMake(ScreenW*5, 0, ScreenW, ScreenH-104) style:UITableViewStylePlain];
    _lvxingTableView.delegate =self;
    _lvxingTableView.dataSource =self;
    _lvxingTableView.tag =1006;
    [_bigScrollView addSubview:_lvxingTableView];

}

-(void)creatChanPinTableView
{
    _chanpinTableView =[[UITableView alloc]initWithFrame:CGRectMake(ScreenW*4, 0, ScreenW, ScreenH-104) style:UITableViewStylePlain];
    _chanpinTableView.delegate =self;
    _chanpinTableView.dataSource =self;
    _chanpinTableView.tag =1005;
    [_bigScrollView addSubview:_chanpinTableView];

}

-(void)getChanPinData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KSPChanPin_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *mDict = BigDict[@"data"];
        //头部广告栏数组
        NSArray *headArray =mDict[@"recommend"];
        
        for (NSDictionary *dict  in headArray) {
            MatchHeadModel *headModel =[MatchHeadModel mj_objectWithKeyValues:dict];
            [self.headChanPinArray addObject:headModel];
            
        }
        //列表内容模型数组
        NSArray *listArray =  mDict[@"list"];
        for (NSDictionary *listDict in listArray) {
            //根据字典来创建一个模型
            SPZiXunModel *Listmodel =[SPZiXunModel mj_objectWithKeyValues:listDict];
            [self.chanpinDataArray addObject:Listmodel];
            
        }
        
        [_chanpinTableView reloadData];
        [self creatChanPinTableHeaderView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"产品页----- 请求失败");
    }];


}
-(void)creatChanPinTableHeaderView
{
    _chanpinTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _chanpinTableHeaderView.delegate =self;
    _chanpinTableHeaderView.pagingEnabled =YES;
    _chanpinTableHeaderView.showsHorizontalScrollIndicator =NO;
    _chanpinTableHeaderView.showsVerticalScrollIndicator =NO;
    _chanpinTableHeaderView.tag =305;
    _chanpinTableView.tableHeaderView =_chanpinTableHeaderView;
    
    int count = (int)self.headChanPinArray.count;
    
    int i =0;
    for (i=0; i<count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        MatchHeadModel *headModel = _headChanPinArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:headModel.image_url] placeholderImage:[UIImage imageNamed:@"icon_banner_default"]];
        
        [_chanpinTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    MatchHeadModel *headModel =_headChanPinArray[0];
    NSString *imageStr =headModel.image_url;
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_chanpinTableHeaderView addSubview:imageView];
    i++;
    
    _chanpinTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //添加页签控制器
    _pageControlBackView5 =[[UIView alloc]initWithFrame:CGRectMake(0, _chanpinTableHeaderView.bounds.size.height - 20, ScreenW, 20)];
    _pageControlBackView5.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_chanpinTableView addSubview:_pageControlBackView5];
    
    _pageControl5 =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 20)];
    _pageControl5.center = CGPointMake(_pageControl5.center.x, _pageControlBackView5.frame.size.height/2);
    _pageControl5.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl5.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl5.numberOfPages =4;
    [_pageControlBackView5 addSubview:_pageControl5];
    
    
    //创建定时器
    [self creatChanPinTableHeaderViewTimer];

    
}
-(void)creatChanPinTableHeaderViewTimer
{
    _timer5 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer5Running) userInfo:nil repeats:YES];
    

}
-(void)timer5Running
{
    int page =_chanpinTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl5.currentPage =page;
    [_chanpinTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];

}

-(void)creatYeJieTableView
{
    _yejieTableView =[[UITableView alloc]initWithFrame:CGRectMake(ScreenW*3, 0, ScreenW, ScreenH-104) style:UITableViewStylePlain];
    _yejieTableView.delegate =self;
    _yejieTableView.dataSource =self;
    _yejieTableView.tag =1004;
    [_bigScrollView addSubview:_yejieTableView];


}

-(void)getYeJieData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KSPYeJie_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *mDict = BigDict[@"data"];
        //头部广告栏数组
        NSArray *headArray =mDict[@"recommend"];
        
        for (NSDictionary *dict  in headArray) {
            MatchHeadModel *headModel =[MatchHeadModel mj_objectWithKeyValues:dict];
            [self.headYeJieArray addObject:headModel];
            
        }
        //列表内容模型数组
        NSArray *listArray =  mDict[@"list"];
        for (NSDictionary *listDict in listArray) {
            //根据字典来创建一个模型
            SPZiXunModel *Listmodel =[SPZiXunModel mj_objectWithKeyValues:listDict];
            [self.yejieDataArray addObject:Listmodel];
            
        }
        
        [_yejieTableView reloadData];
        [self creatYeJieTableHeaderView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"业界页----- 请求失败");
    }];


}

-(void)creatYeJieTableHeaderView
{
    _yejieTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _yejieTableHeaderView.delegate =self;
    _yejieTableHeaderView.pagingEnabled =YES;
    _yejieTableHeaderView.showsHorizontalScrollIndicator =NO;
    _yejieTableHeaderView.showsVerticalScrollIndicator =NO;
    _yejieTableHeaderView.tag =304;
    _yejieTableView.tableHeaderView =_yejieTableHeaderView;
    
    int count = (int)self.headYeJieArray.count;
    
    int i =0;
    for (i=0; i<count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        MatchHeadModel *headModel = _headYeJieArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:headModel.image_url] placeholderImage:[UIImage imageNamed:@"icon_banner_default"]];
        
        [_yejieTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    MatchHeadModel *headModel =_headYeJieArray[0];
    NSString *imageStr =headModel.image_url;
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_yejieTableHeaderView addSubview:imageView];
    i++;
    
    _yejieTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //添加页签控制器
    _pageControlBackView4 =[[UIView alloc]initWithFrame:CGRectMake(0, _yejieTableHeaderView.bounds.size.height - 20, ScreenW, 20)];
    _pageControlBackView4.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_yejieTableView addSubview:_pageControlBackView4];
    
    _pageControl4 =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 20)];
    _pageControl4.center = CGPointMake(_pageControl4.center.x, _pageControlBackView4.frame.size.height/2);
    _pageControl4.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl4.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl4.numberOfPages =4;
    [_pageControlBackView4 addSubview:_pageControl4];
    
    
    //创建定时器
    [self creatYeJieTableHeaderViewTimer];


}

-(void)creatYeJieTableHeaderViewTimer
{
    _timer4 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer4Running) userInfo:nil repeats:YES];

}
-(void)timer4Running
{
    int page =_yejieTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl4.currentPage =page;
    [_yejieTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];

}

-(void)creatQiWenTableView
{
    _qiwenTableView =[[UITableView alloc]initWithFrame:CGRectMake(ScreenW*2, 0, ScreenW, ScreenH-104) style:UITableViewStylePlain];
    _qiwenTableView.delegate =self;
    _qiwenTableView.dataSource =self;
    _qiwenTableView.tag =1003;
    [_bigScrollView addSubview:_qiwenTableView];

    
}

-(void)getQiWenData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KSPQiWen_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *mDict = BigDict[@"data"];
        //头部广告栏数组
        NSArray *headArray =mDict[@"recommend"];
        
        for (NSDictionary *dict  in headArray) {
            MatchHeadModel *headModel =[MatchHeadModel mj_objectWithKeyValues:dict];
            [self.headQiWenArray addObject:headModel];
            
        }
        //列表内容模型数组
        NSArray *listArray =  mDict[@"list"];
        for (NSDictionary *listDict in listArray) {
            //根据字典来创建一个模型
            SPZiXunModel *Listmodel =[SPZiXunModel mj_objectWithKeyValues:listDict];
            [self.qiwenDataArray addObject:Listmodel];
            
        }
        
        [_qiwenTableView reloadData];
        [self creatQiWenTableHeaderView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"骑闻页----- 请求失败");
    }];


}

-(void)creatQiWenTableHeaderView
{
    _qiwenTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _qiwenTableHeaderView.delegate =self;
    _qiwenTableHeaderView.pagingEnabled =YES;
    _qiwenTableHeaderView.showsHorizontalScrollIndicator =NO;
    _qiwenTableHeaderView.showsVerticalScrollIndicator =NO;
    _qiwenTableHeaderView.tag =303;
    _qiwenTableView.tableHeaderView =_qiwenTableHeaderView;
    
    int count = (int)self.headQiWenArray.count;
    
    int i =0;
    for (i=0; i<count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        MatchHeadModel *headModel = _headQiWenArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:headModel.image_url]];

        [_qiwenTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    MatchHeadModel *headModel =_headQiWenArray[0];
    NSString *imageStr =headModel.image_url;
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_qiwenTableHeaderView addSubview:imageView];
    i++;
    
    _qiwenTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //添加页签控制器
    _pageControlBackView3 =[[UIView alloc]initWithFrame:CGRectMake(0, _qiwenTableHeaderView.bounds.size.height - 20, ScreenW, 20)];
    _pageControlBackView3.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_qiwenTableView addSubview:_pageControlBackView3];
    
    _pageControl3 =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 20)];
    _pageControl3.center = CGPointMake(_pageControl3.center.x, _pageControlBackView3.frame.size.height/2);
    _pageControl3.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl3.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl3.numberOfPages =4;
    [_pageControlBackView3 addSubview:_pageControl3];
    
    
    //创建定时器
    [self creatQiWenTableHeaderViewTimer];

}
//骑闻页 定时器
-(void)creatQiWenTableHeaderViewTimer
{
    _timer3 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer3Running) userInfo:nil repeats:YES];


}

-(void)creatTieSanTableView
{
    _tiesanTableView =[[UITableView alloc]initWithFrame:CGRectMake(ScreenW, 0, ScreenW, ScreenH-104) style:UITableViewStylePlain];
    _tiesanTableView.delegate =self;
    _tiesanTableView.dataSource =self;
    _tiesanTableView.tag =1002;
    [_bigScrollView addSubview:_tiesanTableView];


}

-(void)getTieSanData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KSPTieSan_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *mDict = BigDict[@"data"];
        //头部广告栏数组
        NSArray *headArray =mDict[@"recommend"];
        
        for (NSDictionary *dict  in headArray) {
            MatchHeadModel *headModel =[MatchHeadModel mj_objectWithKeyValues:dict];
            [self.headTieSanArray addObject:headModel];
            
        }
        //列表内容模型数组
        NSArray *listArray =  mDict[@"list"];
        for (NSDictionary *listDict in listArray) {
            //根据字典来创建一个模型
            SPZiXunModel *Listmodel =[SPZiXunModel mj_objectWithKeyValues:listDict];
            [self.tiesanDataArray addObject:Listmodel];
            
        }
        
          [_tiesanTableView reloadData];
        [self creatTieSanTableHeaderView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"铁三页----- 请求失败");
    }];
    

    
}

-(void)getData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:KSPZiXun_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       NSDictionary *mDict = BigDict[@"data"];
        //头部广告栏数组
        NSArray *headArray =mDict[@"recommend"];
     
        for (NSDictionary *dict  in headArray) {
            MatchHeadModel *headModel =[MatchHeadModel mj_objectWithKeyValues:dict];
            [self.headArray addObject:headModel];

        }
        //列表内容模型数组
        NSArray *listArray =  mDict[@"list"];
        for (NSDictionary *listDict in listArray) {
            //根据字典来创建一个模型
            SPZiXunModel *Listmodel =[SPZiXunModel mj_objectWithKeyValues:listDict];
            [self.matchDataArray addObject:Listmodel];
            
        }
      
        [MBProgressHUD hideHUD];
        [_matchTableView reloadData];
        //请求完数据后 ，创建tableHeadView
        
        [self creatMatchTableHeaderView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"资讯页 请求失败");
    }];
    

}

-(void)creatTieSanTableHeaderView
{
    _tiesanTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _tiesanTableHeaderView.delegate =self;
    _tiesanTableHeaderView.pagingEnabled =YES;
    _tiesanTableHeaderView.showsHorizontalScrollIndicator =NO;
    _tiesanTableHeaderView.showsVerticalScrollIndicator =NO;
    _tiesanTableHeaderView.tag =302;
    _tiesanTableView.tableHeaderView =_tiesanTableHeaderView;
    
    int count = (int)self.headTieSanArray.count;
    
    int i =0;
    for (i=0; i<count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        MatchHeadModel *headModel = _headTieSanArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:headModel.image_url]];
        //        [_matchTableHeaderView insertSubview:_matchTableHeaderView belowSubview:self.pageControl];
        [_tiesanTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    MatchHeadModel *headModel =_headTieSanArray[0];
    NSString *imageStr =headModel.image_url;
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_tiesanTableHeaderView addSubview:imageView];
    i++;
    
    _tiesanTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //添加页签控制器
    _pageControlBackView2 =[[UIView alloc]initWithFrame:CGRectMake(0, _tiesanTableHeaderView.bounds.size.height - 20, ScreenW, 20)];
    _pageControlBackView2.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_tiesanTableView addSubview:_pageControlBackView2];
    
    _pageControl2 =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 20)];
    _pageControl2.center = CGPointMake(_pageControl2.center.x, _pageControlBackView2.frame.size.height/2);
    _pageControl2.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl2.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl2.numberOfPages =4;
    [_pageControlBackView2 addSubview:_pageControl2];
    
    
    //创建定时器
    [self creatTieSanTableHeaderViewTimer];
    


}
//创建铁三 timer
-(void)creatTieSanTableHeaderViewTimer
{
     _timer2 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer2Running) userInfo:nil repeats:YES];
    
}
-(void)timer2Running
{
    int page =_matchTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl2.currentPage =page;
    [_tiesanTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];

    
}
-(void)timer3Running
{
    int page =_qiwenTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl3.currentPage =page;
    [_qiwenTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];

}

#pragma mark 创建首页底层的scrollView
-(void)creatHomeScrollView
{
    _bigScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenW, self.view.bounds.size.height -104)];
    _bigScrollView.delegate =self;
    _bigScrollView.pagingEnabled =YES;
    _bigScrollView.showsHorizontalScrollIndicator =NO;
    _bigScrollView.showsVerticalScrollIndicator =NO;
    _bigScrollView.bounces =NO;
    _bigScrollView.tag =201;
    [self.view addSubview:_bigScrollView];
    
    for (int i=0; i<7; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, self.view.bounds.size.height -104)];
        
        [_bigScrollView addSubview:imageView];
        
    }
    _bigScrollView.contentSize =CGSizeMake(ScreenW*7, 0);
    
}

#pragma mark 创建头部导航的滚动文字
-(void)creatHeaderScroll
{
    _headerScroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    
    _headerScroll.showsHorizontalScrollIndicator=NO;
    _headerScroll.showsVerticalScrollIndicator =NO;
    _headerScroll.bounces =NO;
    
    
    NSArray *navArr =@[@"赛事",@"铁三",@"骑闻",@"业界",@"产品",@"旅行",@"知识"];
   
    CGFloat buttonW =75;
    CGFloat buttonH =40;
    for (int i=0; i<7; i++) {
        
        _navButton =[[UIButton alloc]init];
        _navButton.frame =CGRectMake(i*buttonW, 0, buttonW, buttonH);
        [_navButton setTitle:navArr[i] forState:UIControlStateNormal];
        _navButton.titleLabel.textAlignment =NSTextAlignmentCenter;
        _navButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [_navButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _navButton.tag =100+i;
      
        [_navButton addTarget:self action:@selector(clickHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_headerScroll addSubview:_navButton];
        
    }
    _headerScroll.contentSize =CGSizeMake(75*7, 0);
    
    
    //底部指示条
    _shortView =[[UIView alloc]initWithFrame:CGRectMake(20, SPButtonLabelW-2, SPButtonLabelW, 2)];
    
    
    _shortView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"line_green"]];
    
    [_headerScroll addSubview:_shortView];

    [self.view addSubview:_headerScroll];
    
}
//点击了head按钮
-(void)clickHeadBtn:(UIButton *)button
{
    NSLog(@"%@",button.currentTitle);
    
}
-(void)creatMatchTableView
{
    _matchTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-104) style:UITableViewStylePlain];
    _matchTableView.delegate =self;
    _matchTableView.dataSource =self;
    _matchTableView.tag =1001;
    [_bigScrollView addSubview:_matchTableView];
    
    
}
//赛事栏 头部label
-(void)creatADLabel
{
    
        _matchHeaderLabel.text =@"";
        _matchHeaderLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 250, 15)];
    _matchHeaderLabel.font =[UIFont systemFontOfSize:12];
        [_pageControlBackView addSubview:_matchHeaderLabel];
        
        _matchHeaderLabel.textColor =[UIColor whiteColor];
        _matchHeaderLabel.font =[UIFont systemFontOfSize:12];
    
    NSInteger i= _pageControl1.currentPage;
    MatchHeadModel *model =self.headArray[i];
    _matchHeaderLabel.text =model.title;
    
}

-(void)creatMatchTableHeaderView
{
    
    _matchTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _matchTableHeaderView.delegate =self;
    _matchTableHeaderView.pagingEnabled =YES;
    _matchTableHeaderView.showsHorizontalScrollIndicator =NO;
    _matchTableHeaderView.showsVerticalScrollIndicator =NO;
    _matchTableHeaderView.tag =301;
    _matchTableView.tableHeaderView =_matchTableHeaderView;
    
    int count = (int)self.headArray.count;

    int i =0;
    for (i=0; i<count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        MatchHeadModel *headModel = _headArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:headModel.image_url]];
//        [_matchTableHeaderView insertSubview:_matchTableHeaderView belowSubview:self.pageControl];
        [_matchTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    NSString *imageStr =@"http://www.wildto.com//spiders//image//201512//22//1450773370624702.jpg";
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_matchTableHeaderView addSubview:imageView];
    i++;
    
    _matchTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //添加页签控制器
    _pageControlBackView =[[UIView alloc]initWithFrame:CGRectMake(0, _matchTableHeaderView.bounds.size.height - 20, ScreenW, 20)];
    _pageControlBackView.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_matchTableView addSubview:_pageControlBackView];
    
    _pageControl1 =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 20)];
    _pageControl1.center = CGPointMake(_pageControl1.center.x, _pageControlBackView.frame.size.height/2);
    _pageControl1.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl1.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl1.numberOfPages =4;
    [_pageControlBackView addSubview:_pageControl1];

    
    //创建定时器
    [self creatNewMatchTableHeaderViewTimer];

    
}

//创建定时器
-(void)creatNewMatchTableHeaderViewTimer
{
    _timer1 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer1Running) userInfo:nil repeats:YES];
    

}
-(void)timer1Running
{
    int page =_matchTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl1.currentPage =page;
    [_matchTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];

}

#pragma mark UITableViewDataSource 代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag ==1001) {
        return self.matchDataArray.count;
    }else if (tableView.tag ==1002)
    {
    return self.tiesanDataArray.count;
    }else if (tableView.tag ==1003)
    {
        return self.qiwenDataArray.count;
    }else if (tableView.tag ==1004)
    {
        return self.yejieDataArray.count;
    }else if (tableView.tag ==1005)
    {
        return self.chanpinDataArray.count;
    }else if (tableView.tag ==1006)
    {
        return self.lvxingDataArray.count;
    }else if (tableView.tag ==1007)
    {
        return self.zhishiDataArray.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"UITableViewCell";
    SPZiXunCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SPZiXunCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    switch (tableView.tag) {
        case 1001:
            cell.model =self.matchDataArray[indexPath.row];
            break;
        case 1002:
            cell.model =self.tiesanDataArray[indexPath.row];
            break;
        case 1003:
            cell.model =self.qiwenDataArray[indexPath.row];
            break;
        case 1004:
            cell.model =self.yejieDataArray[indexPath.row];
            break;
        case 1005:
            cell.model =self.chanpinDataArray[indexPath.row];
            break;
        case 1006:
            cell.model =self.lvxingDataArray[indexPath.row];
            break;
        case 1007:
            cell.model =self.zhishiDataArray[indexPath.row];
            break;

        default:
            break;
    }
    return cell;
}

#pragma mark UIScrollViewDelegate 代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat space =20;
    if (scrollView.tag ==201) {
        for (int i=0; i<7; i++) {
        if (scrollView.contentOffset.x ==i*ScreenW) {
            _shortView.frame =CGRectMake(i*75+space,SPButtonLabelW -2 ,SPButtonLabelW, 2);
            }
        }

        if(scrollView.contentOffset.x/ScreenW ==3)
        {
            _headerScroll.contentOffset =CGPointMake(75, 0);
        }else if (scrollView.contentOffset.x/ScreenW ==4)
        {
            _headerScroll.contentOffset =CGPointMake(2*75, 0);
        }else if (scrollView.contentOffset.x/ScreenW ==2)
        {
            _headerScroll.contentOffset =CGPointMake(0, 0);
        }
        
    }
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.tag ==301)
    {
        if (scrollView.contentOffset.x /ScreenW ==4) {
            _pageControl1.currentPage =0;
            scrollView.contentOffset =CGPointZero;
        }
        [self creatADLabel];
    }else if (scrollView.tag ==302)
    {
        if (scrollView.contentOffset.x /ScreenW ==4) {
            _pageControl2.currentPage =0;
            scrollView.contentOffset =CGPointZero;
        }
    }else if (scrollView.tag ==303)
    {
        if (scrollView.contentOffset.x /ScreenW ==4) {
            _pageControl3.currentPage =0;
            scrollView.contentOffset =CGPointZero;
        
        }
    }else if (scrollView.tag ==304)
    {
        if (scrollView.contentOffset.x /ScreenW ==4) {
            _pageControl4.currentPage =0;
            scrollView.contentOffset =CGPointZero;
        }
    }else if (scrollView.tag ==305)
    {
        if (scrollView.contentOffset.x /ScreenW ==4) {
            _pageControl5.currentPage =0;
            scrollView.contentOffset =CGPointZero;
        }
    }else if (scrollView.tag ==306)
    {
        if (scrollView.contentOffset.x /ScreenW ==4) {
            _pageControl6.currentPage =0;
            scrollView.contentOffset =CGPointZero;
        }
    }else if (scrollView.tag ==307)
    {
        if (scrollView.contentOffset.x /ScreenW ==4) {
            _pageControl7.currentPage =0;
            scrollView.contentOffset =CGPointZero;
        }

    }
}
@end
