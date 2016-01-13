//
//  MatchHeadModel.h
//  WildTo
//
//  Created by 千锋 on 16/1/9.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchHeadModel : NSObject

@property(copy ,nonatomic) NSString *image_url;
@property(copy ,nonatomic) NSString *news_id;
@property(copy ,nonatomic) NSString *title;

+(instancetype)headWithDict:(NSDictionary*)dict;

-(instancetype)initWithDict:(NSDictionary*)dict;

@end
