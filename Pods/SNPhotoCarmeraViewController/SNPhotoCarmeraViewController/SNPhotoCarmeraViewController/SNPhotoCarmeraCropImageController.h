//
//  SNPhotoCarmeraCropImageController.h
//  SNPhotoCarmeraViewControllor
//
//  Created by snlo on 2017/1/10.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SNPhotoCarmeraCropImageDelegate <NSObject>

- (void)cropImageDidFinishedWithImage:(UIImage *)image;

@end

@interface SNPhotoCarmeraCropImageController : UIViewController

@property (nonatomic, weak) id <SNPhotoCarmeraCropImageDelegate> delegate;

/**
 圆形裁剪，默认NO;
 */
@property (nonatomic, assign) BOOL SNPhotoCarmera_ovalClip;

- (instancetype)initWithImage:(UIImage *)originalImage delegate:(id)delegate;

/**
 初始化

 @param image 图片源
 @param selectedBlock 完成回调
 @param cancelBlock 取消回调
 */
+ (instancetype)cropImageViewControllerWithImage:(UIImage *)image ratio:(CGFloat)ratio seletecedBlock:(void(^)(UIImage * image))selectedBlock cancelBlock:(void(^)(void))cancelBlock;

/**
 圆形修建，默认为‘NO’方形
 */
@property (nonatomic, assign) BOOL isOvalcropView;

@end
