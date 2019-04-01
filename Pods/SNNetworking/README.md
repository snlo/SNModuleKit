# SNNetworking

基于 ’AFNetWoking3.x‘ 的一个网络工作组，旨在集中处理网络请求。当AFNetWoking框架更新时能够快速的替换升级。

## Features

- 提供 NSDictionary、NSArray、NSString 转 JSON字符串
- 提供 散列函数计算的便捷
- 提供 快速创建单例的宏
- 支持 通过创建的缓存文件夹名获取沙盒路径
- 支持 自定义缓存机制
- 集中处理 GET \ POST \ UPLOAD \ DOWNLOAD ，在”SNNetworking.h“的分类中
- 便捷添加自定义COOKIES

## Problems

- 需要为”SNNetworking.h“手动添加分类，在分类中需要对每个接口进行编写设计

## Installation

```
pod 'SNNetworking'
```

## Usage

创建 ”SNNetworking.h“ 的Categories，比如名为”SNNetworking+helper“。在分类中设计接口

SNNetworking+helper.h：

```objective-c
#import "SNNetworking.h"

@interface SNNetworking (helper)


/**
 登录列表

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getStoreListSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;

+ (void)httpsTest;

@end
```

SNNetworking+helper.m：

```objective-c
#import "SNNetworking+helper.h"

@implementation SNNetworking (helper)

+ (void)getStoreListSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    [SNNetworking sharedManager].manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [SNNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",kBASEURL,@"store/getStoreList.data"]
                   parameters:@{@"opt":@"list",
                                @"cell":@"13888888888",
                                } progress:^(double percentage) {
                                    
                                } success:^(id responseObject) {
                                    NSLog(@"%s - responseObject - - %@",__func__,SNString(@"%@",responseObject));
                                    if (success) {
                                        success(responseObject);
                                    }
                                    
                                } failure:^(NSError *error) {
                                    NSLog(@"error - - - %@",error);
                                    if (error) {
                                        failure(error);
                                    }
                                }];
}
+ (void)httpsTest {
    [SNNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",@"https://httpbin.org/",@"post"]
                   parameters:@{@"key": @"value"} progress:^(double percentage) {
                                    
                                } success:^(id responseObject) {
                                    NSLog(@"%s - responseObject - - %@",__func__,SNString(@"%@",responseObject));
                                    
                                } failure:^(NSError *error) {
                                    NSLog(@"error - - - %@",error);
                                }];
}

@end
```

你可以像这样创建多个分类，以便区分不同类型或功能的接口，帮助你管理维护和设计接口。

在实际逻辑业务层的使用时，需导入刚刚创建的分类头文件 ”SNNetworking+helper.h“然后

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SNNetworking httpsTest];
    
    [SNNetworking getStoreListSuccess:^(id responseObject) {
        //处理成功
    } failure:^(NSError *error) {
        //处理失败
    }];
    
    //图片试例
    [SNNetworking getSN_TEST_ImageWithimgProgress:^(double percentage) {
        //下载进度
    } success:^(id responseObject) {
        //下载完成
    } failure:^(NSError *error) {
        //出现了错误
    }];
}
```

更多API的介绍可以在[SNNetworking.h](https://github.com/snlo/SNNetworking/blob/master/SNNetworking/SNNetworking/SNNetworking.h)中查阅

## Requirements

该项目最低支持iOS 8 和Xcode 8

## Thanks

感谢[AFNetworking](https://github.com/AFNetworking/AFNetworking)为我们的项目提供便利

感谢[SNTool](https://github.com/snlo/SNTool)、[SNFoundation](https://github.com/snlo/SNFoundation)

## License

SNNetworking是根据MIT许可证发布的。有关详细信息，请参阅[LICENSE](https://github.com/snlo/SNNetWorkingGroup/blob/master/LICENSE)。