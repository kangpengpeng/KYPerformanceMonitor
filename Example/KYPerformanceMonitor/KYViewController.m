//
//  KYViewController.m
//  KYPerformanceMonitor
//
//  Created by kangpengpeng on 12/23/2021.
//  Copyright (c) 2021 kangpengpeng. All rights reserved.
//

#import "KYViewController.h"
#import <KYMonitorManager.h>

@interface KYViewController ()

@end

@implementation KYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 帧率检测
    [[KYMonitorManager shared] startMonitorFPS2View:self.view];
    
    // 耗时任务检测，任务耗时超过 50 毫秒即任务出现性能问题
    [[KYMonitorManager shared] startMonitorTimeConsumingTask:^(NSString * _Nonnull backtraceString) {
        NSLog(@"1检测到耗时\n%@", backtraceString);
    }];
    
    /*
    // 耗时任务检测，任务连续超时 50 毫秒 3 次，即认为出现性能问题
    // 请根据实际需要调整阀值
    // KYMonitoringStrategyAccumulativeTimeout 模式，会在阀值的基础上默认连续超时三次，才任务卡顿
    // KYMonitoringStrategyThreshold 一次超时，即认为卡顿
    [[KYMonitorManager shared] startMonitorTimeConsumingTaskWithStrategy:KYMonitoringStrategyAccumulativeTimeout thresholdTime:0.050 backtraceBlock:^(NSString * _Nonnull backtraceString) {
        NSLog(@"2检测到耗时\n%@", backtraceString);
    }];
     */

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test_01];
}

/// 耗时任务检测
- (void)test_01 {
    sleep(1);
}


@end
