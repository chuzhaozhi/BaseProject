//
//  UIImage+Cache.h
//  EmbroideryAndCarving
//
//  Created by iOS-Czz on 2023/2/28.
//  Copyright © 2023 JackerooChu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Cache)
+ (NSString *)saveImageToCacheUseImage:(UIImage *)image;
+ (UIImage *)getCacheImageUseImagePath:(NSString *)imagePath;
@end

NS_ASSUME_NONNULL_END
