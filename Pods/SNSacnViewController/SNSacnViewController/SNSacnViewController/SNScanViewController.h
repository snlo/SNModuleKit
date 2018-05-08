//
//  SNSacnViewController.h
//  SNSacnViewController
//
//  Created by snlo on 2018/4/9.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNScanViewController : UIViewController

@property (nonatomic, assign) CGSize scanSize;
@property (nonatomic, assign) CGPoint scanCenter;
@property (nonatomic, assign) CGRect scanFrame;

/**
 初始化

 @return 默认
 */
+ (instancetype)scanViewController;

/**
 扫描回调

 @param scanedBlock 扫描成功的回调
 @param canceledBlock 取消的回调
 */
- (void)scanedBlock:(void(^)(NSString * scanedValue))scanedBlock canceledBlock:(void(^)(void))canceledBlock;

/**
 开启闪光灯
 */
- (void)onTorch;

/**
 关闭闪关灯
 */
- (void)offTorch;

@end
