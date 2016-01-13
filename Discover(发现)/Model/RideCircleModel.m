//
//  RideCircleModel.m
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "MJExtension.h"
#import "RideCirclePhoto_thumb.h"
#import "RideCirclePhoto.h"
#import "RideCircleModel.h"

@implementation RideCircleModel

//-(NSDictionary *)objectClassInArray
//{
//    return @{@"file_url_thumb" :[RideCirclePhoto_thumb class]};
//}


//字典转模型: 请在.h中声明下面方法。添加属性，属性名称必须和plist中字典中名称一致。当调用类方法时 会自动调用对象方法生成映射。

+(instancetype)circleWithDict:(NSDictionary*)dict
{
    
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary*)dict
{
    if(self =[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
    
}



//+(instancetype)circleWithDict:(NSDictionary*)dict
//{
//    
//    RideCircleModel *model =[[self alloc]init];
//    model.icon_url =dict[@"icon_url"];
//    model.create_time =[dict[@"create_time"] integerValue];
//    model.content =dict[@"content"];
//    model.nickname =dict[@"nickname"];
//    model.event_name =dict[@"event_name"];
//    
//    model.file_url_thumb =dict[@"file_url_thumb"];
//    
//    
//    
//    
//    
//    return model;
//}


@end
