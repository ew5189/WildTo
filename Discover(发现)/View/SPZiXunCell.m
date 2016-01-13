//
//  SPZiXunCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/10.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "SPZiXunCell.h"
#import "SPZiXunModel.h"

@interface SPZiXunCell()

@property(strong ,nonatomic) UIImageView *iconView;
@property(strong ,nonatomic) UILabel *titleLabel;
@property(strong ,nonatomic) UILabel *source;
@property(strong ,nonatomic) UILabel *visitLabel;



@end

@implementation SPZiXunCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
        _iconView =[[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.numberOfLines =0;
        [self.contentView addSubview:_titleLabel];
        
        _source =[[UILabel alloc]init];
        _source.textColor =[UIColor grayColor];
        [self.contentView addSubview:_source];
        
        _visitLabel =[[UILabel alloc]init];
        _visitLabel.textColor =[UIColor grayColor];
        [self.contentView addSubview:_visitLabel];
        
        
    }
    return self;

}


-(void)setModel:(SPZiXunModel *)model
{
    CGFloat space =10;
    CGFloat iconW =100;
    CGFloat iconH =100;
    
    _model =model;
    _iconView.frame =CGRectMake(space, space, iconW, iconH-2*space);

    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"icon_default_head_rectangle.jpg"]];
    
    CGSize titleSize =[self sizeWithText:model.title font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(ScreenW-iconW-(3*space), MAXFLOAT)];
    _titleLabel.frame =CGRectMake(CGRectGetMaxX(_iconView.frame)+space, space+2, titleSize.width, titleSize.height);
    _titleLabel.text =model.title;
    _titleLabel.font =[UIFont systemFontOfSize:14];
    
    NSString *sourceStr =[NSString stringWithFormat:@"来源：%@",model.source];
    CGSize sourceSize =[self sizeWithText:sourceStr font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _source.frame =CGRectMake(CGRectGetMaxX(_iconView.frame)+space, CGRectGetMaxY(_iconView.frame)-2*space, sourceSize.width, sourceSize.height);
    _source.text =sourceStr;
    _source.font =[UIFont systemFontOfSize:12];
    
    NSString *visitStr =[NSString stringWithFormat:@"浏览：%@",model.watch];
    CGSize visitSize =[self sizeWithText:visitStr font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    _visitLabel.frame =CGRectMake(ScreenW-visitSize.width-2*space, _source.frame.origin.y, visitSize.width, visitSize.height);
    _visitLabel.text =visitStr;
    _visitLabel.font =[UIFont systemFontOfSize:12];
    
    

}





//根据内容的多少来判断占用size的大小，返回CGSize//maxSize设置最大宽度和高度
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}




@end
