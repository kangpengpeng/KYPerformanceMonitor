//
//  KYRunLoopObserver.h
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2019/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 耗时检测策略
typedef NS_ENUM(NSUInteger, KYMonitoringStrategy) {
    /// 任务耗时阀值策略，默认 0.050秒，可在启动前设置阀值thresholdTime
    KYMonitoringStrategyThreshold,
    /// 任务耗时信号量超时次数测试，默认50毫秒内连续出现三次信号超时，即判断为卡顿
    KYMonitoringStrategyAccumulativeTimeout
};

typedef void(^KYBacktraceBlock)(NSString *backtraceString);

@interface KYRunLoopObserver : NSObject

@property (nonatomic, assign)KYMonitoringStrategy monitoringStrategy;

/// 耗时阈值（毫秒），默认 0.050秒
@property (nonatomic, assign)CFAbsoluteTime thresholdTime;

@property (nonatomic, copy)KYBacktraceBlock backtraceBlock;


/// 启动耗时检测
- (void)start;

/// 启动耗时检测
/// @param backtraceBlock 耗时任务调用栈信息
- (void)start:(KYBacktraceBlock _Nullable)backtraceBlock;

@end

NS_ASSUME_NONNULL_END
