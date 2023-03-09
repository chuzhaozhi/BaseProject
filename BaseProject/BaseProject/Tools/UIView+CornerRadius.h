//
//  UIView+CornerRadius.h
//  ZFChartView
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

@property (nonatomic, assign) IBInspectable CGFloat CustomCornerRaiuds;
@property (nonatomic, assign) IBInspectable CGFloat CustomBorderWidth;
@property (nonatomic, assign) IBInspectable UIColor *CustomBorderColor;



+ (id)wlikp_loadFromNib;

+ (id)wlikp_loadFromNibNamed:(NSString*) nibName;

@end
