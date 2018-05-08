//
//  SNPhotoCameraViewController.h
//  NeighborMom
//
//  Created by sunDong on 16/4/11.
//  Copyright © 2016年 WAYOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNPhotoCameraViewController : UIViewController

/**
 选中的图片
 */
@property (nonatomic, readonly) UIImage * selectedImage;

/**
 照片选择器
 */
@property (nonatomic, readonly) UIImagePickerController * imagePickerController;

/**
 主题色
 */
@property (nonatomic, strong) UIColor * tintColor;

/**
 内容色，用于更新统一
 */
@property (nonatomic, strong) UIColor * contentColor;

/**
 黑色，用于更新统一
 */
@property (nonatomic, strong) UIColor * blackColor;

/**
 初始化

 @param presentViewController 呈现视图控制器
 @param selectedImageSize 预估的照片编辑尺寸，默认为（100，100）
 */
+ (instancetype)pictureViewControllerWithPresent:(UIViewController *)presentViewController estimatedSize:(CGSize)selectedImageSize;

/**
 从相册中选
 */
- (void)selectPictureFromAlbunPhotos;

/**
 从相机中选
 */
- (void)selectPictureFromCamera;

/**
 回调

 @param selectedBlock 最终选中的编辑过后的照片
 @param cancelBlock 当点击取消时
 */
- (void)selectedBlock:(void(^)(UIImage *image))selectedBlock cancelBlock:(void(^)(void))cancelBlock;

@end
