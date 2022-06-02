//
//  KYDisplayLink.m
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2019/11/29.
//

#import "KYFPSLink.h"

static KYFPSLink *fpsLinkInstance = nil;

@interface KYFPSLink()
@property (nonatomic, strong) CADisplayLink *dsLink;
@property (nonatomic, copy) KYFPSLinkBlock fpsLinkBlock;
@end

@implementation KYFPSLink {
    dispatch_queue_t _dsLinkQueue;
    NSTimeInterval _lastTimeStamp;
    NSUInteger _count;
}

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fpsLinkInstance = [[KYFPSLink alloc] init];
        fpsLinkInstance->_dsLinkQueue = dispatch_queue_create("kpp.com.fpsLinkQueue", DISPATCH_QUEUE_SERIAL);
        fpsLinkInstance->_lastTimeStamp = 0;
        fpsLinkInstance->_count = 0;
    });
    return fpsLinkInstance;
}

- (void)startFPSLink:(KYFPSLinkBlock)block {
    self.fpsLinkBlock = block;
    if (self.dsLink == nil) {
        self.dsLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayAction)];
        [self.dsLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)displayAction {
    // 降频，1秒回调一次
    dispatch_async(_dsLinkQueue, ^{
        if (self->_count == 0) {
            self->_lastTimeStamp = self.dsLink.timestamp;
        }
        self->_count += 1;
        NSTimeInterval delay = self.dsLink.timestamp - self->_lastTimeStamp;
        if (delay >= 1) {
            NSUInteger fpsValue = self->_count / delay;
            //NSLog(@"%lu", (unsigned long)fpsValue);
            self->_count = 0;
            self->_fpsLinkBlock(fpsValue);
        }
    });
}
@end
