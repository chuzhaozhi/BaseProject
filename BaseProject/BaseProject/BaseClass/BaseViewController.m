
//
//  BaseViewController.m
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//


#import "BaseViewController.h"

@interface BaseViewController ()<MBProgressHUDDelegate,UIAlertViewDelegate>{
    
    MBProgressHUD *progressView;
}

@end

@implementation BaseViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = COLOR_BACKGROUND;
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self createTitleLabel];
    self.titleLabel.text = self.title;
    self.view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSNotificationCenter *center = [NSNotificationCenter  defaultCenter];
    [center addObserver:self selector:@selector(defaultsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.presentingController = self;      
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    _titleLabel.text = title;
}

- (void)createTitleLabel {
    
    //Create custom label for titleView
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 90, 40)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.textColor = COLOR_NAV_TITLE;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18]  != nil ? [UIFont fontWithName:@"PingFang-SC-Medium" size:18] : FONT(18);
#ifdef __IPHONE_11_0
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
#endif
    self.navigationItem.titleView = _titleLabel;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if(nil != progressView){
        
        [progressView hideAnimated:YES];
        
    }
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
    
}
#pragma mark -- HUD 展示text
- (void)textStateHUD:(NSString *)text
{
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeText;
    progressView.detailsLabel.text = text;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
    [progressView hideAnimated:YES afterDelay:1.5];
}
- (void)textStateHUD:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeText;
    progressView.detailsLabel.text = text;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
    [progressView hideAnimated:YES afterDelay:delay];
}

- (void)textStateHUDNoHide:(NSString *)text
{
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeText;
    progressView.detailsLabel.text = text;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
}
-(void)showProgress{
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    [self.view addSubview:progressView];
}
-(void)hideProgress{
    dispatch_async(dispatch_get_main_queue(), ^{
        [progressView hideAnimated:NO];
    });
}

-(void)imageStateHUD:(NSString *)imageName title:(NSString *)title{
    
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeCustomView;
    UIImage *image = [UIImage imageNamed:imageName];
    progressView.customView = [[UIImageView alloc] initWithImage:image];
    progressView.square = YES;
    progressView.detailsLabel.text = title;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
    [progressView hideAnimated:YES afterDelay:1.5];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- logIn kvc

- (void)defaultsChanged:(NSNotification *)notification {
    // Get the user defaults
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    // Do something with it
    if(nil != [defaults objectForKey:@"token"]){
        if([[defaults objectForKey:@"token"] isEqualToString:@"logOut"]){
            return;
        }
        if([[defaults objectForKey:@"token"] isEqualToString:@"otherLog"]){
            [[NSNotificationCenter  defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您的账号已在其他地方登录，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alertView.tag = 10086;
            [alertView show];
        }
    }
}

/*
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(actionSheet.tag == 1004){
        switch (buttonIndex){
                
            case 0:{
                NSLog(@"相册");
                //            ZYQAssetPickerController *zyqAssetPickerController = [[ZYQAssetPickerController alloc] init];
                //            zyqAssetPickerController.maximumNumberOfSelection = actionSheet.tag;
                //            zyqAssetPickerController.assetsFilter = [ALAssetsFilter allAssets];
                //            zyqAssetPickerController.showEmptyGroups = NO;
                //            zyqAssetPickerController.delegate = self;
                //            zyqAssetPickerController.navigationBar.translucent = NO;
                //            zyqAssetPickerController.navigationBar.barTintColor = [UIColor whiteColor];
                //            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
                //            [rootViewController presentViewController:zyqAssetPickerController animated:YES completion:nil];
                [self pushImagePickerController:[self.maxCount integerValue] allowVideo:[self.allowVideo integerValue] allowImg:[self.allowImg integerValue]];
                break;
            }
                
            case 1:{
                NSLog(@"拍照");
                [self takePhoto];
                break;
            }
                
            default:
                break;
                
        }
        
    }else if(actionSheet.tag == 1005){
        
        switch (buttonIndex){
                
            case 0:{
                [self pushImagePickerController:[self.maxCount integerValue] allowVideo:[self.allowVideo integerValue] allowImg:[self.allowImg integerValue]];
                break;
            }
            case 1:{
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    
                    
                    UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
                    
                    cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
                    
                    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
                    
                    cameraPicker.mediaTypes = @[availableMedia[1]];//设置媒体类型为public.movie
                    
                    cameraPicker.videoMaximumDuration = 30.0f;//30秒
                    
                    cameraPicker.delegate = self;//设置委托
                    
                    cameraPicker.view.tag = 101;
                    
                    [self presentViewController:cameraPicker animated:YES completion:nil];
                } else{
                    if([self isKindOfClass:[BaseViewController class]]){
                        BaseViewController *viewController = (BaseViewController *)self;
                        [viewController textStateHUD:@"此设备摄像不可用"];
                    }
                }
                break;
            }
            default:
                break;
        }
    }
}
*/
- (BOOL)fd_prefersNavigationBarHidden {
    return NO;
}



@end
