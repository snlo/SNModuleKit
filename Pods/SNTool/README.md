# SNTool
一些常用的代码片段的集合，不定时更新。你也可以把你的代码片段添加进来。

## Features

- [x] 系统弹窗兼容到iOS 8
- [x] 对[MBProgressHUD](https://github.com/jdg/MBProgressHUD)的统一处理，自定义视图替换MBProgressHUD
- [x] NSString、UIColor处理
- [x] UIViewController堆栈寻址
- [x] 常见义务类型正则
- [x] 高斯模糊加工
- [x] 导航栏、标签栏、状态栏高度
- [x] 本地国际化
- [x] 安全单例工厂
- [x] RunTime扩展
- [x] Protocol在OC中的POP实现
- [x] 安全Category

## 使用

详细API参见[SNTool.h](https://github.com/snlo/SNTool/blob/master/SNTool/SNTool/SNTool.h)，下面是使用样例：

```objective-c
#import <SNTool.h>
///
[SNTool showAlertStyle:UIAlertControllerStyleAlert title:@"title" msg:@"msg" chooseBlock:^(NSInteger actionIndx) {
        if (actionIndx == 0) {
            NSLog(@"cancel");
        } else if (actionIndx == 1) {
            NSLog(@"done");
        }
    } actionsStatement:@"cancel",@"done", nil];
```

## 安装

```
pod 'SNTool'
```

## 要求

iOS 8.0 或者更高版本

## 说明

部分源码来自[libextobjc](https://github.com/jspahrsummers/libextobjc)

依赖的第三方库[MBProgressHUD](https://github.com/jdg/MBProgressHUD)，后期可能会移除

## License

SNTool is released under the MIT license. See [LICENSE](https://github.com/snlo/SNTool/blob/master/LICENSE) for details.