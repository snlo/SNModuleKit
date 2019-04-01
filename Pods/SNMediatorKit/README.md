# SNMediatorKit

模块化中间件，有助于本地模块间解耦甚至是相互独立。利用它可以实现模块间通信和调度，并且支持本地和远程，还提供通信和调度的本地缓存。

## 特征

- 支持远程和本地调度
- 通信缓存
- Runtime实现

## API说明

低阶函数

```objc
/**
 扩展(统一API,)

 @param module 本地组件名
 @param url 远程调度链接
 @param action 事件名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 返回任意类型
 */
+ (id)module:(NSString *)module url:(NSURL *)url action:(NSString *)action params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
```

高阶函数

```objc
/**
 调度辅助函数，会包含一些特殊处理
 
 @param module 本地组件名
 @param url 远程调度链接
 @param action 事件名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 可能是'UIViewController'、‘UIView’、‘NSDictionary’、‘NSMutableDictionary’、‘NSArray’、‘NSMutableArray’、‘NSNumber’、‘NSSet’、‘NSMutableSet’、‘NSString’
 */
+ (id)mediateModule:(NSString *)module url:(NSURL *)url action:(NSString *)action params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 调度辅助函数，会包含一些特殊处理
 
 @param module 本地组件名
 @param url 远程调度链接
 @param signal signal:信号名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 返回信号‘RACSignal’、‘RACCommand’、‘RACSubject’
 */
+ (id)mediateModule:(NSString *)module url:(NSURL *)url signal:(NSString *)signal params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget __attribute__((warn_unused_result));
```

## 使用

首先在模块中创建类似名为`Target_kTest`的Target-Action类(`Target_`、`Action_`为硬编码)：

```objective-c
#import <Foundation/Foundation.h>

@interface Target_kTest : NSObject

- (UIViewController *)Action_nativeTestViewController:(NSDictionary *)params;

@end
    
#import "Target_kTest.h"

@implementation Target_kTest

- (UIViewController *)Action_nativeTestViewController:(NSDictionary *)params {
	UIViewController * vc = [[UIViewController alloc] init];
	vc.view.backgroundColor = [UIColor blackColor];
	return vc;
}

@end
```

然后在其它模块中使用：

```objective-c
__block UIViewController * vc = [SNMediator mediateModule:@"kTest" url:nil action:@"nativeTestViewController" params:nil shouldCacheTarget:NO];
/*
"kTest":为‘Target_’硬编码之后的Target名，通常被命名为模块名
"nativeTestViewController":为Action名，其中‘native’为本地Action的硬编码标识，SNMediatorKit的调度顺序：远程调度 —> 本地调度，所以在各模块中只有本地调度，若有远程调度的需求，也没关系，因为始终都会到达本地调度这一步。
*/
    [self presentViewController:vc animated:YES completion:^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:^{

            }];
        });

    }];
```

## 缺点

- Target-Action参数硬编码

## 安装

```yaml
pod 'SNMediatorKit'
```

## 要求

iOS 8.0 或者更高版本

## 许可

`SNMediatorKit` 是根据麻省理工学院的许可证发布的。有关详细信息请参阅[LICENSE](https://github.com/snlo/SNMediatorKit/blob/master/LICENSE)。