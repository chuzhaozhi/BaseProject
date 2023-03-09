//
//  Tools.m
//  EmbroideryAndCarving
//
//  Created by iOS-Czz on 2023/3/2.
//  Copyright © 2023 JackerooChu. All rights reserved.
//

#import "Tools.h"

@implementation Tools

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    ///下文中有分析
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}
+ (NSString*)fromDateToWeek:(NSString*)selectDate{
    NSInteger yearInt = [selectDate substringWithRange:NSMakeRange(0, 4)].integerValue;
    NSInteger monthInt = [selectDate substringWithRange:NSMakeRange(4, 2)].integerValue;
    NSInteger dayInt = [selectDate substringWithRange:NSMakeRange(6, 2)].integerValue;
    int c = 20;//世纪
    int y = (int)yearInt%100;//年
    int d = (int)dayInt;
    int m = (int)monthInt;
    if (m==1 || m==2)
    {
        m=m+12;
        y=y-1;
    }
    int w =y+(y/4)+(c/4)-2*c+(26*(m+1)/10)+d-1;
    while(w<0){w+=7;}
     w%=7;
    NSString *weekDay = @"";
    switch (w) {
        case 0:
            weekDay = @"Sunday";
            break;
        case 1:
            weekDay = @"Monday";
            break;
        case 2:
            weekDay = @"Tuesday";
            break;
        case 3:
            weekDay = @"Wednesday";
            break;
        case 4:
            weekDay = @"Thursday";
            break;
        case 5:
            weekDay = @"Friday";
            break;
        case 6:
            weekDay = @"Saturday";
            break;
        default:
            break;
    }
    return weekDay;
}
@end
