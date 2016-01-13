//
//  HistoryMatchDataList.m
//  WildTo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import "HistoryMatchDataList.h"

@implementation HistoryMatchDataList

+(instancetype)dataListWithDict:(NSDictionary *)dict
{
    HistoryMatchDataList *model =[[self alloc]init];
    model.name =dict[@"name"];
    model.image_url =dict[@"image_url"];
    model.event_level =[dict[@"event_level"] integerValue];
    model.event_begin_time =dict[@"event_begin_time"];
    model.event_end_time =dict[@"event_end_time"];
    model.news_num =[dict[@"news_num"] integerValue];
    model.watch_num =dict[@"watch_num"];
    model.province =dict[@"province"];

    return model;
}

@end
