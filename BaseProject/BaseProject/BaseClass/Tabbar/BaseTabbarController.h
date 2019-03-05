//
//  BaseTabbarController.h
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabbarController : UITabBarController
-(void)initSubViewControllers;
- (UITabBarItem*)tabBarItemWithTitle:(NSString*)title
                          TitleColor:(UIColor*)titleColor
                               image:(NSString*)image
                       selectedImage:(NSString*)selectedImage;
@end
