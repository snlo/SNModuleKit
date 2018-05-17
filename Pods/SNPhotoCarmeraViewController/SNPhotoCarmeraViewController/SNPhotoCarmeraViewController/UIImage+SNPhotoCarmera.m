//
//  UIImage+SNPhotoCarmera.m
//  SNPhotoCarmeraViewControllor
//
//  Created by snlo on 2017/1/11.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UIImage+SNPhotoCarmera.h"

@implementation UIImage (SNPhotoCarmera)

- (UIImage *)SNPhotoCarmera_resizeImageWithSize:(CGSize)newSize {
    CGFloat newWidth = newSize.width;
    CGFloat newHeight = newSize.height;
    float width  = self.size.width;
    float height = self.size.height;
    if (width != newWidth || height != newHeight) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), YES, [UIScreen mainScreen].scale);
        [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
        
        UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resized;
    }
    return self;
}
- (UIImage *)SNPhotoCarmera_ovalClip {

    CGSize size = self.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
