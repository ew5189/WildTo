//
//  RideCircleFrame.m
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.

// 昵称的字体
#define SPNameFont [UIFont systemFontOfSize:14]
// 正文的字体
#define SPTextFont [UIFont systemFontOfSize:14]
//发表时间的字体
#define SPCreatTimeFont [UIFont systemFontOfSize:12]
#import "Define.h"
#import "RideCircleModel.h"
#import "RideCircleFrame.h"

@implementation RideCircleFrame


-(void)setModel:(RideCircleModel *)model
{
    _model =model;
    //间距
    CGFloat space =10;
    //头像
    CGFloat iconX =space;
    CGFloat iconY =space;
    CGFloat iconW =60;
    CGFloat iconH =60;
     _iconF =CGRectMake(iconX, iconY, iconW, iconH);
    
//   昵称
    //文字字体
    CGSize nameSize = [self sizeWithText:_model.nickname font:SPNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat nameX =CGRectGetMaxX(_iconF)+space;
    CGFloat nameY =_iconF.origin.y;
    _nickNameF =CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    //发表时间
    
    _create_timeF =CGRectMake(_nickNameF.origin.x, CGRectGetMaxY(_nickNameF)+space, 200, 15);
    
    //正文
    CGSize textSize =[self sizeWithText:_model.content font:SPTextFont maxSize:CGSizeMake(ScreenW-2*space, MAXFLOAT)];
    _contentF =CGRectMake(space, CGRectGetMaxY(_iconF)+space,textSize.width, textSize.height);

    //有配图
    if (self.model.file_url_thumb.count>0) {
        CGFloat picW =100;
        CGFloat picH =100;
        _img_thumbF =CGRectMake(space, CGRectGetMaxY(_contentF)+10, picW, picH);
        
        if (self.model.event_name!=nil) {
            CGSize eventNameSize =[self sizeWithText:_model.event_name font:SPTextFont maxSize:CGSizeMake(ScreenW-2*space, MAXFLOAT)];
            _event_nameF =CGRectMake(space, CGRectGetMaxY(_img_thumbF)+10, eventNameSize.width, eventNameSize.height);
            
            _cellHeight =CGRectGetMaxY(_event_nameF)+5;
        }else{
            _cellHeight =CGRectGetMaxY(_img_thumbF)+5;
        }
        
        
        
    }else{
        if (self.model.event_name) {
            CGSize eventNameSize =[self sizeWithText:_model.event_name font:SPTextFont maxSize:CGSizeMake(ScreenW-2*space, MAXFLOAT)];
            _event_nameF =CGRectMake(space, CGRectGetMaxY(_contentF)+10, eventNameSize.width, eventNameSize.height);
            _cellHeight =CGRectGetMaxY(_event_nameF)+5;
            
        }else{
            _cellHeight =CGRectGetMaxY(_contentF)+5;
        }
        
        
    
    }
}


//根据内容的多少来判断占用size的大小，返回CGSize//maxSize设置最大宽度和高度
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
