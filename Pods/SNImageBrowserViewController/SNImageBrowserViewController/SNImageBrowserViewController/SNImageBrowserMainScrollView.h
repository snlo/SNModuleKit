//
//  SNImageBrowserMainScrollView.h
//  SNImageBrowserViewController
//
//  Created by snlo on 2017/12/5.
//  Copyright © 2017年 snlo All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SNImageBrowserMainScrollViewDelegate <NSObject>

/**
 单击
 */
- (void)SNImageBrowserMainScrollViewDoSingleTapWithImageFrame:(CGRect)imageFrame;

/**
 翻页
 */
- (void)SNImageBrowserMainScrollViewChangeCurrentIndex:(int)currentIndex;

/**
 向下拖拽
 */
- (void)SNImageBrowserMainScrollViewDoingDownDrag:(CGFloat)dragProportion;

/**
 需要退回页面
 */
- (void)SNImageBrowserMainScrollViewNeedBackWithImageFrame:(CGRect)imageFrame;

@end

@interface SNImageBrowserMainScrollView : UIView

@property (nonatomic,weak) id<SNImageBrowserMainScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame imageNameArray:(NSArray *)imageNameArray currentImageIndex:(int)index;

@end
