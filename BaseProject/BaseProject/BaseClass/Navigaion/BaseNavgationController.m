//
//  BaseNavgationController.m
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//

#import "BaseNavgationController.h"

@interface BaseNavgationController ()

@end

@implementation BaseNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = COLOR_NAV;
//    self.navigationBar.titleTextAttributes = NSDictionary(object: navTitleColor,forKey:NSForegroundColorAttributeName) as? [String : AnyObject]
//    self.navigationBar.shadowImage = UIImage(named: "clear")
//    self.navigationBar.setBackgroundImage(UIImage(named: "clear"), forBarMetrics: UIBarMetrics.Default)
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage new]];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {

    if([rootViewController isKindOfClass:[BaseViewController class]]) {

        self = [super init];

        BaseViewController *viewController = (BaseViewController *) rootViewController;

        viewController.navigationController = self;

        [super pushViewController:rootViewController animated:YES];

    }else{

        self = [super initWithRootViewController:rootViewController];
    }
    return self;
}

/**
 * 重写跳转方法 改变跳转页面返回按钮效果 添加页面 hidesBottomBarWhenPushed YES 方法
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if(!viewController.navigationController){
        if([viewController isKindOfClass:[BaseViewController class]]){
            
            BaseViewController *baseViewController = (BaseViewController *)viewController;
        baseViewController.navigationController = self;
        }else{
            [[UINavigationController alloc] initWithRootViewController:viewController];
        }
    }
    viewController.hidesBottomBarWhenPushed = YES;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    UIBarButtonItem *uiBarButtonItem = [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:NAV_BACK_IMG_NAME]
                    style:UIBarButtonItemStyleDone
                   target:self
                   action:@selector(navBackAction:)];
    uiBarButtonItem.tintColor = COLOR_NAV_BACK;
    [viewController.navigationItem setLeftBarButtonItem:uiBarButtonItem animated:YES];
    [viewController.navigationItem setHidesBackButton:YES animated:YES];
    [super pushViewController:viewController animated:animated];
    
    // 修改tabBra的frame
    // 修正push控制器tabbar上移问题
    
    if (@available(iOS 11.0, *)){
        
        // 修改tabBra的frame
        
        CGRect frame = self.tabBarController.tabBar.frame;
        
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        
        self.tabBarController.tabBar.frame = frame;
        
    }
}

-(void)navBackAction:(id)sender{

    [super popViewControllerAnimated:YES];

}

-(void)hideNav:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    
    if([viewControllerToPresent isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = viewControllerToPresent;
        nav.navigationBar.translucent = NO;
        nav.navigationBar.barTintColor = COLOR_NAV;
         UIFont *font = [UIFont systemFontOfSize:17];
        NSDictionary *textAttributes = @{
                                         NSFontAttributeName : font,
                                         NSForegroundColorAttributeName : COLOR_NAV_TITLE
                                         };
        [nav.navigationBar setTitleTextAttributes:textAttributes];
    }
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
