//
//  SNNetworkTransformer.h
//  AFNetworkingTest
//
//  Created by snlo on 16/7/1.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNetworkTransformer : NSObject

/**
 *  过滤responseObject
 */
+ (NSString *)stringFromResponseObject:(id)responseObject;

+ (NSDictionary *)dictionaryFromDataPath:(NSString *)path;

+ (NSDictionary *)dictionaryFromData:(NSData *)data;

//遍历error，找出错误信息
+ (NSMutableDictionary *)valueFromError:(NSError *)error;

@end
