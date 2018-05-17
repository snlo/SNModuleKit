//
//  SNDownTimer.h
//  SNDownTimer
//
//  Created by snlo on 16/12/9.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNDownTimer : NSObject

@property (nonatomic, readonly) NSTimer * timer;

/**
 自定义间歇回调

 @param timeFrame 总的时间
 @param interval 间歇时间
 @param formatter 时间格式，如果为‘SS’则时间以秒为单位的自然数
 @param startBlock 间歇开始前回调
 @param intervalBlock 间歇回调，‘afterSeconds’剩余时间，’showTimeString‘展示时间
 @param completBlock 总的时间结束时的回调
 @return 返回一个持有内部对象的对象，便于管理内存
 */
+ (instancetype)downTimerWithFrame:(NSTimeInterval)timeFrame
                          interval:(NSTimeInterval)interval
                         formatter:(NSString *)formatter
                        startBlock:(void(^)(NSString *showTimeString))startBlock
                     intervalBlock:(void(^)(NSTimeInterval afterSeconds, NSString *showTimeString))intervalBlock
                      completBlock:(void(^)(void))completBlock;
/**
 默认间歇回调（使用的是全局化的timer）
 
 @param interval 间歇时间
 @param intervalBlock 间歇回调
 */
+ (void)downTimerInterval:(NSTimeInterval)interval intervalBlock:(void(^)(void))intervalBlock;

/**
 使timer作废，并通知倒计时结束
 */
- (void)invalidate;

@end

/**
 全局化的
 */
@interface SNSharedDownTimer : NSObject

+ (instancetype)sharedManeger;

@property (nonatomic, readonly) NSTimer * timer;

/**
 默认间歇回调

 @param interval 间歇时间
 @param intervalBlock 间歇回调
 */
+ (void)downTimerInterval:(NSTimeInterval)interval intervalBlock:(void(^)(void))intervalBlock;

/**
 使timer作废，并清理内存
 */
+ (void)invalidate;

@end
