//
//  NewMatchDataList.m
//  WildTo
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 LSP. All rights reserved.
//

#import "NewMatchDataList.h"

@implementation NewMatchDataList

+(instancetype)newMatchDataListWithDict:(NSDictionary *)dict
{
    NewMatchDataList *model =[[self alloc]init];
    model.name =dict[@"name"];
    model.image_url =dict[@"image_url"];
    model.event_level =[dict[@"event_level"] integerValue];
    model.event_begin_time =dict[@"event_begin_time"];
    model.event_end_time =dict[@"event_end_time"];
    model.province =dict[@"province"];
    model.news_num =[dict[@"news_num"] integerValue];
    model.watch_num =dict[@"watch_num"];
    
    return model;
}

@end
