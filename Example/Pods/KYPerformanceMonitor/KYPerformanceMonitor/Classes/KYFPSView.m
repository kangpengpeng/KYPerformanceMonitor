//
//  KYFPSView.m
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/11/29.
//

#import "KYFPSView.h"

static KYFPSView *FPSViewInstance = nil;

@interface KYFPSView()
@property (nonatomic, strong)UILabel *fpsLabel;
@end

@implementation KYFPSView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return self;
}

- (void)layoutSubviews {
    self.fpsLabel.frame = self.bounds;
    [self addSubview:self.fpsLabel];
}

- (void)setFPSValue:(NSUInteger)fpsValue {
    self.fpsLabel.text = [NSString stringWithFormat:@"FPS: %lu", (unsigned long)fpsValue];
}

#pragma mark: - 属性
- (UILabel *)fpsLabel {
    if (!_fpsLabel) {
        _fpsLabel = [[UILabel alloc] init];
        _fpsLabel.textAlignment = NSTextAlignmentCenter;
        _fpsLabel.textColor = [UIColor whiteColor];
        _fpsLabel.text = @"FPS: 0";
        [_fpsLabel sizeToFit];
    }
    return _fpsLabel;
}

@end
