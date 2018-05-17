//
//  SNImageBrowserViewController.h
//  SNImageBrowserViewController
//
//  Created by snlo on 2017/12/5.
//  Copyright © 2017年 snlo All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNImageBrowserViewController : UIViewController

/**
 初始化方法

 @param imageNameArray 图片名数组
 @param currentImageIndex 当前点击的第几个
 @param imageViewArray 页面里图片控件数组，这里需要是因为，转场时，要隐藏对应的
 @param imageViewFrameArray 页面里图片控件在window中的frame，包装成数组传进来，转场时需要
 */
- (instancetype)initWithImageNameArray:(NSArray *)imageNameArray currentImageIndex:(int)currentImageIndex imageViewArray:(NSMutableArray *)imageViewArray imageViewFrameArray:(NSMutableArray *)imageViewFrameArray;

@end
