//
//  ProjectTabBarController.m
//  Project01
//  Created by JackerooChu on 2019/2/28.
//  Copyright © 2019 JackerooChu. All rights reserved.
//
//  
//  If debugging a program bothers you, don't give up. 
//	Success is always around the corner. 
//	You never know how far you are from him unless you come to the corner. 
//	So remember,
//	persevere until you succeed.
//
        

#import "ProjectTabBarController.h"
#import "FirstItemViewController.h"
#import "SecondItemViewController.h"
#import "ThirdItemViewController.h"
#import "FourthItemViewController.h"
@interface ProjectTabBarController ()<UITabBarControllerDelegate>

@end


@implementation ProjectTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.delegate = self;
}

-(void)initSubViewControllers{
    FirstItemViewController *firstController = [[FirstItemViewController alloc] init];
    BaseNavgationController *firstNav = [[BaseNavgationController alloc] initWithRootViewController:firstController];
    firstNav.tabBarItem = [self tabBarItemWithTitle:@"前端" TitleColor:RGB(34, 143, 235) image:@"ic_web_nor" selectedImage:@"ic_web_sel"];
    [firstNav.tabBarItem setTag:1];
    
    SecondItemViewController *secondController = [[SecondItemViewController alloc] init];
    BaseNavgationController *secondNav = [[BaseNavgationController alloc] initWithRootViewController:secondController];
   secondNav.tabBarItem = [self tabBarItemWithTitle:@"后端" TitleColor:RGB(34, 143, 235) image:@"ic_server_nor" selectedImage:@"ic_server_sel"];
    [secondNav.tabBarItem setTag:2];
    
    ThirdItemViewController *thirdController = [[ThirdItemViewController alloc] init];
    BaseNavgationController *thirdNav = [[BaseNavgationController alloc] initWithRootViewController:thirdController];
   thirdNav.tabBarItem = [self tabBarItemWithTitle:@"移动端" TitleColor:RGB(34, 143, 235) image:@"ic_mobile_nor" selectedImage:@"ic_mobile_sel"];
    [thirdNav.tabBarItem setTag:3];
    

    FourthItemViewController *fourthController = [[FourthItemViewController alloc] init];
    BaseNavgationController *fourthNav = [[BaseNavgationController alloc] initWithRootViewController:fourthController];
    fourthNav.tabBarItem = [self tabBarItemWithTitle:@"我的" TitleColor:RGB(34, 143, 235) image:@"ic_my_nor" selectedImage:@"ic_my_sel"];
    [fourthNav.tabBarItem setTag:4];
    self.viewControllers = @[firstNav,secondNav,thirdNav,fourthNav];

}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
@end
