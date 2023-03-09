//
//  UITextField+Placeholder.m
//  EmbroideryAndCarving
//
//  Created by iOS-Czz on 2023/2/28.
//  Copyright © 2023 JackerooChu. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)
- (void)setPlaceholderFont:(UIFont *)font{
    [self setPlaceholderFont:font textColor:nil];
}
- (void)setPlaceholderTextColor:(UIColor *)color{
    [self setPlaceholderFont:nil textColor:color];
}
- (void)setPlaceholderFont:(UIFont *)font textColor:(UIColor *)color{
    if (!self.placeholder || [[self.placeholder stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return;
    }
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc]initWithString:self.placeholder];
    if (font) {
        [mutAttStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.placeholder.length)];
    }
    if (color) {
        [mutAttStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.placeholder.length)];
    }
    [self setAttributedPlaceholder:mutAttStr];
}
@end
