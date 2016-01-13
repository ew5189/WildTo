//
//  SPChartCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "SPChartCell.h"
#import "SPChartModel.h"

@interface SPChartCell()

@property(strong ,nonatomic) UILabel *rank;
@property(strong ,nonatomic) UIImageView *iconView;
@property(strong ,nonatomic) UILabel *name;
@property(strong ,nonatomic) UILabel  *event_num;
@property(strong ,nonatomic) UILabel *grade;
@property(strong ,nonatomic) UIImageView *likeImage;
@property(strong ,nonatomic) UILabel  *like_num;

@end

@implementation SPChartCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _rank =[[UILabel alloc]init];
        [self.contentView addSubview:_rank];
        
        _iconView =[[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        
        _name =[[UILabel alloc]init];
        [self.contentView addSubview:_name];
        
        _event_num =[[UILabel alloc]init];
        [self.contentView addSubview:_event_num];
        
        _grade =[[UILabel alloc]init];
        [self.contentView addSubview:_grade];
        
        _likeImage =[[UIImageView alloc]init];
        [self.contentView addSubview:_likeImage];
        
        _like_num =[[UILabel alloc]init];
        [self.contentView addSubview:_like_num];
        
        
    }
    return self;

}

-(void)setModel:(SPChartModel *)model
{
    _model =model;
    
    _rank.frame =CGRectMake(20, 25, 25, 15);
    _rank.text =[NSString stringWithFormat:@"%@",model.rank];
    
    _iconView.frame =CGRectMake(60, 10, 60, 60);
    _iconView.layer.cornerRadius =30;
    _iconView.layer.masksToBounds =YES;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    _name.frame =CGRectMake(CGRectGetMaxX(_iconView.frame)+15, 15, 60, 20);
    _name.text=model.name;
    
    _event_num.frame =CGRectMake(_name.frame.origin.x, CGRectGetMaxY(_name.frame)+8, 100, 15);
    _event_num.font =[UIFont systemFontOfSize:14];
    _event_num.textColor =[UIColor lightGrayColor];
    _event_num.text =[NSString stringWithFormat:@"参加比赛%@次",model.event_num];
    
    _grade.frame =CGRectMake(230, _name.frame.origin.y+5, 50, 15);
    _grade.font =[UIFont systemFontOfSize:14];
   
    _grade.textColor =[UIColor blackColor];
    _grade.text =[NSString stringWithFormat:@"%@ 分",model.grade];
    
    _likeImage.frame =CGRectMake(CGRectGetMaxX(_grade.frame)+20, _grade.frame.origin.y, 15, 15);
    
    _likeImage.image =[UIImage imageNamed:@"icon_event_detail_like_no"];
    
    _like_num.frame =CGRectMake(CGRectGetMaxX(_likeImage.frame)+10, _likeImage.frame.origin.y, 30, 15);
    _like_num.numberOfLines =0;
  
    _like_num.font =[UIFont systemFontOfSize:14];
    _like_num.textColor =[UIColor lightGrayColor];
    _like_num.text =[NSString stringWithFormat:@"%@",model.like_num];
    
}



@end
