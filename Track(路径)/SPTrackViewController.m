//
//  SPTrackViewController.m
//  WildTo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
//
#import "Define.h"
#import "SPTrackViewController.h"


@interface SPTrackViewController ()<UIScrollViewDelegate>

//nav下面短线
@property(strong ,nonatomic) UIView *line;
@property(strong ,nonatomic) UIScrollView *BigScrollView;
@property(strong ,nonatomic) UILabel *kmLabel;
@property(strong ,nonatomic) UILabel *timerLabel;
//开始按钮
@property(strong ,nonatomic) UIButton *beginBtn;
//暂停按钮
@property(strong ,nonatomic) UIButton *pauseBtn;
//完成按钮
@property(strong ,nonatomic) UIButton *finishedBtn;
//计时器
@property(strong ,nonatomic) NSTimer *timer;
//继续label
@property(strong ,nonatomic) UILabel *goNOLabel;
//完成label
@property(strong ,nonatomic) UILabel *finishLabel;

//当前速度
@property(strong ,nonatomic) UILabel *currentspeed;
//最高海拔
@property(strong ,nonatomic) UILabel *maxHeight;
//最快速度
@property(strong ,nonatomic) UILabel *fastSpeed;
//卡路里
@property(strong ,nonatomic) UILabel *kCal;
//平均速度
@property(strong ,nonatomic) UILabel *averageSpeed;
//坡度
@property(strong ,nonatomic) UILabel *poDu;
@end

static int h =0;
static int m =0;
static int s=0;

@implementation SPTrackViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden =YES;
    self.navigationItem.title =@"轨迹记录";
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBack)];
    self.navigationItem.leftBarButtonItem.tintColor =[UIColor blackColor];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"轨迹记录" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBtn)];
    self.navigationItem.rightBarButtonItem.tintColor =[UIColor blackColor];
    
    [self creatNavButton];
    [self creatBigScrollView];
    [self creatKMLabel];
    //中间部分
    [self creatMiddleView];
    
    //  底部
    [self creatBottom];
}

-(void)clickRightBtn
{
    NSLog(@"轨迹列表");
}

-(void)creatKMLabel
{
    _kmLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 50)];
    _kmLabel.center =CGPointMake(ScreenW*0.44, _BigScrollView.frame.size.height*0.15);
    _kmLabel.text =@"0.00";
    _kmLabel.textAlignment =NSTextAlignmentRight;
    _kmLabel.font =[UIFont boldSystemFontOfSize:48];
    
    [_BigScrollView addSubview:_kmLabel];
    
    UILabel *km =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 15)];
    km.center =CGPointMake(CGRectGetMaxX(_kmLabel.frame)+15, CGRectGetMaxY(_kmLabel.frame)-15);
    km.text =@"km";
    km.font =[UIFont systemFontOfSize:20];
    [_BigScrollView addSubview:km];
    
    _timerLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 15)];
    _timerLabel.center =CGPointMake(ScreenW*0.5+30, CGRectGetMaxY(_kmLabel.frame)+20);
    _timerLabel.font =[UIFont systemFontOfSize:20];
    _timerLabel.text =@"00:00:00";
    
    [_BigScrollView addSubview:_timerLabel];
   
    UIImageView *timeIcon =[[UIImageView alloc]initWithFrame:CGRectMake(_timerLabel.frame.origin.x-30, _timerLabel.frame.origin.y, 16, 16)];
    timeIcon.image =[UIImage imageNamed:@"icon_tab_time"];
    timeIcon.tintColor =[UIColor blackColor];
    [_BigScrollView addSubview:timeIcon];
    
 
}

-(void)creatMiddleView
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timerLabel.frame)+50, ScreenW, 150)];
    view.backgroundColor =[UIColor whiteColor];
    [_BigScrollView addSubview:view];
    
    UIView *line1 =[[UIView alloc]initWithFrame:CGRectMake(0, 49.5, ScreenW, 0.5)];
    line1.backgroundColor =[UIColor lightGrayColor];
    [view addSubview:line1];
    
    UIView *line2 =[[UIView alloc]initWithFrame:CGRectMake(0, 99.5, ScreenW, 0.5)];
    line2.backgroundColor =[UIColor lightGrayColor];
    [view addSubview:line2];
    
    UIView *cols =[[UIView alloc]initWithFrame:CGRectMake(ScreenW*0.5, 0, 0.5, view.frame.size.height)];
    cols.backgroundColor =[UIColor lightGrayColor];
    [view addSubview:cols];
    
    
    NSArray *arr1 =@[@"当前速度 km/h",@"最高海拔 m"];
    for (int i=0; i<2; i++) {
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(i*ScreenW*0.5, 30, ScreenW*0.5, 20)];
        label.font =[UIFont systemFontOfSize:14];
        label.textColor =[UIColor grayColor];
        label.text =arr1[i];
        label.textAlignment =NSTextAlignmentCenter;
        [view addSubview:label];
    }
    NSArray *arr2 =@[@"最快速度 km/h",@"卡路里kCal"];
    for (int i=0; i<2; i++) {
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(i*ScreenW*0.5, 80, ScreenW*0.5, 20)];
        label.font =[UIFont systemFontOfSize:14];
        label.textColor =[UIColor grayColor];
        label.text =arr2[i];
        label.textAlignment =NSTextAlignmentCenter;
        [view addSubview:label];
    }
    NSArray *arr3 =@[@"平均速度 km/h",@"坡度"];
    for (int i=0; i<2; i++) {
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(i*ScreenW*0.5, 130, ScreenW*0.5, 20)];
        label.font =[UIFont systemFontOfSize:14];
        label.textColor =[UIColor grayColor];
        label.text =arr3[i];
        label.textAlignment =NSTextAlignmentCenter;
        [view addSubview:label];
    }

    //当前速度
    _currentspeed =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW*0.5, 30)];
    _currentspeed.font =[UIFont boldSystemFontOfSize:18];
    _currentspeed.text =@"0.00";
    _currentspeed.textColor =[UIColor blackColor];
    _currentspeed.textAlignment =NSTextAlignmentCenter;
    [view addSubview:_currentspeed];
    //最高海拔
    _maxHeight =[[UILabel alloc]initWithFrame:CGRectMake(ScreenW*0.5, 0, ScreenW*0.5, 30)];
    _maxHeight.font =[UIFont boldSystemFontOfSize:18];
    _maxHeight.text =@"0.00";
    _maxHeight.textColor =[UIColor blackColor];
    _maxHeight.textAlignment =NSTextAlignmentCenter;
    [view addSubview:_maxHeight];
    //最快速度
    _fastSpeed =[[UILabel alloc]initWithFrame:CGRectMake(0, 50, ScreenW*0.5, 30)];
    _fastSpeed.font =[UIFont boldSystemFontOfSize:18];
    _fastSpeed.text =@"0.00";
    _fastSpeed.textColor =[UIColor blackColor];
    _fastSpeed.textAlignment =NSTextAlignmentCenter;
    [view addSubview:_fastSpeed];
    //卡路里
    _kCal =[[UILabel alloc]initWithFrame:CGRectMake(ScreenW*0.5, 50, ScreenW*0.5, 30)];
    _kCal.font =[UIFont boldSystemFontOfSize:18];
    _kCal.text =@"0.00";
    _kCal.textColor =[UIColor blackColor];
    _kCal.textAlignment =NSTextAlignmentCenter;
    [view addSubview:_kCal];
    //平均速度
    _averageSpeed =[[UILabel alloc]initWithFrame:CGRectMake(0, 100, ScreenW*0.5, 30)];
    _averageSpeed.font =[UIFont boldSystemFontOfSize:18];
    _averageSpeed.text =@"0.00";
    _averageSpeed.textColor =[UIColor blackColor];
    _averageSpeed.textAlignment =NSTextAlignmentCenter;
    [view addSubview:_averageSpeed];
    //坡度
    _poDu =[[UILabel alloc]initWithFrame:CGRectMake(ScreenW*0.5, 100, ScreenW*0.5, 30)];
    _poDu.font =[UIFont boldSystemFontOfSize:18];
    _poDu.text =@"0.00";
    _poDu.textColor =[UIColor blackColor];
    _poDu.textAlignment =NSTextAlignmentCenter;
    [view addSubview:_poDu];

    
}

-(void)creatBottom
{
    _beginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _beginBtn.frame =CGRectMake(0, 0, 80, 80);
    _beginBtn.center =CGPointMake(ScreenW*0.5, ScreenH*0.6);
    
    _beginBtn.backgroundColor =[UIColor colorWithRed:113/255.0f green:178/255.0f blue:70/255.0f alpha:1];
    _beginBtn.layer.cornerRadius =40;
    [_beginBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_beginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_beginBtn addTarget:self  action:@selector(clickBegin) forControlEvents:UIControlEventTouchUpInside];
    _beginBtn.titleLabel.font =[UIFont boldSystemFontOfSize:16];
    
    [_BigScrollView addSubview:_beginBtn];

    _pauseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _pauseBtn.frame =CGRectMake(0, 0, 70, 70);
    _pauseBtn.center =CGPointMake(ScreenW*0.3, ScreenH*0.6);
    [_pauseBtn setImage:[UIImage imageNamed:@"guiji_pause"] forState:UIControlStateNormal];
    [_pauseBtn setImage:[UIImage imageNamed:@"guiji_goon"] forState:UIControlStateSelected];
    [_pauseBtn addTarget:self action:@selector(clickPause:) forControlEvents:UIControlEventTouchUpInside];
    _pauseBtn.hidden =YES;
    [_BigScrollView addSubview:_pauseBtn];
    
    _finishedBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _finishedBtn.frame =CGRectMake(0, 0, 70, 70);
    _finishedBtn.center =CGPointMake(ScreenW *0.7, ScreenH*0.6);
    [_finishedBtn setImage:[UIImage imageNamed:@"guiji_finish"] forState:UIControlStateNormal];
    _finishedBtn.hidden =YES;
    [_finishedBtn addTarget:self action:@selector(clickFinish) forControlEvents:UIControlEventTouchUpInside];
    [_BigScrollView addSubview:_finishedBtn];
    
    _goNOLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    _goNOLabel.center =CGPointMake(_pauseBtn.centerX, CGRectGetMaxY(_pauseBtn.frame)+15);
    _goNOLabel.font =[UIFont systemFontOfSize:14];
    _goNOLabel.text =@"继续";
    _goNOLabel.hidden =YES;
    [_BigScrollView addSubview:_goNOLabel];
    
    _finishLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    _finishLabel.center =CGPointMake(_finishedBtn.centerX, CGRectGetMaxY(_finishedBtn.frame)+15);
    _finishLabel.font =[UIFont systemFontOfSize:14];
    _finishLabel.text =@"完成";
    _finishLabel.hidden =YES;
     [_BigScrollView addSubview:_finishLabel];
    
    
}

-(void)clickFinish
{
    NSLog(@"完成");
}

//点击了暂停,计时器开始 或者暂停
-(void)clickPause:(UIButton *)button
{
    if (button.selected ==YES) {
       [_timer setFireDate:[NSDate distantPast]];
        _goNOLabel.text =@"暂停";
    }else
    {
        [_timer setFireDate:[NSDate distantFuture]];
        _goNOLabel.text =@"继续";
    }
    _pauseBtn.selected =!_pauseBtn.selected;
    
    
}

//点击了开始
-(void)clickBegin
{
    _timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRunning) userInfo:nil repeats:YES];
    _beginBtn.hidden =YES;
    _pauseBtn.hidden =NO;
    _finishedBtn.hidden =NO;
    _goNOLabel.hidden =NO;
    _finishLabel.hidden =NO;
    _goNOLabel.text=@"暂停";
    
}

-(void)timerRunning
{
    s++;
    if (s>59) {
        m++;
        s=00;
        if (m>59) {
            h++;
            m=00;
        }
    }
    _timerLabel.text =[NSString stringWithFormat:@"%02d:%02d:%02d",h,m,s];

}

-(void)creatNavButton
{
    CGFloat buttonW =100;
    CGFloat buttonH =44;
    NSArray *navArr =@[@"数据",@"地图"];
    for (int i=0; i<2; i++) {
        
    UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame =CGRectMake(40+i*(buttonW+80), 64, buttonW, buttonH);
    [button setTitle:navArr[i] forState:UIControlStateNormal];
      
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag =100+i;
    [button addTarget:self action:@selector(clickNavButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
        
    }
    //底部短线
    _line =[[UIView alloc]initWithFrame:CGRectMake(40, 108-3, buttonW, 3)];
    _line.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"line_green"]];
    [self.view addSubview:_line];
    
    
    
    
}

-(void)creatBigScrollView
{
    _BigScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, ScreenW, ScreenH-108)];
    _BigScrollView.showsHorizontalScrollIndicator =NO;
    _BigScrollView.showsVerticalScrollIndicator =NO;
    _BigScrollView.bounces =NO;
    _BigScrollView.pagingEnabled =YES;
    _BigScrollView.delegate =self;
    [self.view addSubview:_BigScrollView];
    
    for (int i =0; i<2; i++) {
        
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, ScreenH-108)];
        view.backgroundColor =[UIColor colorWithRed:215/255.0f green:215/255.0f blue:215/255.0f alpha:0.2];
        [_BigScrollView addSubview:view];
        
    }
    _BigScrollView.contentSize =CGSizeMake(ScreenW*2, 0);
    
    

}
//点击了地图 和数据按钮
-(void)clickNavButton:(UIButton *)button
{
    if (button.tag ==101) {
        
         _BigScrollView.contentOffset =CGPointMake(ScreenW, 0);
        _line.frame =CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame)-3, button.frame.size.width, 3);
    }else
    {
        _BigScrollView.contentOffset =CGPointMake(0, 0);
        _line.frame =CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame)-3, button.frame.size.width, 3);

    }
   
}


//顶部左侧 返回
-(void)clickBack
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x/ScreenW ==1) {
        
        _line.frame =CGRectMake(220, 108-3, 100, 3);
    }else{
        _line.frame =CGRectMake(40, 108-3, 100, 3);
    }
    
}


@end
