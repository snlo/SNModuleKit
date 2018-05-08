//
//  SNPopupView.h
//  AiteCube
//
//  Created by snlo on 2017/12/7.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 注意在继承时一级子视图有且只有一个,它才会提供回退、入场和智能屏蔽边缘手势的功能。
 */
@interface SNPopupView : UIView

/**
 是否不能点击空白处回退，默认为'NO'
 */
@property (nonatomic, assign) BOOL isBlankTouchInVisible;


/**
 回退。会执行‘dealloc’函数
 @param block 当动画完成时执行回调
 */
- (void)dismissFromSuperView:(void(^)(void))block;

/**
 入场
 @param block 当动画完成时执行回调
 */
- (void)showInSuperView:(void(^)(void))block;

/**
 当接受的回退时的回调，当实现次API时‘dismissFromSuperView’中的‘block’会失效
 */
- (void)receiveDismissBlock:(void(^)(void))block;

@end
