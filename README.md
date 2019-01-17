# SNModuleKit
模块化架构依赖库，让重构和团队开发都一样简单。

### 目录结构介绍

- SNModuleKit.h：依赖库头文件
- /Config：配置文件
- /Components：组件
- /Controls：可视化控件
- /Plugins：插件
- /Middlewares：中间件
- /Resources：资源文件

### Mini版

此版本为精简版本，也就是只有中间件的存在，如果想要定制化你的模块依赖库的话，可以采用它。

```yaml
pod 'SNModuleKit', '~> 1.0'
```

### Full版

此版本专为开发团队所准备的，这也是新项目开始阶段的最佳选择。

```yaml
pod 'SNModuleKit'
```