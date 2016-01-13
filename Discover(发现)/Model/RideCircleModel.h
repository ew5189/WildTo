//
//  RideCircleModel.h
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RideCircleModel : NSObject

//头像
@property (nonatomic, copy) NSString *icon_url;
//发表时间
@property (nonatomic, assign) NSInteger create_time;
//内容正文
@property (nonatomic, copy) NSString *content;
//昵称
@property (nonatomic, copy) NSString *nickname;

//缩略图
@property (nonatomic, strong) NSArray *file_url_thumb;
//来自
@property (nonatomic, copy) NSString *event_name;
//发表图片
@property (nonatomic, strong) NSArray *file_url;

@property (nonatomic, assign) NSInteger like_flag;

@property (nonatomic, copy) NSString *dynamic_id;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, assign) NSInteger comment_num;

@property (nonatomic, assign) NSInteger forward_flag;

@property (nonatomic, assign) NSInteger like_num;

@property (nonatomic, assign) NSInteger forward_num;

@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *event_id;


+(instancetype)circleWithDict:(NSDictionary*)dict;

@end
