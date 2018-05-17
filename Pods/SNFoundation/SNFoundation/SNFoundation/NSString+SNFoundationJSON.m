//
//  NSString+SNFoundationJSON.m
//  NeighborMom
//
//  Created by snlo on 16/4/29.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import "NSString+SNFoundationJSON.h"

@implementation NSString (SNFoundationJSON)

+ (NSString *)sn_jsonStringWithString:(NSString *)string {
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@""withString:@"\\"]
            ];
}

+ (NSString *)sn_jsonStringWithArray:(NSArray *)array {
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString sn_jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+ (NSString *)sn_jsonStringWithDictionary:(NSDictionary *)dictionary {
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString sn_jsonStringWithObject:valueObj];
        
        if (value) {
            
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+ (NSString *)sn_jsonStringWithObject:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        return [NSString sn_jsonStringWithString:object];
    } else if([object isKindOfClass:[NSDictionary class]]){
        return [NSString sn_jsonStringWithDictionary:object];
    } else if([object isKindOfClass:[NSArray class]]){
        return [NSString sn_jsonStringWithArray:object];
	} else {
		return nil;
	}
}

@end
