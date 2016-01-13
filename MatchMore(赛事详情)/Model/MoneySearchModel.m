//
//  MoneySearchModel.m
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import "MoneySearchModel.h"

@implementation MoneySearchModel


//字典转模型: 请在.h中声明下面方法。添加属性，属性名称必须和plist中字典中名称一致。当调用类方法时 会自动调用对象方法生成映射。

+(instancetype)searchWithDict:(NSDictionary*)dict
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

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
