//
//  KYMonitorManager.h
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/11/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KYRunLoopObserver.h"


NS_ASSUME_NONNULL_BEGIN

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


/// 启动耗时任务检测
- (void)startMonitorTimeConsumingTask:(KYBacktraceBlock)backtraceBlock;

@end

NS_ASSUME_NONNULL_END
