//
//  DiscoverTableViewCell.m
//  WildTo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "SPCommonItem.h"
#import "DiscoverTableViewCell.h"

@interface DiscoverTableViewCell()

@end

@implementation DiscoverTableViewCell

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

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseID = @"UITableViewCell";
    
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[DiscoverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    return cell;

}
//调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    for (UIImageView *imageView in self.subviews) {
//        if (![imageView isKindOfClass:NSClassFromString(@"UIImageView")]) {
//            continue;
//        }
//        [self setupImageViewFrame:imageView];
//        
//        
//    }
    
}


-(void)setItem:(SPCommonItem *)item
{
    //设置基本数据
    _item =item;
    self.imageView.image =[UIImage imageNamed:item.icon];
    self.textLabel.text =item.title;
    
}

@end
