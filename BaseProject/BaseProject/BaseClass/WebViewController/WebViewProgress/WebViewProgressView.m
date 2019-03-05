//
//  WebViewProgressView.m
//  HalfTheStudyApp
//
//  Created by JackerooChu on 2017/6/23.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import "WebViewProgressView.h"

@implementation WebViewProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
    [self configureViews];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}

-(void)configureViews{
    if (nil == self.progressColor){
        self.progressColor = [UIColor redColor];
    }
    self.userInteractionEnabled = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressBarView = [[UIView alloc] initWithFrame:self.bounds];
    _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIColor *tintColor = self.progressColor;
    _progressBarView.backgroundColor = tintColor;
    [self addSubview:_progressBarView];
    _barAnimationDuration = 0.27f;
    _fadeAnimationDuration =0.27f;
    _fadeOutDelay = 0.1f;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    _progressBarView.backgroundColor = progressColor;
}

- (void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    BOOL isGrowing = progress >0.0;
    [UIView animateWithDuration:(isGrowing && animated) ? _barAnimationDuration:0.0
            delay:0
            options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = _progressBarView.frame;
                         frame.size.width = progress * self.bounds.size.width;
                         _progressBarView.frame =frame;
                     } completion:nil];

    if (progress >= 1.0){
        [UIView animateWithDuration:animated ? _fadeAnimationDuration:0.0
                delay:_fadeOutDelay
                options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _progressBarView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                    CGRect frame = _progressBarView.frame;
                    frame.size.width = 0;
                    _progressBarView.frame = frame;
                }];
    } else {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration:0.0
                delay:0.0
                options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _progressBarView.alpha = 0;
                         } completion:nil];
    }
}


@end
