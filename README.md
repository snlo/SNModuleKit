# SNModuleKit
模块化架构依赖库，让重构和团队开发都一样简单。实施模块化可以让项目更加适合团队开发，模块与模块之间相互独立互不干扰，并且模块与模块间的耦合度趋近于零。

## 特征

- 使用CocoaPods依赖各个组件和插件
- 可定制化
- 可快速开始业务模块开发
- 提供模块项目模板、文件模板和代码片段

## 目录结构介绍

- SNModuleKit.h：依赖库头文件
- /Config：配置文件
- /Components：组件
- /Controls：可视化控件
- /Plugins：插件
- /Middlewares：中间件
- /Resources：资源文件

## 使用

导入

```swift
#ifndef PrefixHeader_pch
#define PrefixHeader_pch

// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.

#import "SNModuleKit.h"

#endif /* PrefixHeader_pch */
```

资源文件中包含了`SNModuleKit`所提供的模块项目模板、文件模板和代码片段。在使用时，或者需要更新时，只需要在终端中运行相关脚本即可。

```
./Resources
	setupCodeSnippets
	setupFile
	setupProject
```

![1](https://github.com/snlo/SNModuleKit/blob/master/SNModuleKit/Assets.xcassets/1.imageset/1.jpg)

模块项目模板使用，相对来说比较麻烦一点，不过还好创建模块只是低频需求。它麻烦的就在于通过模板创建出来的模块文件夹是个虚拟文件夹，并且可能需要重命名该模块文件夹的名字。下面我们以图文的形式来说明下。

1. 新建模块工程`shift`+`command`+`n`，选择`Snlo Module App`![2](/Users/snlo/Desktop/gitHub/SNModuleKit/SNModuleKit/Assets.xcassets/2.imageset/2.jpg)

2. 给模块取名，注意模块名是`Module`之后的命名![3](/Users/snlo/Desktop/gitHub/SNModuleKit/SNModuleKit/Assets.xcassets/3.imageset/3.jpg)

3. 特别强调，被创建出来的模块文件夹是一个虚拟文件夹，也就是在修改虚拟文件夹中的文件时，实际的文件不会发生改变。![4](/Users/snlo/Desktop/gitHub/SNModuleKit/SNModuleKit/Assets.xcassets/4.imageset/4.jpg)

4. 重命名模块名，在新建模块时无法对模块名进行变量处理。如果你知道怎么处理请给我留言或发邮件给我，谢谢！![5](/Users/snlo/Desktop/gitHub/SNModuleKit/SNModuleKit/Assets.xcassets/5.imageset/5.jpg)

5. 使虚拟模块文件实体化![6](/Users/snlo/Desktop/gitHub/SNModuleKit/SNModuleKit/Assets.xcassets/6.imageset/6.jpg)

   ![7](/Users/snlo/Desktop/gitHub/SNModuleKit/SNModuleKit/Assets.xcassets/7.imageset/7.jpg)

6. 使用模块中的`Tagret_Action`，需要遵守模块化规范。例如在`Tagret_Public`文件中

   ```objc
   #import <Foundation/Foundation.h>
   #import <UIKit/UIKit.h>
   
   @interface Target_Public : NSObject
   
   - (UIViewController *)Action_nativeFetchPublicViewController:(NSDictionary *)params;
   
   @end
   ```

   其中`Target_`和`Action_`是硬编码，`native`是用来标记为本地调度的硬编码。

## 缺点

- 模板更新需手动执行脚本
- 模块项目模板需单独创建

## 安装

##### Mini版

此版本为精简版本，也就是只有中间件的存在，如果想要定制化你的模块依赖库的话，可以采用它。

```yaml
pod 'SNModuleKit', '~> 1.0'
```

##### Full版

此版本专为开发团队所准备的，这也是新项目开始阶段的最佳选择。

```yaml
pod 'SNModuleKit'
```

## 要求

iOS 8.0 或者更高版本

## 许可

`SNMediatorKit`是根据麻省理工学院的许可证发布的。有关详细信息请参阅[LICENSE](https://github.com/snlo/SNModuleKit/blob/master/LICENSE)。