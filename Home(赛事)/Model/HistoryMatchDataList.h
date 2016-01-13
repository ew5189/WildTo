//
//  HistoryMatchDataList.h
//  WildTo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryMatchDataList : NSObject


//头像
@property (nonatomic, copy) NSString *image_url;
//标题
@property (nonatomic, copy) NSString *name;
//赛事级别
@property (nonatomic, assign) NSInteger event_level;
//开始时间
@property (nonatomic, copy) NSString *event_begin_time;
//结束时间
@property (nonatomic, copy) NSString *event_end_time;
//新回复数
@property (nonatomic, assign) NSInteger news_num;
//浏览量
@property (nonatomic, copy) NSString *watch_num;
//省份
@property (nonatomic, copy) NSString *province;




@property (nonatomic, assign) NSInteger event_regist_flag;
@property (nonatomic, copy) NSString *broke_the_news_nickname;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) NSInteger event_regist_flag_v151;
@property (nonatomic, copy) NSString *organizer;
@property (nonatomic, copy) NSString *event_id;
@property (nonatomic, assign) NSInteger status;

+(instancetype)dataListWithDict:(NSDictionary *)dict;

@end
