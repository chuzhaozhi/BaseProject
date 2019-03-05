//
//  WebViewProgressView.h
//  HalfTheStudyApp
//
//  Created by JackerooChu on 2017/6/23.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewProgressView : UIView

/**
 * 进度 0.0~1.0
 */
@property (nonatomic, assign) float progress;

/**
 * 进度颜色 默认红色
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 * 显示view
 */
@property (nonatomic, strong) UIView *progressBarView;

/**
 * 显示动画时间
 */
@property (nonatomic, assign) NSTimeInterval barAnimationDuration;

/**
 *
 */
@property (nonatomic, assign) NSTimeInterval fadeAnimationDuration;

/**
 *
 */
@property (nonatomic, assign) NSTimeInterval fadeOutDelay;

/**
 * 设置Progress进度
 * @param progress  进度
 * @param animated  是否有动画
 */
-(void)setProgress:(float )progress animated:(BOOL )animated;
@end
