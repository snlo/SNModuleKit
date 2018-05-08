# SNDownTimer
机智的定时器，可以全局化的管理你的Timer。如果使用默认间歇回调函数，可以快速的定制你的心跳包机制。如果使用自定义间歇回调函数，可以设计一个个性化的倒计时定时器。

## Usage

CocoaPods：pod 'SNDownTimer'

倒计时定时器：

```objective-c
//formatter的设置请参考 NSDateFormatter 的格式设置
__block SNDownTimer * timer =
    [SNDownTimer downTimerWithFrame:60 interval:1 formatter:@"SS" startBlock:^{
        //第0秒
        NSLog(@"start");
    } intervalBlock:^(NSTimeInterval afterSeconds, NSString *showTimeString) {
        
        if (afterSeconds == 11) {
            [timer invalidate];
            [SNSharedDownTimer invalidate];
        }
        NSLog(@"showTimeString - - %@",showTimeString);
    } completBlock:^{
        //最后一秒结束
        NSLog(@"end");
    }];
//终止 请调用 [timer invalidate]
```

默认间歇回调：

```objective-c
[SNSharedDownTimer downTimerInterval:2 intervalBlock:^{
        NSLog(@"interval");
    }];
//结束 请调用 [SNSharedDownTimer invalidate]
```

## License

SNDownTimer 是根据MIT许可证发布的。有关详细信息，请参阅[LICENSE](https://github.com/snlo/SNDownTimer/blob/master/LICENSE)。