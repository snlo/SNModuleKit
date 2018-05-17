//
//  SNWkWebViewController.m
//  SNWebViewController
//
//  Created by snlo on 2018/5/16.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNWkWebViewController.h"

#import <ReactiveObjC.h>
#import <SNTool.h>
#import <Aspects.h>

#import <SNNetworking.h>
#import <SNFoundation.h>

#import "NSURLProtocol+SNWebViewController.h"

@interface SNWkWebViewController ()

@property (nonatomic) Class classURLProtocol;
@property (nonatomic, strong) NSMutableArray <NSString *> * scriptMessageHandlerNames;
@property (nonatomic, strong) NSString * webTitle;

@end

@implementation SNWkWebViewController
- (void)dealloc {
    [self.scriptMessageHandlerNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.webview.configuration.userContentController removeScriptMessageHandlerForName:obj];
    }];
}
#pragma mark -- life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.isHasNativeNavigation) {
        [SNTool fetchNavigationController].navigationBar.hidden = YES;
    } else {
        [SNTool fetchNavigationController].navigationBar.hidden = NO;
        self.progressView.frame = CGRectMake(0, [SNTool navigationBarHeight], SCREEN_WIDTH, 3);
    }
    adjustsScrollViewInsets_NO(self.webview.scrollView, self);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (!self.isHasNativeNavigation) {
        [SNTool fetchNavigationController].navigationBar.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self base_web_configureUserInterface];
    [self base_web_configureDataSource];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.webview.frame = CGRectMake(0, [SNTool statusBarHeight], SCREEN_WIDTH, SCREEN_HEIGHT - [SNTool homeBarHeight] - [SNTool statusBarHeight]);
}

#pragma mark -- <WKScriptMessageHandler>、、
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",message.body);
}
#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%@",message);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"%@",message);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark -- CustomDelegate

#pragma mark -- event response
- (void)handlePostJsByNative:(id)body {
    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:body];

    __block NSString * urlString = @"";
    __block NSMutableDictionary * muDic = [[NSMutableDictionary alloc] init];

    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"url"]) {
            urlString = obj;
        } else {
            [muDic setValue:obj forKey:key];
        }
    }];
    
    [SNNetworking loadingInvalid];
    [SNNetworking postWithUrl:SNString(@"%@%@",[SNNetworking sharedManager].basrUrl,urlString) parameters:muDic progress:nil success:^(id responseObject) {
        [SNNetworking loadingRecovery];
        [self.webview evaluateJavaScript:[NSString stringWithFormat:@"postCallback('%@')",
                                          [responseObject sn_json]] completionHandler:^(id _Nullable data, NSError * _Nullable error) {
            if (!error) {
                [self.subjectPostJs sendNext:@{@"url":urlString,@"data":responseObject,@"fromdata":muDic}];
            }
        }];
    } failure:^(NSError *error) {
        [SNNetworking loadingRecovery];
        [self.subjectPostJs sendNext:@{@"error":SNString(@"%ld",(long)error.code)}];
        [self.webview evaluateJavaScript:[NSString stringWithFormat:@"postCallback('%@')",[@{@"code":SNString(@"%ld",(long)error.code)} sn_json]] completionHandler:^(id _Nullable data, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",error);
            } else {
                NSLog(@"%@",data);
            }
        }];
    }];
}

#pragma mark -- public methods
- (void)setURLProtocolClass:(Class)class scriptMessageHandlerNames:(NSArray <NSString *> *)names {
    self.classURLProtocol = class;
    self.scriptMessageHandlerNames = [NSMutableArray arrayWithArray:names];
}

#pragma mark -- private methods
- (void)base_web_configureUserInterface {
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)base_web_configureDataSource {
    
    self.allowSettingTitle = YES;
    
//    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.reloadUrl]]];
    
    [RACObserve(self.webview, estimatedProgress) subscribeNext:^(id  _Nullable x) {
#pragma mark -- 进度条
        self.progressView.progress = [x floatValue];
        self.progressView.hidden = NO;
        if ([x floatValue] == 1.0) {
            self.progressView.progress = 0.0;
            self.progressView.hidden = YES;
        }
    }];
    [RACObserve(self.webview, title) subscribeNext:^(id  _Nullable x) {
        if (self.allowSettingTitle) {
            self.webTitle = x;
        }
    }];
    
#pragma mark -- hook userContentController
    NSError * error;
    [self aspect_hookSelector:@selector(userContentController:didReceiveScriptMessage:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, WKUserContentController * userContentController, WKScriptMessage * message) {
        
        if ([message.name isEqualToString:self.postNameByNative]) {
            [self handlePostJsByNative:message.body];
        }
    } error:&error];
}

#pragma mark -- getter setter

- (WKWebView *)webview {
    if (!_webview) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.selectionGranularity = WKSelectionGranularityCharacter;
        config.allowsInlineMediaPlayback = YES; // 允许在线播放
        config.allowsAirPlayForMediaPlayback = YES; //允许视频播放
        config.selectionGranularity = YES; // 允许可以与网页交互，选择视图
        config.suppressesIncrementalRendering = YES; // 是否支持记忆读取
        config.processPool = [[WKProcessPool alloc] init]; // web内容处理池
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preferences;
        
        WKUserContentController *user = [[WKUserContentController alloc]init];
        config.userContentController = user;
        
        _webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, [SNTool statusBarHeight], SCREEN_WIDTH, SCREEN_HEIGHT - [SNTool homeBarHeight] - [SNTool statusBarHeight]) configuration:config];
        
        if ([_webview respondsToSelector:@selector(setNavigationDelegate:)]) {
            _webview.navigationDelegate = self;
        }
        if ([_webview respondsToSelector:@selector(setUIDelegate:)]) {
            _webview.UIDelegate = self;
        }
        
        _webview.allowsBackForwardNavigationGestures = YES; //开启手势触摸
        _webview.scrollView.bounces = NO;
        _webview.scrollView.showsVerticalScrollIndicator = NO;
        _webview.scrollView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:_webview];
        
    } return _webview;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progress = 0.0;
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
        
        [self.webview addSubview:_progressView];
    } return _progressView;
}
- (WebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        [WebViewJavascriptBridge enableLogging];
        
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webview];
        [_bridge setWebViewDelegate:self];
    } return _bridge;
}

- (RACSubject *)subjectPostJs {
    if (!_subjectPostJs) {
        _subjectPostJs = [RACSubject subject];
    } return _subjectPostJs;
}


#pragma mark -- setter
- (void)setIsHasNativeNavigation:(BOOL)isHasNativeNavigation {
    _isHasNativeNavigation = isHasNativeNavigation;
    if (_isHasNativeNavigation) {
        [SNTool fetchNavigationController].navigationBar.hidden = NO;
        [RACObserve(self.webview, frame) subscribeNext:^(id  _Nullable x) {
            CGFloat offset = [SNTool statusBarHeight] + [SNTool navigationBarHeight] - self.webview.frame.origin.y;
            self.progressView.frame = CGRectMake(0, offset > 0 ? offset : 0, SCREEN_WIDTH, 3);
        }];
    } else {
        [SNTool fetchNavigationController].navigationBar.hidden = YES;
    }
}
- (void)setReloadUrl:(NSString *)reloadUrl {
    _reloadUrl = reloadUrl;
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_reloadUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0]];
#warning cache for webview
    //    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_reloadUrl]]];
}
- (void)setClassURLProtocol:(Class)classURLProtocol {
    _classURLProtocol = classURLProtocol;
    
    if (_classURLProtocol) {
        [NSURLProtocol registerClass:_classURLProtocol];
        for (NSString* scheme in @[@"http", @"https"]) {
            [NSURLProtocol sn_registerScheme:scheme];
        }
    }
}
- (void)setScriptMessageHandlerNames:(NSMutableArray<NSString *> *)scriptMessageHandlerNames {
    _scriptMessageHandlerNames = scriptMessageHandlerNames;
    
    [self.scriptMessageHandlerNames addObject:self.postNameByNative];
    
    if (_scriptMessageHandlerNames) {
        [_scriptMessageHandlerNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.webview.configuration.userContentController addScriptMessageHandler:self name:obj];
        }];
    }
}

@synthesize postNameByNative = _postNameByNative;
- (void)setPostNameByNative:(NSString *)postNameByNative {
    _postNameByNative = postNameByNative;
}
- (NSString *)postNameByNative {
    if (!_postNameByNative) {
        _postNameByNative = @"handlePostJsByNative";
    } return _postNameByNative;
}
@synthesize postCallbackNameByNative = _postCallbackNameByNative;
- (void)setPostCallbackNameByNative:(NSString *)postCallbackNameByNative {
    _postCallbackNameByNative = postCallbackNameByNative;
}
- (NSString *)postCallbackNameByNative {
    if (!_postCallbackNameByNative) {
        _postCallbackNameByNative = @"postCallback";
    } return _postCallbackNameByNative;
}

@end
