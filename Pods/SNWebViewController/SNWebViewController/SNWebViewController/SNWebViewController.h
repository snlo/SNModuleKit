//
//  SNWebViewController.h
//  SNWebViewController
//
//  Created by snlo on 2018/5/16.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge.h>

#import "SNWebViewProtocol.h"

@interface SNWebViewController : UIViewController <UIWebViewDelegate, SNWebViewProtocol>

/**
 H5视图
 */
@property (nonatomic, strong) UIWebView * webview;

/**
 JS桥接
 */
@property (nonatomic) WebViewJavascriptBridge * bridge;

/**
 加载链接
 */
@property (nonatomic, strong) NSString * reloadUrl;

/**
 标题，用于区别self.title
 */
@property (nonatomic, readonly) NSString * webTitle;

/**
 是否有原生导航栏，默认为NO
 */
@property (nonatomic, assign) BOOL isHasNativeNavigation;

/**
 允许设置标题
 */
@property (nonatomic, assign) BOOL allowSettingTitle;

/**
 进度条
 */
@property (nonatomic, strong) UIProgressView * progressView;

@end
