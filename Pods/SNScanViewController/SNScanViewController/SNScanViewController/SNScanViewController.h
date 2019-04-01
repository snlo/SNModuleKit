//
//  SNSacnViewController.h
//  SNSacnViewController
//
//  Created by snlo on 2018/4/9.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SNScanView.h"

@interface SNScanViewController : UIViewController

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
 视图
 */
@property (nonatomic, strong) SNScanView * viewScan;

@end
