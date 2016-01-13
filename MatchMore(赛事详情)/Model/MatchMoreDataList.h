//
//  MatchMoreDataList.h
//  WildTo
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class News_Detail;
@interface MatchMoreDataList : NSObject


@property (nonatomic, assign) NSInteger event_end_time;

@property (nonatomic, copy) NSString *event_regist_flag;

@property (nonatomic, strong) NSArray *image_url_arr;

@property (nonatomic, assign) NSInteger apply_begin_time;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, assign) NSInteger apply_end_time;

@property(strong ,nonatomic) News_Detail *user;

@property (nonatomic, copy) NSString *group_type;

@property (nonatomic, assign) NSInteger event_start_flag;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger event_begin_time;

@property (nonatomic, copy) NSString *event_level;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *organizer;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *watch_num;


@end


