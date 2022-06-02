//
//  KYDisplayLink.h
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^KYFPSLinkBlock)(NSUInteger fpsValue);

@interface KYFPSLink : NSObject

+ (instancetype)shared;


/// 启动帧率回调
/// @param block 帧率回调，每秒一次回调，在同步队列异步函数中回调
- (void)startFPSLink:(KYFPSLinkBlock)block;

@end

NS_ASSUME_NONNULL_END
