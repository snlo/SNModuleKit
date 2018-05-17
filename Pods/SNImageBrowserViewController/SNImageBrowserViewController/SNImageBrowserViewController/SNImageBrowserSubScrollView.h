//
//  SNImageBrowserSubScrollView.h
//  SNImageBrowserViewController
//
//  Created by snlo on 2017/12/5.
//  Copyright © 2017年 snlo All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNImageBrowserSubScrollView;

@protocol SNImageBrowserSubScrollViewDelegate <NSObject>

/**
 单击回调
 */
- (void)SNImageBrowserSubScrollViewDoSingleTapWithImageFrame:(CGRect)imageFrame;

/**
 开始或结束向下拖拽（外部需要隐藏其它图片，否则左右滑时会看到），needBack页面是否需要退回，imageFrame退回时用来做动画，不退回时可以不传
 */
- (void)SNImageBrowserSubScrollViewDoDownDrag:(BOOL)isBegin view:(SNImageBrowserSubScrollView *)subScrollView needBack:(BOOL)needBack imageFrame:(CGRect)imageFrame;

/**
 拖拽进行中额回调，把拖拽进度发下去，以设置透明度
 */
- (void)SNImageBrowserSubScrollViewDoingDownDrag:(CGFloat)dragProportion;

@end

@interface SNImageBrowserSubScrollView : UIView

@property (nonatomic,weak) id<SNImageBrowserSubScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame imageNamed:(NSString *)imageNamed;

@end
