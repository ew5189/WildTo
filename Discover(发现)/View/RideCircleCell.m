//
//  RideCircleCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
#import "Define.h"
#import "RideCircleFrame.h"
#import "RideCircleModel.h"
#import "RideCircleCell.h"
#import "UIImageView+WebCache.h"

@interface RideCircleCell()

//头像
@property(strong ,nonatomic) UIImageView *iconView;
//昵称
@property(strong ,nonatomic) UILabel *nameLabel;
//发表时间
@property(strong ,nonatomic) UILabel *creatTime;
//正文
@property(strong ,nonatomic) UILabel *titleLabel;
//配图
@property(strong ,nonatomic) UIImageView *picView;
//来自
@property(strong ,nonatomic) UILabel *eventName;

@end

@implementation RideCircleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconView =[[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        
        _nameLabel =[[UILabel alloc]init];
        _nameLabel.numberOfLines =0;
        _nameLabel.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLabel];
        
        _creatTime =[[UILabel alloc]init];
        _creatTime.numberOfLines =0;
        _creatTime.font =[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_creatTime];
        
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        _picView =[[UIImageView alloc]init];
        [self.contentView addSubview:_picView];
        
        _eventName =[[UILabel alloc]init];
        _eventName.font =[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_eventName];
        
    }
    return self;
}

/**
 *  在这个方法中设置子控件的frame和显示数据
 */
-(void)setCircleFrame:(RideCircleFrame *)circleFrame
{
    _circleFrame =circleFrame;
    
    RideCircleModel *model =self.circleFrame.model;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
   
    _iconView.frame =_circleFrame.iconF;
    
    _nameLabel.text =model.nickname;
    _nameLabel.frame =self.circleFrame.nickNameF;
    
    _creatTime.text =[NSString stringWithFormat:@"%ld",model.create_time];
    _creatTime.frame =self.circleFrame.create_timeF;
    
    _titleLabel.text =model.content;
    _titleLabel.frame =self.circleFrame.contentF;
    
    
    if (model.file_url_thumb.count!=0 &&model.event_name.length!=0)
    {

        for (int i=0; i<model.file_url_thumb.count; i++) {
            [_picView sd_setImageWithURL:[NSURL URLWithString:model.file_url_thumb[i]]];
            
             }
            
            _picView.frame =self.circleFrame.img_thumbF;
            _picView.hidden =NO;
            
            _eventName.text =model.event_name;
            _eventName.frame =self.circleFrame.event_nameF;
            _eventName.hidden =NO;
        
    }else if(model.file_url_thumb.count!=0 &&model.event_name.length==0)
    {
        for (int i=0; i<model.file_url_thumb.count; i++) {
            [_picView sd_setImageWithURL:[NSURL URLWithString:model.file_url_thumb[i]]];
            
        }
        
        _picView.frame =self.circleFrame.img_thumbF;
        _picView.hidden =NO;
        
        
        _eventName.hidden =YES;

        
    }else if (model.file_url_thumb.count==0 &&model.event_name.length!=0)
    {
        _picView.hidden =YES;
        
        _eventName.text =model.event_name;
        _eventName.frame =self.circleFrame.event_nameF;
        _eventName.hidden =NO;

        
    }else if (model.file_url_thumb.count==0 &&model.event_name.length==0)
    {
        _picView.hidden =YES;
        _eventName.hidden =YES;
    }
    
}



@end
