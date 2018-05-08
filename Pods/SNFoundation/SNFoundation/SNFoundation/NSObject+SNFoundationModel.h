//
//  NSObject+SNFoundationModel.h
//  snlo
//
//  Created by snlo on 2017/11/25.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SNFoundationModelKeyValueProtocol <NSObject>

@optional

/**
 模型类可自定义属性名称<json key名, 替换实际属性名>
 */
+ (NSDictionary <NSString *, NSString *> *)sn_modelReplacePropertyMapper;

/**
 模型数组/字典元素对象可自定义类<替换实际属性名,实际类>
 */
+ (NSDictionary <NSString *, Class> *)sn_modelReplaceContainerElementClassMapper;

/**
 模型类可自定义属性类型<替换实际属性名,实际类>
 */
+ (NSDictionary <NSString *, Class> *)sn_modelReplacePropertyClassMapper;

@end

@interface NSObject (SNFoundationModel) <SNFoundationModelKeyValueProtocol>


/**
 把json解析为模型对象
 
 @param json json数据对象
 @return 模型对象
 */
+ (id)sn_modelWithJson:(id)json;

/**
 解析为模型对象，并过滤 float
 
 @param json json数据对象 or 字典 or 数组
 @return 模型对象
 */
+ (id)sn_modelOnlyStringWithJson:(id)json;

/**
 把json解析为模型对象
 
 @param json json数据对象
 @param keyPath json key的路径
 @return 模型对象
 */
+ (id)sn_modelWithJson:(id)json keyPath:(NSString *)keyPath;


/**
 把模型对象转换为字典
 
 @return 字典对象
 */
- (NSDictionary *)sn_dictionary;

/**
 把模型对象转换为json字符串
 
 @return json字符串
 */
- (NSString *)sn_json;


/**
 复制模型对象
 */
- (id)sn_copy;

/**
 序列化模型对象
 */
- (void)sn_encode:(NSCoder *)aCoder;


/**
 反序列化模型对象
 */
- (void)sn_decode:(NSCoder *)aDecoder;

@end
