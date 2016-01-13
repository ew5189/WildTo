//
//  News_Detail.h
//  WildTo
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News_Detail : NSObject

@property (nonatomic, assign) NSInteger like_flag;

@property (nonatomic, copy) NSString *dynamic_id;

@property (nonatomic, strong) NSArray *file_url_thumb;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *icon_url;

@property (nonatomic, assign) NSInteger comment_num;

@property (nonatomic, assign) NSInteger forward_flag;

@property (nonatomic, strong) NSArray *file_url;

@property (nonatomic, assign) NSInteger like_num;

@property (nonatomic, assign) NSInteger forward_num;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger create_time;

@property (nonatomic, copy) NSString *content;


@end
