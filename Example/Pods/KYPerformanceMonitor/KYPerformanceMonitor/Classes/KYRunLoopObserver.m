//
//  KYRunLoopObserver.m
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/12/17.
//

#import "KYRunLoopObserver.h"
#import "BSBacktraceLogger.h"


@interface KYRunLoopObserver()
@property (nonatomic, assign)CFRunLoopObserverRef runLoopObserver;
@property (nonatomic, assign)CFRunLoopActivity activity;
@property (nonatomic, strong)dispatch_semaphore_t semaphore;
@property (nonatomic, assign)NSUInteger timeoutCount;
@end
@implementation KYRunLoopObserver

- (void)start {
    [self start:nil];
}

- (void)start:(KYBacktraceBlock)backtraceBlock {
    self.backtraceBlock = backtraceBlock;
    [self startRunLoopObserver];
    [self startRunLoopMonitor];
}


- (void)startRunLoopObserver {
    if (self.runLoopObserver) {
        return;
    }
    /* Run Loop Observer Activities
     runloop 七种状态
    typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
        kCFRunLoopEntry = (1UL << 0), // 即将进入 runloop
        kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理timer事件
        kCFRunLoopBeforeSources = (1UL << 2), // 即将处理source事件
        kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入睡眠
        kCFRunLoopAfterWaiting = (1UL << 6), // 被唤醒
        kCFRunLoopExit = (1UL << 7), // runloop 退出
        kCFRunLoopAllActivities = 0x0FFFFFFFU
    };
    */
    // runloop 模式监听
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    //创建Run loop observer对象
    //第一个参数用于分配observer对象的内存
    //第二个参数用以设置observer所要关注的事件，详见回调函数myRunLoopObserver中注释
    //第三个参数用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行
    //第四个参数用于设置该observer的优先级
    //第五个参数用于设置该observer的回调函数
    //第六个参数用于设置该observer的运行环境
    //CFRunLoopObserverCreate 创建观察者的时候 order 传 0 对于点击 tableViewCell 造成的卡顿检测不到，要改成LONG_MAX 才以后可以检测到了。
    self.runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                   kCFRunLoopAllActivities,
                                                   YES,
                                                   LONG_MAX,
                                                   &runLoopActivitiesCallBack,
                                                   &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), self.runLoopObserver, kCFRunLoopDefaultMode);
}

static void runLoopActivitiesCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    KYRunLoopObserver *monitor = (__bridge KYRunLoopObserver *)info;
    monitor.activity = activity;
    // 发送信号
    dispatch_semaphore_t semaphore = monitor.semaphore;
    dispatch_semaphore_signal(semaphore);
}

- (void)startRunLoopMonitor {
    // 创建信号
    self.semaphore = dispatch_semaphore_create(1);
    // 在子线程监控时长 DISPATCH_TIME_FOREVER
    // NSEC_PER_SEC NSEC_PER_MSEC
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES) {
            // 50 毫秒，每帧间隔17毫秒
            // 所以 timeoutCount 连续三次超时，即任务出现卡顿
            long waitSemaphore = dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC));
            //NSLog(@"信号 %ld", waitSemaphore);
            if (waitSemaphore != 0) { // 没有等到信号
                if (!self.runLoopObserver) {
                    self.activity = 0;
                    self.timeoutCount = 0;
                    self.semaphore = 0;
                    return;
                }
                if (self.activity == kCFRunLoopBeforeSources ||
                    self.activity == kCFRunLoopAfterWaiting) {
                    if (++self.timeoutCount < 3) {
                        continue;
                    }
                    // 出现卡顿
                    if (self.backtraceBlock) {
                        NSString *backtraceString = [[BSBacktraceLogger bs_backtraceOfAllThread] copy];
                        self.backtraceBlock(backtraceString);
                    }
                }
            }
            // 等到信号，超时归零
            self.timeoutCount = 0;
        }
    });
}

- (void)recordFuncList {
//    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc]
//                                     initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll];
}


@end
