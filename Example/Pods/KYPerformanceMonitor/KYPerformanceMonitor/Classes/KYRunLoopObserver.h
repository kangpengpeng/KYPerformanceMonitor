//
//  KYRunLoopObserver.h
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KYBacktraceBlock)(NSString *backtraceString);

@interface KYRunLoopObserver : NSObject

@property (nonatomic, copy)KYBacktraceBlock backtraceBlock;


/// 启动耗时检测
- (void)start;

/// 启动耗时检测
/// @param backtraceBlock 耗时任务调用栈信息
- (void)start:(KYBacktraceBlock _Nullable)backtraceBlock;


@end

NS_ASSUME_NONNULL_END
