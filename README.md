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