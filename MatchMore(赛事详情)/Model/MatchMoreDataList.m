//
//  MatchMoreDataList.m
//  WildTo
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "MJExtension.h"
#import "MatchMoreDataList.h"
#import "SPPhoto.h"

@implementation MatchMoreDataList

- (NSDictionary *)objectClassInArray
{
    return @{@"image_url_arr":[SPPhoto class]};
}

@end



