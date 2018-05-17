//
//  SNWebViewController.m
//  SNWebViewController
//
//  Created by snlo on 2018/5/16.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNWebViewController.h"

#import <ReactiveObjC.h>
#import <SNTool.h>

#import <SNDownTimer.h>

#import "NSURLProtocol+SNWebViewController.h"

@interface SNWebViewController ()

@property (nonatomic) Class classURLProtocol;
@property (nonatomic, strong) NSArray <NSString *> * scriptMessageHandlerNames;

@property (nonatomic) SNDownTimer * downTimer;

@property (nonatomic, strong) NSString * webTitle;

@end

@implementation SNWebViewController

- (void)dealloc {
    NSLog(@"%s",__func__);
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

#pragma mark -- <UITableViewDelegate>、、
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"start url - - %@",request.URL.absoluteString);
    
    //    if(![self.reloadUrl isEqualToString:request.URL.absoluteString] && [request.URL.absoluteString containsString:@"http://qj.goshome.com"]) {
    //        return NO;
    //    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self downTimer];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.webTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.downTimer invalidate];
    self.downTimer = nil;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.downTimer invalidate];
    self.downTimer = nil;
}
#pragma mark -- CustomDelegate

#pragma mark -- event response

#pragma mark -- public methods
- (void)setURLProtocolClass:(Class)class {
    self.classURLProtocol = class;
}

#pragma mark -- private methods
- (void)base_web_configureUserInterface {
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)base_web_configureDataSource {
    
    self.allowSettingTitle = YES;
}

#pragma mark -- getter setter
- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, [SNTool statusBarHeight], SCREEN_WIDTH, SCREEN_HEIGHT - [SNTool homeBarHeight] - [SNTool statusBarHeight])];
        
        _webview.delegate = self;
        
        _webview.scalesPageToFit = YES;
        _webview.allowsInlineMediaPlayback = YES;
        _webview.mediaPlaybackAllowsAirPlay = YES;
        _webview.suppressesIncrementalRendering = YES;
        
        _webview.scrollView.bounces = NO;
        _webview.scrollView.showsVerticalScrollIndicator = NO;
        
        [_webview sizeToFit];
        
        // 最后将webView添加到界面
        [self.view addSubview:_webview];
    } return _webview;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progress = 0.0;
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
        _progressView.hidden = YES;
        [self.webview addSubview:_progressView];
    } return _progressView;
}
- (SNDownTimer *)downTimer {
    if (!_downTimer) {
        //dd天 HH小时 mm分 ss秒
        __weak typeof(self) weakSelf = self;
        _downTimer = [SNDownTimer downTimerWithFrame:60 interval:0.1 formatter:@"SS" startBlock:^(NSString *showTimeString){
            __strong typeof(weakSelf) self = weakSelf;

            self.progressView.hidden = NO;
            self.progressView.progress = 0;
        } intervalBlock:^(NSTimeInterval afterSeconds, NSString *showTimeString) {
            __strong typeof(weakSelf) self = weakSelf;

            self.progressView.progress = 1- [showTimeString floatValue]/60;
        } completBlock:^{
            __strong typeof(weakSelf) self = weakSelf;

            self.progressView.progress = 0.0;
            self.progressView.hidden = YES;
            [self->_downTimer invalidate];
        }];
    } return _downTimer;
}
- (WebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        [WebViewJavascriptBridge enableLogging];
        
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webview];
        [_bridge setWebViewDelegate:self];
    } return _bridge;
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


@end
