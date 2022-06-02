//
//  KYHelper.m
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/11/29.
//

#import "KYHelper.h"

@implementation KYHelper

+ (UIWindow *)getRootWindow {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            window.windowLevel == UIWindowLevelNormal &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIViewController *)getRootViewController {
    UIViewController *RootVC = [self getRootWindow].rootViewController;
    UIViewController *topVC = RootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
