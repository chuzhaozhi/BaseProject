//
//  UIView+CornerRadius.m
//  ZFChartView
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)

@dynamic CustomBorderColor;
@dynamic CustomCornerRaiuds;
@dynamic CustomBorderWidth;

- (void)setCustomCornerRaiuds:(CGFloat)CustomCornerRaiuds {
    self.layer.cornerRadius = CustomCornerRaiuds;
    self.layer.masksToBounds = true;
}

- (void)setCustomBorderColor:(UIColor *)CustomBorderColor {
    self.layer.borderColor = [CustomBorderColor CGColor];
}

- (void)setCustomBorderWidth:(CGFloat)CustomBorderWidth {
    self.layer.borderWidth = CustomBorderWidth;
}




+ (id)wlikp_loadFromNib {
    return [UIView wlikp_loadFromNibNamed:NSStringFromClass(self)];
}

+ (id)wlikp_loadFromNibNamed:(NSString*) nibName {
    id view = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
    return view;;
}

@end
