//
//  SPTabBar.h
//  WildTo
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 LSP. All rights reserved.
//



#import <UIKit/UIKit.h>
@class SPTrackViewController;
typedef void(^clickTrackBlock)(SPTrackViewController *track);

@interface SPTabBar : UITabBar

@property(copy ,nonatomic) clickTrackBlock block;

-(void)clickTrackButton:(clickTrackBlock)block;

@end
