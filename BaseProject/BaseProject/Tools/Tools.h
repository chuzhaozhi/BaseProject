//
//  Tools.h
//  EmbroideryAndCarving
//
//  Created by iOS-Czz on 2023/3/2.
//  Copyright © 2023 JackerooChu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject
+ (UIViewController *)getCurrentVC;
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC;
+ (NSString*)fromDateToWeek:(NSString*)selectDate;
@end

NS_ASSUME_NONNULL_END
