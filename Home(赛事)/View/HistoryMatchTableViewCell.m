//
//  HistoryMatchTableViewCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 LSP. All rights reserved.
#import "UIImageView+WebCache.h"
#import "HistoryMatchDataList.h"
#import "HistoryMatchTableViewCell.h"

@interface HistoryMatchTableViewCell()

//头像
@property(strong ,nonatomic) UIImageView *iconImage;
//标题
@property(strong ,nonatomic) UILabel *nameLabel;
//级别
@property(strong ,nonatomic) UILabel *event_level;
//赛事时间
@property(strong ,nonatomic) UILabel *beginAndEndTime;

//省份
@property(strong ,nonatomic) UILabel *provinceLabel;

//新回复icon
@property(strong ,nonatomic) UIImageView *answerView;
//新回复
@property(strong ,nonatomic) UILabel *answerCount;

//浏览量icon
@property(strong ,nonatomic) UIImageView *visitCountView;
//浏览量
@property(strong ,nonatomic) UILabel *visitCount;


@end

@implementation HistoryMatchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        _iconImage =[[UIImageView alloc]init];
        [self.contentView addSubview:_iconImage];
        //标题
        _nameLabel =[[UILabel alloc]init];
        _nameLabel.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLabel];
        //级别
        _event_level =[[UILabel alloc]init];
        _event_level.textColor =[UIColor darkGrayColor];
        _event_level.font =[UIFont systemFontOfSize:9];
        [self.contentView addSubview:_event_level];
        //赛事时间
        _beginAndEndTime =[[UILabel alloc]init];
        _beginAndEndTime.font =[UIFont systemFontOfSize:9];
        _beginAndEndTime.textColor =[UIColor darkGrayColor];
        [self.contentView addSubview:_beginAndEndTime];
        //新回复icon
        _answerView =[[UIImageView alloc]init];
        [self.contentView addSubview:_answerView];
        //新回复
        _answerCount =[[UILabel alloc]init];
        _answerCount.font =[UIFont systemFontOfSize:9];
        _answerCount.textColor =[UIColor darkGrayColor];
        [self.contentView addSubview:_answerCount];
        
        //省份
        _provinceLabel =[[UILabel alloc]init];
        [self.contentView addSubview:_provinceLabel];
        
        //浏览量icon
        _visitCountView =[[UIImageView alloc]init];
        [self.contentView addSubview:_visitCountView];
        //浏览量label
        _visitCount =[[UILabel alloc]init];
        _visitCount.font =[UIFont systemFontOfSize:9];
        _visitCount.textColor =[UIColor darkGrayColor];
        [self.contentView addSubview:_visitCount];
        
        
    }
    return self;
}

-(void)setModel:(HistoryMatchDataList *)model
{
    CGFloat space =10;
    CGFloat iconImageW =80;
    CGFloat iconImageH =80-space*2;
    
    
    _model =model;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:_model.image_url]];
    _iconImage.frame =CGRectMake(space, space, iconImageW,iconImageH);
    
    _nameLabel.text =_model.name;
    
    _nameLabel.frame =CGRectMake(iconImageW +2*space, space, self.bounds.size.width-iconImageW-2*space, 10);
    //级别
    _event_level.frame =CGRectMake(CGRectGetMaxX(_iconImage.frame)+space, CGRectGetMaxY(_nameLabel.frame)+5, 100, 10);
    
    //根据接口中的数字 判断级别
    [self setEventLevel_text:model];
    
    //赛事时间
    _beginAndEndTime.frame =CGRectMake(CGRectGetMaxX(_iconImage.frame)+space, CGRectGetMaxY(_event_level.frame)+5, 200, 10);
    
    
    _beginAndEndTime.text =[NSString stringWithFormat:@"赛事时间：%@ -%@",model.event_begin_time,model.event_end_time];
    //   新回复icon
    _answerView.frame =CGRectMake(CGRectGetMaxX(_iconImage.frame)+120, CGRectGetMaxY(_beginAndEndTime.frame)+5, 15, 10);
    _answerView.image =[UIImage imageNamed:@"ic_comment"];
    //新回复label
    _answerCount.frame =CGRectMake(CGRectGetMaxX(_answerView.frame)+2, _answerView.frame.origin.y, 5, 8);
    _answerCount.text =[NSString stringWithFormat:@"%ld",model.news_num];
    
    //浏览量icon
    _visitCountView.frame =CGRectMake(CGRectGetMaxX(_answerCount.frame)+30, CGRectGetMaxY(_beginAndEndTime.frame)+2, 20, 15);
    _visitCountView.image =[UIImage imageNamed:@"ic_view_eyes"];
    //浏览量label
    _visitCount.frame =CGRectMake(CGRectGetMaxX(_visitCountView.frame)+3,CGRectGetMaxY(_beginAndEndTime.frame)+5, 30, 9);
    _visitCount.text =model.watch_num;
    


}
-(void)setEventLevel_text:(HistoryMatchDataList *)model
{
    switch (model.event_level) {
        case 1:
            _event_level.text =[NSString stringWithFormat:@"赛事级别：A级"];
            break;
        case 2:
            _event_level.text =[NSString stringWithFormat:@"赛事级别：B级"];
            break;
            
        case 3:
            _event_level.text =[NSString stringWithFormat:@"赛事级别：C级"];
            break;
        case 4:
            _event_level.text =[NSString stringWithFormat:@"赛事级别：D级"];
            break;
        case 0:
            _event_level.text =[NSString stringWithFormat:@"赛事级别："];
            break;
            
        default:
            break;
    }

}

@end
