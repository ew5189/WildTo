//
//  ZiXunViewController.m
//  WildTo
//
//  Created by 千锋 on 16/1/9.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#define SPreuseIdentifier @"collectionViewCell"
#import "Define.h"
#import "ZiXunViewController.h"

@interface ZiXunViewController ()

@end

@implementation ZiXunViewController


-(instancetype)init
{
    //创建一个UICollectionViewLayout 布局对象，该对象决定了 collection怎么显示
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize =CGSizeMake(ScreenW, ScreenH-64);
    //行列间距 设置为0
    layout.minimumInteritemSpacing =0;
    layout.minimumLineSpacing =0;
    
    
    //设置水平横向滚动
    layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    if (self =[super initWithCollectionViewLayout:layout]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"资讯";
    self.tabBarController.tabBar.hidden =YES;
    //设置按页滚动
    self.collectionView.pagingEnabled =YES;
    //必须先注册一个cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SPreuseIdentifier];
    

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 7;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPreuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor =SPRandomColor;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
