//
//  SNSacnViewController.h
//  SNSacnViewController
//
//  Created by snlo on 2018/4/9.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNScanViewController : UIViewController

/**
 扫描区尺寸
 */
@property (nonatomic, assign) CGSize scanSize;

/**
 扫描区中心点
 */
@property (nonatomic, assign) CGPoint scanCenter;

/**
 扫描区frame
 */
@property (nonatomic, assign) CGRect scanFrame;

/**
 扫描线颜色
 */
@property (nonatomic, strong) UIColor * scanLineColor;

/**
 主题色，包括按钮颜色，标题颜色
 */
@property (nonatomic, strong) UIColor * themeColor;

/**
 内容色
 */
@property (nonatomic, strong) UIColor * contentColor;

/**
 背景风格
 */
@property (nonatomic) UIBarStyle backgroudStyle;

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
