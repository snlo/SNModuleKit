//
//  SNWkWebViewController.h
//  SNWebViewController
//
//  Created by snlo on 2018/5/16.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge.h>

#import "SNWkWebViewProtocol.h"

@class RACSubject;

@interface SNWkWebViewController : UIViewController <WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate, SNWkWebViewProtocol>

/**
 H5视图
 */
@property (nonatomic, strong) WKWebView * webview;

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
 是否有原生导航栏，默认为‘NO’
 */
@property (nonatomic, assign) BOOL isHasNativeNavigation;

/**
 允许设置标题，默认为‘YES’
 */
@property (nonatomic, assign) BOOL allowSettingTitle;

/**
 处理结果的热信号
 */
@property (nonatomic, strong) RACSubject * subjectPostJs;

/**
 提供给JS端的post函数名默认为‘handlePostJsByNative’。参数必须包含‘url’字段
 */
@property (nonatomic, strong) NSString * postNameByNative;

/**
 返回post处理结果给JS端的函数名默认为‘postCallback’。报文中‘code’为处理结果错误码
 */
@property (nonatomic, strong) NSString * postCallbackNameByNative;

/**
 进度条
 */
@property (nonatomic, strong) UIProgressView * progressView;

@end
