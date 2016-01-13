//
//  HomeViewController.m
//  WildTo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
#import "Define.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "NewMatchDataList.h"
#import "HistoryMatchDataList.h"
#import "HistoryMatchDataList.h"
#import "NewMatchTableViewCell.h"
#import "HistoryMatchTableViewCell.h"
#import "MatchMoreTableViewController.h"
#import "SPTabBarController.h"
#import "HomeViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>



{
    UIButton *_newMatch;
    UIButton *_historyMatch;
    UIView *_shortView;
    CGFloat space;
    UITextField *_searchBar;
    UIScrollView *_scrollView;
    UITableView *_newMatchTableView;
    UITableView *_historyMatchTableView;
    UIScrollView *_newMatchTableHeaderView;
    UIScrollView *_historyMatchTableHeaderView;
    NSMutableArray *_imageArray;
    NSArray *_imageArray2;
    UILabel *_AD_label;
    UIPageControl *_pageControl;
    UIPageControl *_pageControl2;
    NSTimer *_timer1;
    NSTimer *_timer2;
    UIView *_pageControlBackView;
    UIView *_pageControlBackView2;
    int _index;
    
}
@property(strong ,nonatomic) NSMutableArray *dataArray;
@property(strong ,nonatomic) NSMutableArray *historyDataArray;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
//    [MBProgressHUD showMessage:@"努力加载中。。"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent =NO;
    
    
    //最新赛事头部广告栏图片
    _imageArray =[[NSMutableArray alloc]initWithCapacity:0];
    NSString *imageUrl1 =@"http://www.wildto.com//images//index//banner_01_sd02.jpg";
    [_imageArray addObject:imageUrl1];
    NSString *imageUrl2 =@"http://www.wildto.com//image//event//2015//12//14510114479865_thumb.png";
    [_imageArray addObject:imageUrl2];
    NSString *imageUrl3 =@"http://www.wildto.com//image//event//2015//12//14509502333694_thumb.jpg";
    [_imageArray addObject:imageUrl3];
    NSString *imageUrl4 =@"http://www.wildto.com//image//event//2015//12//14510113202920_thumb.jpg";
    [_imageArray addObject:imageUrl4];
    
    //历史赛事广告栏图片
    _imageArray2 =@[@"http://www.wildto.com//images//index//banner_01_sd02.jpg",@"http://www.wildto.com//image//event//2015//12//14497402144173_thumb.png",@"http://www.wildto.com//image//event//2015//11//14478490496494_thumb.jpg",@"http://www.wildto.com//image//event//2015//12//14503214958604_thumb.png"];

    [self creatRightButton];
    [self creatHeaderMatchButton];
    [self creatSearchBar];
    [self creatHomeScrollView];
    

    
    //请求数据
    [self requestHistoryMatchTableViewData];
    
    [self creatNewMatchTableView];
    [self creatHistoryMatchTableView];
    //最新赛事广告栏
    [self creatNewMatchTableHeaderView];
    //历史赛事广告栏
    [self creatHistoryMatchTableHeaderView];
    
    //集成刷新控件
    [self setupRefresh];
    
    //页签控制器
    [self creatPageControl];
    [self creatPageControl2];
    


}
//懒加载 模型数组
-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)historyDataArray
{
    if (_historyDataArray ==nil) {
        _historyDataArray =[NSMutableArray array];
    }
    return _historyDataArray;
}

#pragma mark 添加下拉刷新控件
-(void)setupRefresh
{
    //添加下拉刷新控件
    UIRefreshControl *refreshControl =[[UIRefreshControl alloc]init];
    [_newMatchTableView addSubview:refreshControl];
    
    
    //监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    //已进入程序，显示正在刷新
    [refreshControl beginRefreshing];
    
    //程序一开始 即调用下拉刷新的方法
    [self refreshControlStateChange:refreshControl];
    
}
#pragma mark 下拉刷新，请求最新赛事tableView数据
-(void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    //设置响应体的协调器为流
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:KNewMatchTableView_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *BigDict  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr =BigDict[@"data"];
        for (NSDictionary *dic in arr) {
            
            NSArray *arr1 = dic[@"data"];
            for (NSDictionary *dic1 in arr1) {
                NewMatchDataList *model =[NewMatchDataList newMatchDataListWithDict:dic1];
                [self.dataArray addObject:model];
            }
        }
        
        [MBProgressHUD hideHUD];
        [_newMatchTableView reloadData];
        [refreshControl endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
//        [MBProgressHUD showError:@"加载失败"];
         [MBProgressHUD hideHUD];
         [refreshControl endRefreshing];
    }];
}

#pragma mark 请求历史赛事tableView数据
-(void)requestHistoryMatchTableViewData
{
   

    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    //设置响应体的协调器为流
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:KHistoryTableView_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *BigDict  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr =BigDict[@"data"];
        for (NSDictionary *dic in arr) {
            NSArray *arr1 = dic[@"data"];
            for (NSDictionary *dic1 in arr1) {
                HistoryMatchDataList *model =[HistoryMatchDataList dataListWithDict:dic1];
                [self.historyDataArray addObject:model];
            }
        }
        
        [MBProgressHUD hideHUD];
        [_historyMatchTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
        [MBProgressHUD hideHUD];
    }];


}



#pragma mark 创建最新赛事广告栏页签
-(void)creatPageControl
{
    _pageControlBackView =[[UIView alloc]initWithFrame:CGRectMake(0, _newMatchTableHeaderView.bounds.size.height -15, ScreenW, 15)];
    _pageControlBackView.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_newMatchTableView addSubview:_pageControlBackView];
    
    _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 15)];
    _pageControl.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl.numberOfPages =4;
    [_pageControlBackView addSubview:_pageControl];
    
    
    
}
#pragma mark 创建历史赛事广告栏页签
-(void)creatPageControl2
{
    _pageControlBackView2 =[[UIView alloc]initWithFrame:CGRectMake(0, _historyMatchTableHeaderView.bounds.size.height -15, ScreenW, 15)];
    _pageControlBackView2.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    [_historyMatchTableView addSubview:_pageControlBackView2];
    
    _pageControl2 =[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenW*0.6, 0, ScreenW*0.4, 15)];
    _pageControl2.currentPageIndicatorTintColor =[UIColor cyanColor];
    _pageControl2.pageIndicatorTintColor =[UIColor whiteColor];
    _pageControl2.numberOfPages =4;
    [_pageControlBackView2 addSubview:_pageControl2];

}

#pragma mark 创建最新赛事广告栏上面的label
-(void)creatADLabel
{
    //请求广告栏上的数据
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:KNewMatchAD_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *BigDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr =BigDict[@"data"];
        _index =(int)arr.count;
        _AD_label.text =@"";
        _AD_label =[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200, 15)];
        [_pageControlBackView addSubview:_AD_label];

        _AD_label.textColor =[UIColor whiteColor];
        _AD_label.font =[UIFont systemFontOfSize:12];
        NSDictionary *mdict =arr[_pageControl.currentPage];
        _AD_label.text = mdict[@"name"];
        
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"请求错误");
        
    }];
    

}


#pragma mark 最新赛事广告栏
-(void)creatNewMatchTableHeaderView
{
    _newMatchTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _newMatchTableHeaderView.delegate =self;
    _newMatchTableHeaderView.pagingEnabled =YES;
    _newMatchTableHeaderView.showsHorizontalScrollIndicator =NO;
    _newMatchTableHeaderView.showsVerticalScrollIndicator =NO;
    _newMatchTableHeaderView.tag =301;
    _newMatchTableView.tableHeaderView =_newMatchTableHeaderView;
    
    int i =0;
    for (i=0; i<4; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]]];
        [_newMatchTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    NSString *imageStr =_imageArray[0];
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_newMatchTableHeaderView addSubview:imageView];
    i++;
    
    _newMatchTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //创建定时器
    [self creatNewMatchTableHeaderViewTimer];
    
}

#pragma mark 创建历史赛事广告栏
-(void)creatHistoryMatchTableHeaderView
{
    _historyMatchTableHeaderView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    _historyMatchTableHeaderView.delegate =self;
    _historyMatchTableHeaderView.pagingEnabled =YES;
    _historyMatchTableHeaderView.showsHorizontalScrollIndicator =NO;
    _historyMatchTableHeaderView.showsVerticalScrollIndicator =NO;
    _historyMatchTableHeaderView.tag =302;
    _historyMatchTableView.tableHeaderView =_historyMatchTableHeaderView;
    
    int i =0;
    for (i=0; i<4; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray2[i]]];
        [_historyMatchTableHeaderView addSubview:imageView];
        
    }
    //无限滑动
    NSString *imageStr =_imageArray2[0];
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, 130)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    [_historyMatchTableHeaderView addSubview:imageView];
    i++;
    
    _historyMatchTableHeaderView.contentSize =CGSizeMake(ScreenW*i, 130);
    
    //创建定时器
    [self creatHistoryMatchTableHeaderViewTimer];

    
}
#pragma mark 第二个页面定时器
-(void)creatHistoryMatchTableHeaderViewTimer
{
    _timer2 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer2Running) userInfo:nil repeats:YES];
}

-(void)timer2Running
{
    int page =_historyMatchTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl2.currentPage =page;
    [_historyMatchTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];

}

#pragma mark 移除定时器
-(void)removeTimer
{
    [_timer1 invalidate];
    _timer1 =nil;
}

#pragma mark 第一个页面定时器
-(void)creatNewMatchTableHeaderViewTimer
{
    _timer1 =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer1Running) userInfo:nil repeats:YES];
    
    
    
}
-(void)timer1Running
{
    int page =_newMatchTableHeaderView.contentOffset.x /ScreenW;
    page++;
    _pageControl.currentPage =page;
    [_newMatchTableHeaderView setContentOffset:CGPointMake(page*ScreenW, 0) animated:YES];
    
    
}

#pragma mark 历史赛事tableView
-(void)creatHistoryMatchTableView
{
    _historyMatchTableView =[[UITableView alloc]initWithFrame:CGRectMake(ScreenW, 0, ScreenW, ScreenH -50-64-49) style:UITableViewStylePlain];
    _historyMatchTableView.delegate =self;
    _historyMatchTableView.dataSource =self;
    _newMatchTableView.showsHorizontalScrollIndicator =NO;
    _newMatchTableView.showsVerticalScrollIndicator =NO;
    _historyMatchTableView.tag =102;
    [_scrollView addSubview:_historyMatchTableView];
}
#pragma mark  最新赛事tableView
-(void)creatNewMatchTableView
{
    _newMatchTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH -64 -50-49) style:UITableViewStylePlain];
    _newMatchTableView.delegate =self;
    _newMatchTableView.dataSource =self;
    _newMatchTableView.rowHeight =70;
    _newMatchTableView.showsHorizontalScrollIndicator =NO;
    _newMatchTableView.showsVerticalScrollIndicator =NO;
    _newMatchTableView.tag =101;
    [_scrollView addSubview:_newMatchTableView];
    
    
}
#pragma mark 创建首页底层的scrollView
-(void)creatHomeScrollView
{
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, ScreenW, self.view.bounds.size.height -50)];
    _scrollView.delegate =self;
    _scrollView.pagingEnabled =YES;
    _scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView.showsVerticalScrollIndicator =NO;
    _scrollView.bounces =NO;
    _scrollView.tag =201;
    [self.view addSubview:_scrollView];
    
    for (int i=0; i<2; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, self.view.bounds.size.height -50)];
        
        [_scrollView addSubview:imageView];
        
    }
    _scrollView.contentSize =CGSizeMake(ScreenW*2, 0);
    
}

#pragma mark  创建首页搜索框
-(void)creatSearchBar
{
    UIView *searchBarBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 25, self.view.bounds.size.width, 25)];
    searchBarBackView.backgroundColor =[UIColor colorWithRed:223/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:searchBarBackView];
    //创建searchBar
    _searchBar =[[UITextField alloc]initWithFrame:CGRectMake(8, 3, ScreenW-16, 19)];
    _searchBar.background =[UIImage imageNamed:@"back_mark_input"];
    [searchBarBackView addSubview:_searchBar];
    
    UIImageView *SearchBarLeft =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_ico"]];
    _searchBar.placeholder =@"请输入搜索内容";
    _searchBar.textAlignment =NSTextAlignmentCenter;
    _searchBar.font =[UIFont systemFontOfSize:12];
    _searchBar.textColor =[UIColor lightGrayColor];
    _searchBar.delegate =self;
    _searchBar.leftView =SearchBarLeft;
    _searchBar.leftViewMode =UITextFieldViewModeAlways;
    
}


-(void)creatHeaderMatchButton
{
     space =53.3;
    CGFloat buttonW =60;
    CGFloat buttonH =25;
    
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, buttonH)];
    headerView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:headerView];
    
    
    //最新赛事
    _newMatch =[UIButton buttonWithType:UIButtonTypeSystem];
    _newMatch.frame =CGRectMake(space, 0, buttonW, buttonH);
    [_newMatch setTitle:@"最新赛事" forState:UIControlStateNormal];
     [_newMatch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_newMatch.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_newMatch addTarget:self action:@selector(clickNewMatch) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_newMatch];
    //底部指示条
    _shortView =[[UIView alloc]initWithFrame:CGRectMake(space, buttonH-2, buttonW, 2)];
    
    _shortView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"line_green"]];
    
    [headerView addSubview:_shortView];
    
    
    //历史赛事
    _historyMatch =[UIButton buttonWithType:UIButtonTypeSystem];
    _historyMatch.frame =CGRectMake(ScreenW *0.5 +space, 0, buttonW, buttonH);
    [_historyMatch setTitle:@"历史赛事" forState:UIControlStateNormal];
    [_historyMatch setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_historyMatch.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_historyMatch addTarget:self action:@selector(clickHistoryMatch) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_historyMatch];
    
}

#pragma mark 点击了历史赛事
-(void)clickHistoryMatch
{
    [_historyMatch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_newMatch setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _shortView.frame =CGRectMake(ScreenW *0.5 +space,_historyMatch.frame.size.height -2 , _historyMatch.frame.size.width, 2);
    [_scrollView setContentOffset:CGPointMake(ScreenW, 0) animated:YES];
}

#pragma mark 点击了最新赛事
-(void)clickNewMatch
{
    [_newMatch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_historyMatch setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _shortView.frame =CGRectMake(space,_newMatch.frame.size.height -2 , _newMatch.frame.size.width, 2);
    [_scrollView setContentOffset:CGPointZero animated:YES];
    
}

-(void)creatRightButton
{
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:@"赛事爆料" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightBarButton) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    rightBtn.frame =CGRectMake(0, 0, 64, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    
}
#pragma mark 点击了右侧barButton
-(void)clickRightBarButton
{
    NSLog(@"rightBtn");
}

#pragma mark UITableViewDataSource代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;

}
//返回多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag ==101)
    {
    return self.dataArray.count;
    }else if(tableView.tag ==102)
    {
        return self.historyDataArray.count;
    }
    return 0;
}
//每行如何显示
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView.tag ==101)
    {
    static NSString *reuseID = @"NewMatchTableViewCell";
    NewMatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[NewMatchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    
    [cell setModel:self.dataArray[indexPath.row]];

    return cell;
    }else{
        static NSString *reuseID = @"HistoryMatchTableViewCell";
        HistoryMatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        if (cell == nil) {
            cell = [[HistoryMatchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            
        }
        
        [cell setModel:self.historyDataArray[indexPath.row]];
        
        return cell;

    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchMoreTableViewController *more =[[MatchMoreTableViewController alloc]init];
    
    [self presentViewController:more animated:NO completion:nil];
  
    
}

#pragma mark UIScrollViewDelegate 代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.tag ==201) {
        if (scrollView.contentOffset.x ==ScreenW) {
            
            [_historyMatch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_newMatch setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _shortView.frame =CGRectMake(ScreenW *0.5 +space,_historyMatch.frame.size.height -2 , _historyMatch.frame.size.width, 2);
            
        }else{
            [_newMatch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_historyMatch setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _shortView.frame =CGRectMake(space,_newMatch.frame.size.height -2 , _newMatch.frame.size.width, 2);
        
        }
    }
    int page = _newMatchTableHeaderView.contentOffset.x/ScreenW;
    if (page ==4) {
        _pageControl.currentPage =0;
        [_newMatchTableHeaderView setContentOffset:CGPointZero animated:NO];
    }else{
        //设置当前亮起的页签
        _pageControl.currentPage =page;
    }
    //停止减速后 开启定时器
    [self creatNewMatchTableHeaderViewTimer];
}
//滚动结束后 调用该方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if(scrollView.tag ==301)
    {
    if (scrollView.contentOffset.x /ScreenW ==4) {
        _pageControl.currentPage =0;
        scrollView.contentOffset =CGPointZero;
        
    }
        [self creatADLabel];
        
    }else if (scrollView.tag ==302)
    {
        if (scrollView.contentOffset.x /ScreenW ==4) {
            _pageControl2.currentPage =0;
            scrollView.contentOffset =CGPointZero;
            
        }
//        [self creatADLabel];

    }
}
//开始拖拽时，移除定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
    [_searchBar resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchBar resignFirstResponder];
    return YES;
}

@end
