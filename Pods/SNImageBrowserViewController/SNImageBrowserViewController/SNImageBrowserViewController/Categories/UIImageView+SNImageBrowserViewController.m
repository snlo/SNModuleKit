//
//  UIImageView+SNPhotoBrowsing.m
//  SNImageBrowserViewController
//
//  Created by snlo on 2018/4/16.
//  Copyright © 2018年 snlo All rights reserved.
//

#import "UIImageView+SNImageBrowserViewController.h"

#import <SNTool.h>
#import <ReactiveObjC.h>

#import "SNImageBrowserViewController.h"

@interface UIImageView ()

@property (nonatomic, assign) NSUInteger indexBrowse;

@end

@implementation UIImageView (SNImageBrowserViewController)

- (void)sn_canBrowse:(BOOL)can doBlock:(void(^)(void))doBlock tapGestureBlock:(void(^)(UITapGestureRecognizer * sender))tapGestureBlock {
    if (can) {
        if (doBlock) {
            self.contentMode = UIViewContentModeScaleAspectFill;
            self.layer.masksToBounds = YES;
            doBlock();
            self.userInteractionEnabled = YES;
            
            [self.gestureRecognizers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self removeGestureRecognizer:obj];
            }];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
            [self addGestureRecognizer:tap];
            
            [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
                if (tapGestureBlock) {
                    tapGestureBlock(tap);
                }
            }];
        }
    }
}

- (void)sn_browsingWithImageNameArray:(NSArray <NSString *> *)nameArray viewArray:(NSArray <UIImageView *> *)viewArray {
    
    [self sn_canBrowse:YES doBlock:^{
        [viewArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.indexBrowse = idx;
        }];
    } tapGestureBlock:^(UITapGestureRecognizer *sender) {
        
        SNImageBrowserViewController *photo = [[SNImageBrowserViewController alloc] initWithImageNameArray:nameArray currentImageIndex:((int)self.indexBrowse) imageViewArray:[NSMutableArray arrayWithArray:viewArray] imageViewFrameArray:nil];
        
        [[SNTool topViewController] presentViewController:photo animated:YES completion:nil];
    }];
}

- (void)sn_browsingWithDataSource:(NSMutableDictionary <NSString *, UIImageView *>* )dataSource orderlyImageNameArray:(NSMutableArray <NSString *> *)nameArray; {
    
    [self sn_canBrowse:YES doBlock:^{
        
    } tapGestureBlock:^(UITapGestureRecognizer *sender) {
        NSMutableArray <UIImageView *> * arrayView = [[NSMutableArray alloc] init];
        [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrayView addObject:[dataSource objectForKey:obj]];
        }];
        [arrayView enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.indexBrowse = idx;
        }];
        
        SNImageBrowserViewController *photo = [[SNImageBrowserViewController alloc] initWithImageNameArray:nameArray currentImageIndex:((int)self.indexBrowse) imageViewArray:arrayView imageViewFrameArray:nil];
        
        [[SNTool topViewController] presentViewController:photo animated:YES completion:nil];
    }];
}

#pragma mark -- event reponse


#pragma mark -- setter

- (void)setIndexBrowse:(NSUInteger)indexBrowse {
    NSNumber * number = [NSNumber numberWithUnsignedInteger:indexBrowse];
    objc_setAssociatedObject(self, @selector(indexBrowse), number, OBJC_ASSOCIATION_ASSIGN);
}
- (NSUInteger)indexBrowse {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number unsignedIntegerValue];
}


@end
