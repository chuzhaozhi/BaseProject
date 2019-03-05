//
//  BaseTabbarController.m
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//

#import "BaseTabbarController.h"

@interface BaseTabbarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tabBar setBackgroundImage:[UIImage new]];
//    [self.tabBar setShadowImage:[UIImage new]];

    // Do any additional setup after loading the view.
}

-(instancetype)init{
    self = [super init];

    if (self) {
        [self initSubViewControllers];
    }

    return self;
}
-(void)initSubViewControllers
{
    self.tabBar.userInteractionEnabled = YES;
    
    self.delegate = self;
}
#pragma mark UITabBarControllerDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //点击某一个tabbar 按钮
    if (item.tag == 1) {
        
        NSLog(@"第一个");
    }
    if (item.tag == 2) {
        
        NSLog(@"第二个");
    }
    if(item.tag == 3){
        
        NSLog(@"第三个");
    }
    
}
- (UITabBarItem*)tabBarItemWithTitle:(NSString*)title
                          TitleColor:(UIColor*)titleColor
                               image:(NSString*)image
                       selectedImage:(NSString*)selectedImage
{
    UITabBarItem *tabBarItem;
    
    tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                               image:[self renderImageWithName:image]
                                       selectedImage:[self renderImageWithName:selectedImage]];
    if(title == nil || [title isEqualToString:@""]){
    
    tabBarItem.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0);
    }
    //改变tabBar字体颜色
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    return tabBarItem;
}

- (UIImage*)renderImageWithName:(NSString*)imageName {
    UIImage * image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
