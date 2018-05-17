//
//  NSString+SNFoundationJSON.h
//  NeighborMom
//
//  Created by snlo on 16/4/29.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SNFoundationJSON)

+ (NSString *)sn_jsonStringWithDictionary:(NSDictionary *)dictionary;
+ (NSString *)sn_jsonStringWithArray:(NSArray *)array;
+ (NSString *)sn_jsonStringWithString:(NSString *)string;
+ (NSString *)sn_jsonStringWithObject:(id)object;

@end
