//
//  DiscoverTableViewCell.h
//  WildTo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPCommonItem;
@interface DiscoverTableViewCell : UITableViewCell

//@property(strong ,nonatomic) UIImageView *iconImage;
//@property(strong ,nonatomic) UILabel *nameLabel;
//@property(strong ,nonatomic) UIImageView *userImage;
+(instancetype)cellWithTableView:(UITableView *)tableView;

//cell对应的item数据
@property(strong ,nonatomic) SPCommonItem *item;

@end
