//
//  BaseViewController.h
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//


#import "BaseNavgationController.h"
//#import "Tools.h"

#import "IQKeyboardManager.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic, strong) BaseNavgationController   *navigationController;

-(void)showProgress;
- (void)textStateHUD:(NSString *)text;

- (void)textStateHUDNoHide:(NSString *)text;

-(void)imageStateHUD:(NSString *)imageName title:(NSString *)title;

-(void)hideProgress;

- (BOOL)fd_prefersNavigationBarHidden;

@end
