//
//  SNImageBrowserTranslation.h
//  SNImageBrowserViewController
//
//  Created by snlo on 2017/12/5.
//  Copyright © 2017年 snlo All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//typedef void(^EndBlock)(void);

@interface SNImageBrowserTranslation : NSObject <UIViewControllerAnimatedTransitioning>

/**
 图片浏览器是显示还是隐藏
 */
@property (nonatomic,assign) BOOL photoBrowserShow;
//@property (nonatomic,strong) EndBlock endBlock;

/**
 图片浏览页主控件，转场时要隐藏它
 */
@property (nonatomic, strong) UIView * photoBrowserMainScrollView;

/**
 图片名称数组
 */
@property (nonatomic,strong) NSArray *imageNameArray;

/**
 外部的图片控件数组，转场时隐藏对应的
 */
@property (nonatomic,strong) NSMutableArray *imageViewArray;

/**
 退回时的image的frame
 */
@property (nonatomic,assign) CGRect backImageFrame;

/**
 当前是从在哪个图片返回，这个参数请最后设置，因为它的setter方法中用到了参数‘backImageFrame’
 */
@property (nonatomic,assign) int currentIndex;

@end
