//
//  SNImageBrowserViewController.m
//  SNImageBrowserViewController
//
//  Created by snlo on 2017/12/5.
//  Copyright © 2017年 snlo All rights reserved.
//

#import "SNImageBrowserViewController.h"
#import "SNImageBrowserMainScrollView.h"
#import "SNImageBrowserTranslation.h"

#import <SNTool.h>

#import "UIView+SNImageBrowserViewController.h"

@interface SNImageBrowserViewController () <SNImageBrowserMainScrollViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) NSArray *imageNameArray;//图片名字数组
@property (nonatomic,assign) int currentImageIndex;//当前图片索引
@property (nonatomic,strong) NSMutableArray *imageViewArray;//外部的图片控件数组
@property (nonatomic,strong) SNImageBrowserMainScrollView *mainScrollView;//主控件
@property (nonatomic,strong) SNImageBrowserTranslation *translation;//转场动画管理者

@end

@implementation SNImageBrowserViewController

#pragma mark - 生命周期
- (instancetype)initWithImageNameArray:(NSArray *)imageNameArray currentImageIndex:(int)currentImageIndex imageViewArray:(NSMutableArray *)imageViewArray imageViewFrameArray:(NSMutableArray *)imageViewFrameArray {
    if (self = [self init])
    {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;//设置modal的方式，这样背后的控制器的view不会消失
        self.transitioningDelegate = self;//转场管理者
        self.imageNameArray = [imageNameArray copy];
        self.currentImageIndex = currentImageIndex;
        self.imageViewArray = imageViewArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUIComponent];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - UI相关
- (void)setUIComponent {
    self.view.backgroundColor = COLOR_RGB(0x000000, 1.0);
    
    self.mainScrollView.hidden = YES;
}

#pragma mark - 图片scrollview控件的代理
- (void)SNImageBrowserMainScrollViewDoSingleTapWithImageFrame:(CGRect)imageFrame {
    self.translation.backImageFrame = imageFrame;//赋值给转场管理对象做动画
    //需要退回页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)SNImageBrowserMainScrollViewChangeCurrentIndex:(int)currentIndex {
    self.currentImageIndex = currentIndex;
    self.translation.currentIndex = self.currentImageIndex;//传值给转场管理对象
    
    //隐藏或显示对应的外部imageView
    for (int i = 0; i < self.imageViewArray.count; i++)
    {
        ((UIImageView *)self.imageViewArray[i]).hidden = (i == self.currentImageIndex);
    }
}

- (void)SNImageBrowserMainScrollViewDoingDownDrag:(CGFloat)dragProportion {
    self.view.backgroundColor = COLOR_RGB(0x000000, (1 - dragProportion));
}

- (void)SNImageBrowserMainScrollViewNeedBackWithImageFrame:(CGRect)imageFrame {
    self.translation.backImageFrame = imageFrame;//赋值给转场管理对象做动画
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIViewControllerTransitioningDelegate(转场动画代理)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.translation.photoBrowserShow = YES;
    return self.translation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.translation.photoBrowserShow = NO;
    return self.translation;
}

#pragma mark - 懒加载
- (SNImageBrowserTranslation *)translation {
    if (!_translation) {
        _translation = [[SNImageBrowserTranslation alloc] init];
//        _translation.endBlock = ^{
//            NSLog(@"end");
//        };
        _translation.photoBrowserMainScrollView = (UIView *)self.mainScrollView;
        _translation.imageViewArray = self.imageViewArray;
        _translation.imageNameArray = self.imageNameArray;
        _translation.currentIndex = self.currentImageIndex;//这个参数要最后赋值，因为他的setter中用到了上面的参数
    }
    return _translation;
}

- (SNImageBrowserMainScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[SNImageBrowserMainScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.yy_width, self.view.yy_height) imageNameArray:self.imageNameArray currentImageIndex:self.currentImageIndex];
        [self.view addSubview:self.mainScrollView];
        _mainScrollView.delegate = self;
        _mainScrollView.hidden = YES;
    }
    return _mainScrollView;
}

@end
