//
//  SPCommonItem.h
//  WildTo
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 LSP. All rights reserved.
//用一个模型来描述每行的信息：图标，标题，右边的样式

#import <Foundation/Foundation.h>

@interface SPCommonItem : NSObject
/** 图标 */
@property(copy ,nonatomic) NSString *icon;
/** 标题 */
@property(copy ,nonatomic) NSString *title;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;


@end
