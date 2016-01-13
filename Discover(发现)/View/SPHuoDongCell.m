//
//  SPHuoDongCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "HuoDongModel.h"
#import "SPHuoDongCell.h"

@interface SPHuoDongCell()

@property(strong ,nonatomic) UIImageView *imgView;
@property(strong ,nonatomic) UILabel *title;
@property(strong ,nonatomic) UIView *footView;

@end

@implementation SPHuoDongCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView =[[UIImageView alloc]init];
        [self.contentView addSubview:_imgView];
        
        _footView =[[UIView alloc]init];
        [self.contentView addSubview:_footView];
        
        _title =[[UILabel alloc]init];
        [self.contentView addSubview:_title];
        
        
        
    }
    return self;

}

-(void)setModel:(HuoDongModel *)model
{
    _model =model;
    
    _imgView.frame =CGRectMake(0, 0, ScreenW, 190);
    NSString *imgStr =model.image;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"icon_banner_default"]];
    
    _footView.frame =CGRectMake(0, CGRectGetMaxY(_imgView.frame)-25, ScreenW, 25);
    _footView.backgroundColor =[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:0.5];
    
    _title.frame =CGRectMake(5, CGRectGetMaxY(_imgView.frame)-25, 250, 25);
    _title.text =model.title;
    _title.font =[UIFont systemFontOfSize:14];
    _title.textColor =[UIColor whiteColor];


}
@end
