//
//  Target_Public.m
//  SNMediatorKit
//
//  Created by sunDong on 2018/5/1.
//  Copyright © 2018年 AiteCube. All rights reserved.
//

#import "Target_Public.h"

#import "PublicViewController.h"

@implementation Target_Public

- (UIViewController *)Action_nativeFetchPublicViewController:(NSDictionary *)params {
	PublicViewController * VC = [[PublicViewController alloc] init];
//	VC.sn_params = [NSMutableDictionary dictionaryWithDictionary:params];
	return VC;
}

@end
