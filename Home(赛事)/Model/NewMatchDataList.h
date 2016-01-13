//
//  NewMatchDataList.h
//  WildTo
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 LSP. All rights reserved.
//最新赛事tableView数据模型


#import <Foundation/Foundation.h>

@interface NewMatchDataList : NSObject

//标题
@property (nonatomic, copy) NSString *name;
//图片地址
@property (nonatomic, copy) NSString *image_url;
//等级
@property (nonatomic, assign) NSInteger event_level;
//开始时间
@property (nonatomic, copy) NSString *event_begin_time;
//结束时间
@property (nonatomic, copy) NSString *event_end_time;
//省份
@property (nonatomic, copy) NSString *province;
//新回复
@property (nonatomic, assign) NSInteger news_num;
//浏览量
@property (nonatomic, copy) NSString *watch_num;


@property (nonatomic, assign) NSInteger event_regist_flag_v151;
@property (nonatomic, assign) NSInteger event_regist_flag;
@property (nonatomic, copy) NSString *organizer;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *event_id;
@property (nonatomic, copy) NSString *broke_the_news_nickname;
@property (nonatomic, assign) NSInteger status;


+(instancetype)newMatchDataListWithDict:(NSDictionary *)dict;

//{"status":1,"event_begin_time":1451523600,"event_end_time":1451836500,"image_url":"http:\/\/www.wildto.com\/image\/event\/2015\/11\/1448682696.png","name":"2015\u9996\u5c4a\u4e2d\u8d8a\u56fd\u9645\u81ea\u884c\u8f66\u8d5b\u66a8\u6c11\u4fd7\u6587\u5316\u65c5\u6e38\u8282","organizer":"\u7ea2\u6cb3\u5dde\u6587\u5316\u4f53\u80b2\u548c\u5e7f\u64ad\u7535\u89c6\u5c40\u3001\u7ea2\u6cb3\u5dde\u65c5\u6e38\u53d1\u5c55\u59d4\u5458\u4f1a\u3001\u7ea2\u6cb3\u5dde\u65c5\u6e38\u534f\u4f1a\u3001\u6cb3\u53e3\u53bf\u59d4\u5ba3\u4f20\u90e8\u3001\u6cb3\u53e3\u53bf\u6587\u5316\u4f53\u80b2\u548c\u5e7f\u64ad\u7535\u89c6\u5c40\u3001\u6cb3\u53e3\u53bf\u65c5\u6e38\u53d1\u5c55\u59d4\u5458\u4f1a\u3001\u8001\u8857\u7701\u4f53\u80b2\u6587\u5316\u65c5\u6e38\u5385\u3001\u8001\u8857\u65c5\u6e38\u4fc3\u8fdb\u4e2d\u5fc3","address":"\u4e91\u5357\u7701","province":"\u4e91\u5357\u7701","broke_the_news_nickname":"","watch_num":"2774","news_num":12,"event_id":"723","event_regist_flag":0,"event_regist_flag_v151":4,"event_level":"3"}

@end
