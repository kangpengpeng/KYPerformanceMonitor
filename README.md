# KYPerformanceMonitor

[![CI Status](https://img.shields.io/travis/kangpengpeng/KYPerformanceMonitor.svg?style=flat)](https://travis-ci.org/kangpengpeng/KYPerformanceMonitor)
[![Version](https://img.shields.io/cocoapods/v/KYPerformanceMonitor.svg?style=flat)](https://cocoapods.org/pods/KYPerformanceMonitor)
[![License](https://img.shields.io/cocoapods/l/KYPerformanceMonitor.svg?style=flat)](https://cocoapods.org/pods/KYPerformanceMonitor)
[![Platform](https://img.shields.io/cocoapods/p/KYPerformanceMonitor.svg?style=flat)](https://cocoapods.org/pods/KYPerformanceMonitor)

## Example

主要提供了两个功能
1. 帧率检测
```
    // 帧率检测
    [[KYMonitorManager shared] startMonitorFPS2View:self.view];
```

2. 主线程耗时任务检测
```
    // 耗时任务检测
    [[KYMonitorManager shared] startMonitorTimeConsumingTask:^(NSString * _Nonnull backtraceString) {
        NSLog(@"检测到耗时\n%@", backtraceString);
    }];
```

3. 自定义耗时任务阀值
```
/// 耗时检测策略
typedef NS_ENUM(NSUInteger, KYMonitoringStrategy) {
    /// 任务耗时阀值策略，默认 0.050秒，可在启动前设置阀值thresholdTime
    KYMonitoringStrategyThreshold,
    /// 任务耗时信号量超时次数测试，默认50毫秒内连续出现三次信号超时，即判断为卡顿
    KYMonitoringStrategyAccumulativeTimeout
};

// 耗时任务检测，任务连续超时 50 毫秒 3 次，即认为出现性能问题
// 请根据实际需要调整阀值
// KYMonitoringStrategyAccumulativeTimeout 模式，会在阀值的基础上默认连续超时三次，才任务卡顿
// KYMonitoringStrategyThreshold 一次超时，即认为卡顿
[[KYMonitorManager shared] startMonitorTimeConsumingTaskWithStrategy:KYMonitoringStrategyAccumulativeTimeout thresholdTime:0.050 backtraceBlock:^(NSString * _Nonnull backtraceString) {
    NSLog(@"2检测到耗时\n%@", backtraceString);
}];

```

## Requirements

## Installation

KYPerformanceMonitor is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'KYPerformanceMonitor', '~> 0.1.0'
```

## Author

kangpengpeng, 353327533@qq.com, kangpp@163.com

## License

KYPerformanceMonitor is available under the MIT license. See the LICENSE file for more info.

