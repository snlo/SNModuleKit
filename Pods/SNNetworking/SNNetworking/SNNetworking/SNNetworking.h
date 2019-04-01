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
 *  指定返回数据类型 manager.responseSerializer = [X serializer]; 默认无证书验证
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

/**
 基础 url
 */
@property (nonatomic, strong) NSString * baseUrl;


/**
 单向验证服务器证书

 @param certificate cer/CA 等自签名证书集合 [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"]
 */
+ (AFHTTPSessionManager *)verificationServerCertificateWith:(NSSet <NSData *> *)certificate;

/**
 双向验证

 @param certificate cer/CA 等证书集合
 @param p12 p12 [[NSBundle mainBundle] pathForResource:@"client"ofType:@"pfx"];
 @param pas 你的密码
 */
+ (AFHTTPSessionManager *)verificationClientCertificateWith:(NSSet <NSData *> *)certificate p12:(NSString *)p12 pas:(NSString *)pas;



#pragma mark -- network methods
/**
 GET
 */
+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url
        parameters:(id)parameters
          progress:(void(^)(double percentage))progress
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure;


/**
 POST
 */
+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url
         parameters:(id)parameters
           progress:(void(^)(double percentage))progress
            success:(void(^)(id responseObject))success
            failure:(void(^)(NSError *error))failure;

/**
 POST AND GET
 */
+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url
          getParams:(id)getParams
         parameters:(id)parameters
           progress:(void(^)(double percentage))progress
            success:(void(^)(id responseObject))success
            failure:(void(^)(NSError *error))failure;

/**
 upload
 */
+ (NSURLSessionDataTask *)uploadWithUrl:(NSString *)url
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
+ (NSURLSessionDownloadTask *)downloadWithUrl:(NSString *)url
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
 当前的 NSURLSessionTask 集合，当某个task不需要等待视图时remove掉就可以
 */
@property (nonatomic, strong) NSCountedSet * networkingCountedSet;

/**
 不展示loadingView
 */
+ (void)donotShowLoadingViewAtTask:(NSURLSessionTask *)task;

/**
 需要逆向更新的标记集合
 */
@property (nonatomic, strong) NSCountedSet * networkingUpateCountedSet;




#pragma mark -- update

/**
 逆向更新，存在判断标记时设置的硬编码
 */
+ (BOOL)updateSourceFrom:(id)fromUpdateMark;

/**
 逆向更新数据标记，标记值为硬编码，注意编码重复
 */
+ (void)willUpdataSourceSetMark:(id)updateMark;

/**
 断网处理，未实现将提示‘网络连接似乎出了点问题’，可用户处理重新加载逻辑
 */
+ (void)brokenSource:(void(^)(void))block;

/**
 请求超时处理，未实现将提示‘网络可能有点缓慢’
 */
+ (void)timeOutSource:(void(^)(void))block;

@end

#import "SNNetworking+SNNetworking.h"

