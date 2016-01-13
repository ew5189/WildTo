//
//  MoneySearchCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "MoneySearchCell.h"
#import "MoneySearchModel.h"
@interface MoneySearchCell()

@property(strong ,nonatomic) UILabel *title;
@property(strong ,nonatomic) UILabel  *beginTime;
@property(strong ,nonatomic) UILabel *distance;


@end

@implementation MoneySearchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _title =[[UILabel alloc]init];
        _title.font =[UIFont boldSystemFontOfSize:16];
        _title.numberOfLines =0;
        _title.textColor =[UIColor blackColor];
        [self.contentView addSubview:_title];
        
        _beginTime =[[UILabel alloc]init];
        _beginTime.font =[UIFont systemFontOfSize:12];
        _beginTime.textColor =[UIColor grayColor];
        [self.contentView addSubview:_beginTime];
        
        _distance =[[UILabel alloc]init];
        _distance.textColor =[UIColor grayColor];
        _distance.font =[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_distance];
        
    }
    return self;
}

-(void)setModel:(MoneySearchModel *)model
{
    _model =model;
    
    _title.frame =CGRectMake(15, 15, ScreenW, 15);
    _title.text =model.name;
    
    _beginTime.frame =CGRectMake(15, 40, 150, 15);
    NSString *str =model.begin_time;
    _beginTime.text =[NSString stringWithFormat:@"时间：%@",str];
    

    _distance.frame =CGRectMake(220, 40, 100, 15);
    NSString *sr =model.distance;
    _distance.text =[NSString stringWithFormat:@"距离：%@km",sr];
    
}

@end
