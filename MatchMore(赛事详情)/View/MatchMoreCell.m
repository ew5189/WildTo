//
//  MatchMoreCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "MatchMoreDataList.h"
#import "NewMatchDataList.h"
#import "SPPhoto.h"
#import "MatchMoreCell.h"

@interface MatchMoreCell()
//标题
@property(strong ,nonatomic) UILabel *title;
//级别
@property(strong ,nonatomic) UILabel *matchLevel;
@property(strong ,nonatomic) UILabel *matchLevel_C;
//主办方
@property(strong ,nonatomic) UILabel *organizer;
@property(strong ,nonatomic) UILabel *organizer_C;

//比赛时间
@property(strong ,nonatomic) UILabel *matchTime;
@property(strong ,nonatomic) UILabel *matchTime_C;
//报名时间
@property(strong ,nonatomic) UILabel *signUpTime;
@property(strong ,nonatomic) UILabel *signUpTime_C;

//地址
@property(strong ,nonatomic) UILabel *address;
@property(strong ,nonatomic) UILabel *address_C;


@end

@implementation MatchMoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _title =[[UILabel alloc]init];
        [self.contentView addSubview:_title];
        
        _matchLevel =[[UILabel alloc]init];
        [self.contentView addSubview:_matchLevel];
        
        _matchLevel_C =[[UILabel alloc]init];
        [self.contentView addSubview:_matchLevel_C];
        
        _organizer =[[UILabel alloc]init];
        [self.contentView addSubview:_organizer];
        
        _organizer_C =[[UILabel alloc]init];
        [self.contentView addSubview:_organizer_C];
        
        _matchTime =[[UILabel alloc]init];
        [self.contentView addSubview:_matchTime];
        
        _matchTime_C =[[UILabel alloc]init];
        [self.contentView addSubview:_matchTime_C];
        
        _signUpTime =[[UILabel alloc]init];
        [self.contentView addSubview:_signUpTime];
        
        _signUpTime_C =[[UILabel alloc]init];
        [self.contentView addSubview:_signUpTime_C];
        
        _address =[[UILabel alloc]init];
        [self.contentView addSubview:_address];
        
        _address_C =[[UILabel alloc]init];
        [self.contentView addSubview:_address_C];
        
        
        
    }
    return self;
}

-(void)setDict:(NSMutableDictionary *)dict
{
    _dict =dict;
    _title.frame =CGRectMake(5, 10, ScreenW -20, 15);
    _title.text =dict[@"name"];
    

}

@end
