//
//  MoneySearchModel.h
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoneySearchModel : NSObject

@property(copy ,nonatomic) NSString *event_group_id;
@property(copy ,nonatomic) NSString *name;
@property(copy ,nonatomic) NSString *begin_time;
@property(copy ,nonatomic) NSString *distance;
@property(copy ,nonatomic) NSString *group_type;
@property(copy ,nonatomic) NSString *type;


+(instancetype)searchWithDict:(NSDictionary*)dict;


@end
