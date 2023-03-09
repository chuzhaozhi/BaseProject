//
//  UITextField+Placeholder.h
//  EmbroideryAndCarving
//
//  Created by iOS-Czz on 2023/2/28.
//  Copyright © 2023 JackerooChu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Placeholder)
- (void)setPlaceholderFont:(UIFont *)font;
- (void)setPlaceholderTextColor:(UIColor *)color;
- (void)setPlaceholderFont:(UIFont *)font textColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
