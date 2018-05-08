//
//  SNFileNetworkManager.h
//  AFNetworkingTest
//
//  Created by snlo on 16/7/1.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNFileNetworkManager : NSObject

/**
 *  通过创建的缓存文件夹名获取沙盒路径
 *
 *  @param folderName 要创建的缓存文件夹名称，如果不存在才会被创建
 *  @return 缓存沙盒路径
 */
+ (NSString *)cachePathForDocumentWithComponent:(NSString *)folderName;

//获取当前时间
+ (NSString *)currentTime;

@end

#define kSNCacheName @"SNCache"
