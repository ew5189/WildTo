//
//  SPTrackViewController.m
//  WildTo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
//
#import "Define.h"

#import "SPTrackViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface SPTrackViewController ()<UIScrollViewDelegate,MAMapViewDelegate,AMapSearchDelegate>



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

//地图
@property(strong ,nonatomic) MAMapView *mapView;

//位置（经纬度，海拔）
@property(strong ,nonatomic) CLLocation *location;
//定位按钮
@property(strong ,nonatomic) UIButton *locationButton;
//API搜索对象
@property(strong ,nonatomic) AMapSearchAPI *searchAPI;
//兴趣点数组
@property(strong ,nonatomic) NSArray *pois;
//大头针数组
@property(strong ,nonatomic) NSMutableArray *annotations;
//目的地
@property(strong ,nonatomic) MAPointAnnotation *distinationAnnotation;
//路线数组
@property(strong ,nonatomic) NSArray *pathPolylines;
@end

static int h =0;
static int m =0;
static int s=0;

@implementation SPTrackViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden =NO;
    self.navigationItem.title =@"轨迹记录";
    
    self.view.backgroundColor =[UIColor whiteColor];
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
//---------------------------------------
    [self creatMapView];
    //定位按钮
    [self creatTapLocationButton];
    [self initSearchApi];
    //搜索按钮
//    [self creatSearchButton];
    //线路规划按钮
//    [self creatLinePathButton];
    [self creatAnnotations];
    [self creatLong];
    [self creatMapBack];
    [self creatBigAndSmall];

    

}
//地图上的 加减
-(void)creatBigAndSmall
{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(ScreenW*2 -60, _BigScrollView.frame.size.height*0.56, 50, 50);
    [button setImage:[UIImage imageNamed:@"map_jia_unpress"] forState:UIControlStateNormal];
    [button setImage: [UIImage imageNamed:@"map_jia_press"] forState:UIControlStateHighlighted];
    [_BigScrollView addSubview:button];
    
    button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(ScreenW*2 -60, _BigScrollView.frame.size.height*0.65, 50, 50);
    [button setImage:[UIImage imageNamed:@"map_jian_unpress"] forState:UIControlStateNormal];
    [button setImage: [UIImage imageNamed:@"map_jian_press"] forState:UIControlStateHighlighted];
    [_BigScrollView addSubview:button];
    
    
}

-(void)creatMapBack
{
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame =CGRectMake(ScreenW, _BigScrollView.frame.size.height*0.5, 32, 107);
    backButton.center =CGPointMake(ScreenW+16, _BigScrollView.frame.size.height*0.5);
    [backButton setImage:[UIImage imageNamed:@"map_back_unpress"] forState:UIControlStateNormal];
    [backButton setImage: [UIImage imageNamed:@"map_back_press"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(clickLeftBack) forControlEvents:UIControlEventTouchUpInside];
    [_BigScrollView addSubview:backButton];
    
}
-(void)clickLeftBack
{
    [_BigScrollView setContentOffset:CGPointZero animated:YES];
    _line.frame=CGRectMake(40, 108-3, 100, 3);
}

#pragma mark 5,初始化searchAPI
-(void)initSearchApi
{
    _searchAPI =[[AMapSearchAPI alloc]initWithSearchKey:KBundleKey Delegate:self];
}
#pragma mark 6,获取当前位置
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    
    _location =[userLocation.location copy];
}
#pragma mark 7,利用逆地理编码讲地图上的经纬度变成文字
-(void)reGeoAction
{
    //初始化reque请求
    AMapReGeocodeSearchRequest *request =[[AMapReGeocodeSearchRequest alloc]init];
    //设置经纬度
    [request setLocation:[AMapGeoPoint locationWithLatitude:_location.coordinate.latitude longitude:_location.coordinate.longitude]];
    //设置请求
    [_searchAPI AMapReGoecodeSearch:request];
}

#pragma mark 8.当search失败触发的方法
-(void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"request is %@ and error is %@",request,error);
}

#pragma mark 9.search的逆地理解析回调
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    //首先取到城市信息
    NSString *cityString =response.regeocode.addressComponent.city;
    if (cityString ==nil) {//如果城市信息为 nil，不是城市就显示省份
        cityString =response.regeocode.addressComponent.province;
    }
    //设置当前点的位置信息
    [_mapView.userLocation setTitle:cityString];
    //设置详细信息
    [_mapView.userLocation setSubtitle:response.regeocode.formattedAddress];
}

#pragma mark 10.点击anotation 弹出的方法
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    //看看是不是当前的位置annotation
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        //调用逆地理编码
        [self reGeoAction];
    }
}

#pragma mark 2.创建点击定位按钮
-(void)creatTapLocationButton
{
    //创建按钮
    _locationButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _locationButton.frame =CGRectMake(10, _mapView.frame.size.height-80, 50, 50);
    //设置image
    [_locationButton setImage:[UIImage imageNamed:@"map_location_unpress"] forState:UIControlStateNormal];
    [_locationButton setImage:[UIImage imageNamed:@"map_location_press"] forState:UIControlStateHighlighted];

    //添加监听事件
    [_locationButton addTarget:self action:@selector(locationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mapView addSubview:_locationButton];
    
}
#pragma mark 3.按钮的监听事件
-(void)locationButtonClick:(UIButton *)button
{
    //如果点击按钮不是当前的经纬度，我们就让它都定位到当前的经纬度
    if(_mapView.userTrackingMode !=MAUserTrackingModeFollow)
    {
        //设置用户的跟随模式
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
    
}
#pragma mark 1.初始化地图
-(void)creatMapView
{
    //设置map的key绑定高德服务器
    [[MAMapServices sharedServices]setApiKey:KBundleKey];
    //创建map
    _mapView =[[MAMapView alloc]initWithFrame:CGRectMake(ScreenW, 0, ScreenW, ScreenH-108)];
    _mapView.delegate=self;
    //设置罗盘位置
//    [_mapView setCompassOrigin:CGPointMake(_mapView.compassOrigin.x, 44)];
    //设置指南针
//    [_mapView setScaleOrigin:CGPointMake(_mapView.scaleOrigin.x, 100)];
    
    [_BigScrollView addSubview:_mapView];
    
    //打开用户定位功能（一定要打开）
    [_mapView setShowsUserLocation:YES];
    
}

#pragma mark 4.用户的跟随模式改变 调用的代理方法
-(void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    if(mode ==MAUserTrackingModeNone)
    {
//        [_locationButton setImage:[UIImage imageNamed:@"pointer1"] forState:UIControlStateNormal];
    }else{
//        [_locationButton setImage:[UIImage imageNamed:@"pointer2"] forState:UIControlStateNormal];
    }
    
}
#pragma mark 11.初始化一个search按钮
-(void)creatSearchButton
{
    UIButton *searchButton =[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame =CGRectMake(54, _mapView.frame.size.height -65, 44, 44);
    searchButton.layer.cornerRadius =5.0;
    [searchButton setImage:[UIImage imageNamed:@"BigSearch"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:searchButton];
    
}
#pragma mark 12,搜索按钮点击事件
-(void)searchButtonClick:(UIButton *)button
{
    //如果searchApi为空 或没有位置
    if (_searchAPI ==nil ||_location ==nil)
    {
        return;
    }
    //初始化placeSearch
    AMapPlaceSearchRequest *request =[[AMapPlaceSearchRequest alloc]init];
    //设置search类型
    [request setSearchType:AMapSearchType_PlaceAround];
    //设置当前的经纬度
    [request setLocation:[AMapGeoPoint locationWithLatitude:_location.coordinate.latitude longitude:_location.coordinate.longitude]];
    //设置关键字
    [request setKeywords:@"ktv"];
    //地理请求
    [_searchAPI AMapPlaceSearch:request];
    
}
#pragma  mark 13.兴趣点的点击回调
-(void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    if (response.pois.count >0)
    {
        _pois =response.pois;

    }
    //清UI
    [_mapView removeAnnotations:_annotations];
    //清空数据
    [_annotations removeAllObjects];
}

#pragma mark 初始化大头针数组
-(void)creatAnnotations
{
    _annotations =[NSMutableArray array];
}

#pragma mark 18.annotation 自定义
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //如果annotation为distination我们就有系统的annation
    if(annotation ==_distinationAnnotation)
    {
        static NSString *destinationIdentifier =@"destinationAnnotationIdentifier";
        MAPinAnnotationView *annotationView =(MAPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:destinationIdentifier];
        if(annotationView ==nil)
        {
            annotationView =[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:destinationIdentifier];
            
        }
        //设置可以弹出气泡
        [annotationView setCanShowCallout:YES];
        [annotationView setPinColor:MAPinAnnotationColorRed];
        //设置下落动画
        annotationView.animatesDrop =YES;
        
        return annotationView;
    }
    //为了区别不同的大头针
    if([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        //tableView列表生成的大头针
        static NSString *identifier =@"annotationIdentifier";
        MAPinAnnotationView *pointAnnotation =(MAPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if(pointAnnotation ==nil)
        {
            pointAnnotation =[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
            
        }
        pointAnnotation.pinColor =MAPinAnnotationColorGreen;
        return pointAnnotation;
    }
    return nil;
}
#pragma mark 19.初始化长按
-(void)creatLong{
    UILongPressGestureRecognizer *longGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addLongGesture:)];
    [_mapView addGestureRecognizer:longGesture];
}
#pragma mark 20.长按手势的监听
-(void)addLongGesture:(UILongPressGestureRecognizer*)gesture
{
    if(gesture.state ==UIGestureRecognizerStateBegan)
    {
        //通过mapView拿到当前的位置
        CLLocationCoordinate2D location =[_mapView convertPoint:[gesture locationInView:_mapView] toCoordinateFromView:_mapView];
        if (_distinationAnnotation !=nil) {
            //清UI
            [_mapView removeAnnotation:_distinationAnnotation];
            //清数据
            _distinationAnnotation =nil;
        }
        _distinationAnnotation =[[MAPointAnnotation alloc]init];
        _distinationAnnotation.coordinate =location;
        _distinationAnnotation.title =@"destionation";
        [_mapView addAnnotation:_distinationAnnotation];
    }
}
#pragma mark 21.创建一个线路规划的按钮
-(void)creatLinePathButton
{
    UIButton *pathButton =[UIButton buttonWithType:UIButtonTypeCustom];
    pathButton.frame =CGRectMake(100, _mapView.frame.size.height -65, 44, 44);
    pathButton.layer.cornerRadius =5.0;
    [pathButton setImage:[UIImage imageNamed:@"path"] forState:UIControlStateNormal];
    [pathButton addTarget:self  action:@selector(pathButton:) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:pathButton];
    
}
#pragma mark 22.pathButton规划线路按钮的点击事件
-(void)pathButton:(UIButton *)button
{
    if (_searchAPI ==nil || _location ==nil || _distinationAnnotation ==nil)
    {
        NSLog(@"path search failed because currentLocation or destination or searchApi is nil");
        return;
    }
    //初始化路线搜索请求
    AMapNavigationSearchRequest *request =[[AMapNavigationSearchRequest alloc]init];
    //设置为步行路径规划
    [request setSearchType:AMapSearchType_NaviWalking];
    //设置初始点的经纬度
    [request setOrigin:[AMapGeoPoint locationWithLatitude:_location.coordinate.latitude longitude:_location.coordinate.longitude]];
    //设置目的地点的经纬度
    [request setDestination:[AMapGeoPoint locationWithLatitude:_distinationAnnotation.coordinate.latitude longitude:_distinationAnnotation.coordinate.longitude]];
    //发起搜索请求
    [_searchAPI AMapNavigationSearch:request];
    
}
#pragma mark 23以下内容都是绘制线条的内容
-(void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    if (response.count > 0)
    {
        [_mapView removeOverlays:_pathPolylines];
        _pathPolylines =nil;
    }
    _pathPolylines =[self polylinesForPath:response.route.paths[0]];
    [_mapView addOverlays:_pathPolylines];
    [_mapView showAnnotations:@[_distinationAnnotation,_mapView.userLocation] animated:YES];
    
}

#pragma mark 27.绘制路线
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string coordinateCount:(NSUInteger *)coordinateCount parseToken:(NSString *)token{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}
-(NSArray *)polylinesForPath:(AMapPath *)path
{
    if(path ==nil || path.steps.count ==0)
    {
        return nil;
    }
    NSMutableArray *polylines =[NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSInteger count =0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline coordinateCount:&count parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        [polylines addObject:polyline];
        
        free(coordinates), coordinates = NULL;
    }];
    
    return polylines;
    
}
-(MAOverlayPathView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView =[[MAPolylineView alloc]initWithPolyline:overlay];
        polylineView.lineWidth =4;
        polylineView.strokeColor =[UIColor blueColor];
        return polylineView;
    }
    return nil;
}





//ic_locate
//map_back_press
//map_model_nor
//map_location_unpress





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
    _BigScrollView.userInteractionEnabled =YES;
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
        
        [_BigScrollView setContentOffset:CGPointMake(ScreenW, 0) animated:YES];
        _line.frame =CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame)-3, button.frame.size.width, 3);
    }else
    {
        [_BigScrollView setContentOffset:CGPointZero animated:YES];
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

-(void)dealloc
{
    
}


@end
