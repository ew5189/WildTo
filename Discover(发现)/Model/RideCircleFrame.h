//
//  RideCircleFrame.h
//  WildTo
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 LSP. All rights reserved.
//  这个模型对象专门用来存放cell内部所有的子控件的frame数据  + cell的高度
// 一个cell拥有一个MJStatusFrame模型
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class RideCircleModel;
@interface RideCircleFrame : NSObject
//头像的frame
@property(assign ,nonatomic)CGRect iconF;
//昵称的frame
@property(assign ,nonatomic) CGRect  nickNameF;
//发表时间的frame
@property(assign ,nonatomic) CGRect create_timeF;
//正文的frame
@property(assign ,nonatomic) CGRect contentF;
//缩略图片的frame
@property(assign ,nonatomic) CGRect img_thumbF;
//来自哪里的frame
@property(assign ,nonatomic) CGRect event_nameF;

//cell的高度
@property(assign ,nonatomic) CGFloat  cellHeight;

@property(strong ,nonatomic) RideCircleModel *model;

@end
