//
//  SNNetworking.h
//  SNNetworking
//
//  Created by snlo on 16/6/30.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>

__attribute__((objc_subclassing_restricted))

__attribute__((objc_runtime_name("snloбЇЯАзЪСЯ")))

@interface SNNetworking : NSObject

+ (instancetype)sharedManager;

/**
 *  对于http这种非安全的链接
 *
 *  在info.plist中添加
 *  App Transport Security Settings
 *  Allow Arbitrary Loads 属设置为 YES
 */

/**
 *  指定返回数据类型 manager.responseSerializer = [X serializer];
 *  X
 *  AFHTTPResponseSerializer            //data 二进制格式
 *  AFJSONResponseSerializer            //JSON 默认返回的是json数据
 *  AFXMLParserResponseSerializer       //XML,只能返回XMLParser,还需要NSParser自己通过代理方法解析
 *  AFXMLDocumentResponseSerializer     //XML(Mac:OS X)
 *  AFPropertyListResponseSerializer    //属性列表PList(是一种特殊的XML,解析起来相对容易)
 *  AFImageResponseSerializer           //image
 *  AFCompoundResponseSerializer        //组合的形式
 */

@property (nonatomic) AFHTTPSessionManager * manager;

@property (nonatomic, strong) NSString * basrUrl;

#pragma mark -- network methods
/**
 GET
 */
+ (void)getWithUrl:(NSString *)url
        parameters:(id)parameters
          progress:(void(^)(double percentage))progress
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure;


/**
 POST
 */
+ (void)postWithUrl:(NSString *)url
         parameters:(id)parameters
           progress:(void(^)(double percentage))progress
            success:(void(^)(id responseObject))success
            failure:(void(^)(NSError *error))failure;

/**
 upload
 */
+ (void)uploadWithUrl:(NSString *)url
           parameters:(id)parameters
            dataArray:(NSArray <NSData *> *)dataArray
                 name:(NSString *)name
       fileSuffixName:(NSString *)fileSuffixName
                 type:(NSString *)type
             progress:(void(^)(double percentage))progress
              success:(void(^)(id responseObject))success
              failure:(void(^)(NSError *error))failure;

/**
 download
 */
+ (void)downloadWithUrl:(NSString *)url
           fileDownPath:(NSString *)fileDownPath
               progress:(void(^)(double percentage))progress
                success:(void(^)(id responseObject))success
                failure:(void(^)(NSError *error))failure;

#pragma mark -- network state
/**
 cancel request
 */
+ (void)cancelRequest;

/**
 开始监听网络，建议延时开始；
 */
+ (void)startNetMonitoring;

/**
 监听结果
 */
+ (void)netMonitoringWithResultBlock:(void(^)(AFNetworkReachabilityStatus status, NSString * statusValue))resultBlock;

/**
 结束监听
 */
+ (void)stopNetMonitoring;

#pragma mark -- lodaing
/**
 取消等待视图
 */
+ (void)loadingInvalid;

/**
 恢复等待视图，如果实现了succes、error block 需要再次实现一次。
 */
+ (void)loadingRecovery;

#pragma mark -- update
/**
 更新数据，类似于单一冷信号，所以需要在动态方法里面实现

 @param block 需要更新操作时实现
 */
+ (void)updataSource:(void(^)(id object))block;

/**
 准备更新数据

 @param block 需要传递参数时实现
 */
+ (void)willUpdataSource:(id(^)(void))block;

@end
