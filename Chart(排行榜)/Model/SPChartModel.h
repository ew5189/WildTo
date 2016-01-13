
//  SPChartModel.h
//  WildTo
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPChartModel : NSObject

//参加比赛次数
@property(copy ,nonatomic) NSString *event_num;
//分数
@property(copy ,nonatomic) NSString *grade;
//头像
@property(copy ,nonatomic) NSString *icon;
//喜欢数
@property(copy ,nonatomic) NSNumber *like_num;
//名字
@property(copy ,nonatomic) NSString *name;
//级别
@property(copy ,nonatomic) NSNumber *rank;
@property(copy ,nonatomic) NSString *user_id;
@property(copy ,nonatomic) NSNumber *can_like;
@property(copy ,nonatomic) NSNumber *ceil_flag;


@end
