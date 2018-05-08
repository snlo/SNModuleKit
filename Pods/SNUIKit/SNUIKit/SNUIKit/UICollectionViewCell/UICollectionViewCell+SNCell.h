//
//  UICollectionViewCell+SNCell.h
//  AiteCube
//
//  Created by sunDong on 2017/9/28.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (SNCell)

/**
 加载xib创建的collectionCell
 */
+ (instancetype)sn_nibCellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

/**
 加载非xib创建的collectionCell
 */
+ (instancetype)sn_cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
