//
//  SPCommonItem.m
//  WildTo
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import "SPCommonItem.h"

@implementation SPCommonItem

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    SPCommonItem *item =[[self alloc]init];
    item.icon =icon;
    item.title =title;
    
    return item;
}

@end
