//
//  SPMineCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/13.
//  Copyright (c) 2016年 LSP. All rights reserved.
//

#import "SPCommonItem.h"
#import "SPMineCell.h"

@implementation SPMineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置标题字体
        self.textLabel.font =[UIFont boldSystemFontOfSize:16];
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        [self setNeedsLayout];
    }
    return self;
    
}

//调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)setItem:(SPCommonItem *)item
{
    //设置基本数据
    _item =item;
    self.imageView.image =[UIImage imageNamed:item.icon];
    self.textLabel.text =item.title;
    
}


@end
