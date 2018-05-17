//
//  UIImage+SNPhotoCarmera.h
//  SNPhotoCarmeraViewControllor
//
//  Created by snlo on 2017/1/11.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SNPhotoCarmera)

/**
 缩放指定大小

 @param newSize 缩放后的尺寸
 @return UIImage
 */
- (UIImage *)SNPhotoCarmera_resizeImageWithSize:(CGSize)newSize;

/**
 图片圆形裁剪

 @return UIImage
 */
- (UIImage *)SNPhotoCarmera_ovalClip;
@end
