//
//  KYMonitorManager.h
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2019/11/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KYRunLoopObserver.h"


NS_ASSUME_NONNULL_BEGIN

/// 宏定义 NSLog 函数，也是为了解决backtraceBlock 不能完全打印函数调用栈的问题
#ifdef DEBUG
#define NSLog(FORMAT, ...)  fprintf(stderr,"%s:%d \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

@interface KYMonitorManager : NSObject

+ (instancetype)shared;


/// 启动帧率检测视图
/// @param view 帧率添加到的视图
- (void)startMonitorFPS2View:(UIView *)view;


/// 启动耗时任务检测（默认耗时阀值策略，默认耗时阀值50毫秒）
- (void)startMonitorTimeConsumingTask:(KYBacktraceBlock)backtraceBlock;


/// @param monitoringStrategy 监测策略
/// @param thresholdTime 任务耗时阀值（单位秒，默认0.05秒，即50毫秒）
/// @param backtraceBlock 耗时任务堆栈回调
- (void)startMonitorTimeConsumingTaskWithStrategy:(KYMonitoringStrategy)monitoringStrategy
                                    thresholdTime:(CFAbsoluteTime)thresholdTime
                                   backtraceBlock:(KYBacktraceBlock)backtraceBlock;

@end

NS_ASSUME_NONNULL_END
