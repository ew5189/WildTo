//
//  SPCommonGroup.h
//  WildTo
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 LSP. All rights reserved.
//用一个组模型来描述每组的信息：组头，组尾，这组的所有行模型

#import <Foundation/Foundation.h>

@interface SPCommonGroup : NSObject
//组头
@property(copy ,nonatomic) NSString *header;
//组尾
@property(copy ,nonatomic) NSString *footer;
//这组所有的行模型（数组中存放的都是SPCommonItem模型）
@property(strong ,nonatomic) NSArray *items;


+(instancetype)group;
@end
