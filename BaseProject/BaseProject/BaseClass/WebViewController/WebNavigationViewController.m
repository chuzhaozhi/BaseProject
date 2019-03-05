//
//  WebNavigationViewController.m
//  HalfTheStudyApp
//
//  Created by JackerooChu on 2017/6/23.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import "WebNavigationViewController.h"
#import "WebViewController.h"

@interface WebNavigationViewController ()<UINavigationBarDelegate>

/**
 * 由于 popViewController 会触发 shouldPopItems, 因此用该值记录是否应该正确 popItems
 */
@property BOOL shouldPopItemAfterPopViewController;

@end

@implementation WebNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldPopItemAfterPopViewController = NO;
    //  导航栏主题 title文字属性
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    //  导航栏背景图
    //    [navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBarTintColor:COLOR_NAV];
    [navigationBar setTintColor:COLOR_BACKGROUND];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName
                                            : COLOR_BACKGROUND
                                            , NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController*)popViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.shouldPopItemAfterPopViewController = YES;
    return [super popToViewController:viewController animated:animated];
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popToRootViewControllerAnimated:animated];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    //  如果应该pop，说明是在 popViewController 之后，应该直接 popItems
    if (self.shouldPopItemAfterPopViewController) {
        self.shouldPopItemAfterPopViewController = NO;
        return YES;
    }

    //  如果不应该pop，说明是点击了导航栏的返回，这时候则要做出判断是不是在WebView中
    if ([self.topViewController isKindOfClass:[WebViewController class]]){
        WebViewController *webViewController = (WebViewController *)self.viewControllers.lastObject;
        if ([webViewController.webView canGoBack]){
            [webViewController.webView goBack];
            self.shouldPopItemAfterPopViewController = NO;
            [[self.navigationBar subviews] lastObject].alpha = 1;
            return NO;
        } else {
            [self popViewControllerAnimated:YES];
            return NO;
        }
    } else {
        [self popViewControllerAnimated:YES];
        return NO;
    }
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
