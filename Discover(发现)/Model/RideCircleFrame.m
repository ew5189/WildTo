//
//  RideCircleFrame.m
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.

// 昵称的字体
#define SPNameFont [UIFont systemFontOfSize:14]
// 正文的字体
#define SPTextFont [UIFont systemFontOfSize:13]
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
    
    CGSize creatTimeSize =[self sizeWithText:[NSString stringWithFormat:@"%ld",_model.create_time] font:SPCreatTimeFont maxSize:CGSizeMake(200, MAXFLOAT)];
    
    _create_timeF =CGRectMake(_nickNameF.origin.x, CGRectGetMaxY(_nickNameF)+space, creatTimeSize.width, creatTimeSize.height);
    
    //正文
    CGSize textSize =[self sizeWithText:_model.content font:SPTextFont maxSize:CGSizeMake(ScreenW-2*space, MAXFLOAT)];
    _contentF =CGRectMake(space, CGRectGetMaxY(_iconF)+space,ScreenW-2*space, textSize.height);

    //有配图 ，有来自
    if (self.model.file_url_thumb.count!=0 &&self.model.event_name.length!=0) {//有配图并且有来自
        CGFloat picW =100;
        CGFloat picH =100;
        
        for (int i=0; i<self.model.file_url_thumb.count; i++) {
            CGFloat picX =ScreenW/3*(i%3);
            CGFloat picY =(picH+space)*(i/3)+CGRectGetMaxY(_contentF);
            _img_thumbF =CGRectMake(picX, picY, picW, picH);
        }
        
        CGSize eventNameSize =[self sizeWithText:_model.event_name font:SPTextFont maxSize:CGSizeMake(ScreenW-2*space, MAXFLOAT)];
        _event_nameF =CGRectMake(space, CGRectGetMaxY(_iconF), eventNameSize.width, eventNameSize.height);
        
        _cellHeight =CGRectGetMaxY(_event_nameF)+space;
        
        
    }
    //没有配图，有来自
    if (self.model.file_url_thumb.count==0 &&self.model.event_name.length!=0)
    {
        CGSize eventNameSize =[self sizeWithText:_model.event_name font:SPTextFont maxSize:CGSizeMake(ScreenW-2*space, MAXFLOAT)];
        _event_nameF =CGRectMake(space, CGRectGetMaxY(_contentF), eventNameSize.width, eventNameSize.height);
        
        _cellHeight =CGRectGetMaxY(_event_nameF)+space;
    }
    
    //有配图，没有来自
    if (self.model.file_url_thumb.count!=0 &&self.model.event_name.length==0)
    {
        CGFloat picW =100;
        CGFloat picH =100;
        
        for (int i=0; i<self.model.file_url_thumb.count; i++) {
            CGFloat picX =ScreenW/3*(i%3);
            CGFloat picY =(picH+space)*(i/3)+CGRectGetMaxY(_contentF);
            _img_thumbF =CGRectMake(picX, picY, picW, picH);
        }

        _cellHeight =CGRectGetMaxY(_iconF)+space;
    }
    //没有配图，没有来自
    if (self.model.file_url_thumb.count==0 &&self.model.event_name.length==0)
    {
        _cellHeight =CGRectGetMaxY(_contentF)+space;
    }
    
    
}





//根据内容的多少来判断占用size的大小，返回CGSize//maxSize设置最大宽度和高度
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
