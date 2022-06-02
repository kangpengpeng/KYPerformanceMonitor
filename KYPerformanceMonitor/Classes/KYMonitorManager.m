//
//  KYMonitorManager.m
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2019/11/29.
//

#import "KYMonitorManager.h"
#import "KYFPSView.h"
#import "KYFPSLink.h"

/// 默认耗时阀值，50 毫秒
#define DEFAULT_THRESHOLD   0.050
static KYMonitorManager *_monitorManagerInstance;

@interface KYMonitorManager()
@property (nonatomic, strong)KYFPSView *fpsView;
@property (nonatomic, strong)KYRunLoopObserver *runLoopObserver;
@end

@implementation KYMonitorManager

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _monitorManagerInstance = [[KYMonitorManager alloc] init];
    });
    return _monitorManagerInstance;
}

- (void)startMonitorFPS2View:(UIView *)view {
    // 初始化帧率视图
    if (_monitorManagerInstance.fpsView == nil) {
        CGFloat w = 60;
        CGFloat h = 30;
        CGFloat space = 10;
        CGFloat x = view.frame.size.width-w-space;
        CGFloat y = view.frame.size.height-h-space;
        KYFPSView *fpsView = [[KYFPSView alloc] init];
        fpsView.frame = CGRectMake(x, y, w, h);
        fpsView.layer.cornerRadius = 5;
        fpsView.clipsToBounds = YES;
        [view addSubview:fpsView];
        self.fpsView = fpsView;
    }

    // 初始化帧率 DisplayLink
    [self setupDisplayLink];
}

- (void)startMonitorTimeConsumingTask:(KYBacktraceBlock)backtraceBlock {
    [self startMonitorTimeConsumingTaskWithStrategy:KYMonitoringStrategyThreshold thresholdTime:DEFAULT_THRESHOLD backtraceBlock:backtraceBlock];
}

- (void)startMonitorTimeConsumingTaskWithStrategy:(KYMonitoringStrategy)monitoringStrategy
                                    thresholdTime:(CFAbsoluteTime)thresholdTime
                                   backtraceBlock:(KYBacktraceBlock)backtraceBlock {
    if (self.runLoopObserver == nil) {
        self.runLoopObserver = [[KYRunLoopObserver alloc] init];
        self.runLoopObserver.monitoringStrategy = monitoringStrategy;
        self.runLoopObserver.thresholdTime = thresholdTime;
        [self.runLoopObserver start:^(NSString * _Nonnull backtraceString) {
            if (backtraceBlock) {
                backtraceBlock(backtraceString);
            }
        }];
    }
}


- (void)setupDisplayLink {
    [[KYFPSLink shared] startFPSLink:^(NSUInteger fpsValue) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"%lu", (unsigned long)fpsValue);
            [self.fpsView setFPSValue:fpsValue];
        });
    }];
}





@end
