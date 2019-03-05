//
//  WebViewController.m
//
//  Created by JackerooChu on 2017/6/23.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewProgress.h"
#import "WebViewProgressView.h"
#import "WebShareView.h"
#import "customActivity.h"

#import <Social/Social.h>
@interface WebViewController ()<UIWebViewDelegate,UINavigationBarDelegate,UINavigationControllerDelegate,WebViewProgressDelegate,UIScrollViewDelegate,WebShareViewDelegate>
@property (nonatomic, strong) UIBarButtonItem *customBackBarItem;
@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;
@property (nonatomic, strong) WebViewProgress *progressProxy;
@property (nonatomic, strong) WebViewProgressView *progressView;
@property (nonatomic,strong) WebShareView *shareView;

//  存储截图数组
@property (nonatomic, strong) NSMutableArray *snapShotArray;

//  当前截图的View
@property (nonatomic, strong) UIView *currentSnapShotView;

//  上一个截图View
@property (nonatomic, strong) UIView *prevSnapShotView;

//  背景
@property (nonatomic, strong) UIView *swipingBackgroundView;

//  左边点击手势
@property (nonatomic, strong)  UIPanGestureRecognizer *swipePanGesture;

@property (nonatomic, assign) BOOL isSwipingBack;

@end


@implementation WebViewController
-(UIBarButtonItemStyle )preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark init
- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self){
        self.url = url;
        _progressViewColor = [UIColor colorWithRed:119.0/255 green:228.0/255 blue:115.0/255 alpha:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:LOAD_LOCAL_IMG(@"ic_back") style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)] ];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView.delegate = self.progressProxy;
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.webView];
    self.shareView.webShareDelegate = self;

    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self.navigationController.navigationBar addSubview:self.progressView];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, ScreenH)];
    leftView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:leftView];
    [self.view addSubview:self.shareView];
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
}
-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint vel = [scrollView.panGestureRecognizer velocityInView:scrollView];
    if(vel.y < 0){
        
        
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.shareView.transform = CGAffineTransformMakeTranslation(0.01, ScreenH);
            self.shareView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            
            
        }];
        
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            self.shareView.alpha = 1;
            self.shareView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
            
        }];
        
    }
}
-(WebShareView *)shareView{
    if (!_shareView) {
        _shareView = [[WebShareView alloc] initWithFrame:CGRectZero];
        _shareView.backgroundColor = [UIColor whiteColor];
    }
    return _shareView;
}
-(void)shareAction{
    NSString *textToShare = self.articleTitle;
    UIImage *imageToShare = [UIImage imageNamed:@"AppIcon"];
    NSURL *urlToShare = self.url;
    NSArray *activityItems = @[urlToShare,textToShare,imageToShare];
    
    //自定义Activity
    customActivity * customActivit = [[customActivity alloc] initWithTitie:self.articleTitle withActivityImage:[UIImage imageNamed:@"AppIcon.png"] withUrl:urlToShare withType:@"customActivity" withShareContext:activityItems];
    NSArray *activities = @[customActivit];
       UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activities];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        //初始化回调方法
        UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError)
        {
            NSLog(@"activityType :%@", activityType);
            if (completed)
            {
                NSLog(@"completed");
            }
            else
            {
                NSLog(@"cancel");
            }
            
        };
        
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        activityVC.completionWithItemsHandler = myBlock;
    }else{
        
        UIActivityViewControllerCompletionHandler myBlock = ^(NSString *activityType,BOOL completed)
        {
            NSLog(@"activityType :%@", activityType);
            if (completed)
            {
                NSLog(@"completed");
            }
            else
            {
                NSLog(@"cancel");
            }
            
        };
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        activityVC.completionHandler = myBlock;
    }
    activityVC.excludedActivityTypes = @[];
    
    //在展现view controller时，必须根据当前的设备类型，使用适当的方法。在iPad上，必须通过popover来展现view controller。在iPhone和iPodtouch上，必须以模态的方式展现。
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.progressView removeFromSuperview];
    self.webView.delegate = nil;
}

#pragma mark - public functions
- (void)reloadWebView {
    [self.webView reload];
}

#pragma mark - Push and pop
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest *)request {
    NSURLRequest *lastRequest =(NSURLRequest *)[[self.snapShotArray lastObject] objectForKey:@"request"];

    //  如果是url就push 否则不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]){
        return;
    }
    //  如果URl一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]){
        return;
    }

    UIView *currentSnapShotView = [self.webView snapshotImageAfterScreenUpdates:YES];
    [self.snapShotArray addObject:@{
            @"request":request,
            @"snapShotView":currentSnapShotView
    }];
}

-(void)startPopSnapShotView{
    if (self.isSwipingBack){
        return;
    }
    if (!self.webView.canGoBack){
        return;
    }
    self.isSwipingBack = YES;
    CGPoint center  = CGPointMake(ScreenW/2, ScreenH/2);
    self.currentSnapShotView  =[self.webView snapshotImageAfterScreenUpdates:YES];

    self.currentSnapShotView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.currentSnapShotView.layer.shadowOffset = CGSizeMake(3, 3);
    self.currentSnapShotView.layer.shadowRadius = 5;
    self.currentSnapShotView.layer.shadowOpacity = 0.75;  //阴影透明度

    self.currentSnapShotView.center = center;
    self.prevSnapShotView = (UIView *)[[self.snapShotArray lastObject] objectForKey:@"snapShotView"];
    center.x -= 60;
    self.prevSnapShotView.center = center;
    self.prevSnapShotView.alpha = 1;
    self.view.backgroundColor =[UIColor blackColor];
    [self.view addSubview:self.prevSnapShotView];
    [self.view addSubview:self.swipingBackgroundView];
    [self.view addSubview:self.currentSnapShotView];
}

-(void) popSnapShotViewWithPanGestureDistance:(CGFloat )distance{
    if (!self.isSwipingBack){
        return;
    }
    if (distance <=0){
        return;
    }

    CGPoint currentSnapshotViewCenter = CGPointMake(ScreenW/2, ScreenH/2);
    currentSnapshotViewCenter.x += distance;
    CGPoint prevSnapshotViewCenter  = CGPointMake(ScreenW/2, ScreenH/2);
    prevSnapshotViewCenter.x -= (ScreenW - distance)*60/ScreenW;

    self.currentSnapShotView.center = currentSnapshotViewCenter;
    self.prevSnapShotView.center = prevSnapshotViewCenter;
    self.swipingBackgroundView.alpha = (ScreenW - distance )/ScreenW;
}

-(void)endPopSnapShotView{
    if (!self.isSwipingBack){
        return;
    }

    self.view.userInteractionEnabled = NO;
    if (self.currentSnapShotView.center.x >=ScreenW){
        // pop sucess
        [UIView animateWithDuration:0.2 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.currentSnapShotView.center = CGPointMake(ScreenW*3/2, ScreenH/2);
            self.prevSnapShotView.center = CGPointMake(ScreenW/2, ScreenH/2);
            self.swipingBackgroundView.alpha = 0;

        } completion:^(BOOL finished) {
            [self.prevSnapShotView removeFromSuperview];
            [self.swipingBackgroundView removeFromSuperview];
            [self.currentSnapShotView removeFromSuperview];
            [self.webView goBack];
            [self.snapShotArray removeLastObject];
            self.view.userInteractionEnabled = YES;
            self.isSwipingBack = NO;
        }];
    } else {
        // pop fail
        [UIView animateWithDuration:0.2 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            self.currentSnapShotView.center = CGPointMake(ScreenW/2, ScreenH/2);
            self.prevSnapShotView.center = CGPointMake(ScreenW/2-60, ScreenH/2);
            self.prevSnapShotView.alpha = 1;
        } completion:^(BOOL finished) {
            [self.prevSnapShotView removeFromSuperview];
            [self.swipingBackgroundView removeFromSuperview];
            [self.currentSnapShotView removeFromSuperview];
            self.view.userInteractionEnabled = YES;
            self.isSwipingBack = NO;
        }];
    }
}

#pragma mark - update nav items
-(void)updateNavigationItems{
    if (self.webView.canGoBack){
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem appearance] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - events handler
-(void)swipePanGestureHandler:(UIPanGestureRecognizer *)panGesture{
    CGPoint translation = [panGesture translationInView:self.webView];
    CGPoint location = [panGesture locationInView:self.webView];

    if (panGesture.state == UIGestureRecognizerStateBegan){
        if (location.x<=50 && translation.x>0){ //  开始动画
            [self startPopSnapShotView];
        }
    } else if (panGesture.state == UIGestureRecognizerStateCancelled || panGesture.state ==UIGestureRecognizerStateEnded){
        [self endPopSnapShotView];
    } else if (panGesture.state == UIGestureRecognizerStateChanged){
        [self popSnapShotViewWithPanGestureDistance:translation.x];
    }
}

-(void)customBackItemClicked{
    [self.webView goBack];
}
-(void)closeItemClicked{

}
-(void)leftButtonClickAction:(UIButton *)sender{
    switch (sender.tag){
        case 2000:
            [self customBackItemClicked];
            break;
        case 2001:
            break;
        default:
            break;
    }
}

#pragma mark  - webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    switch (navigationType){
        case UIWebViewNavigationTypeLinkClicked:{
            return NO;
//            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        case UIWebViewNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        case UIWebViewNavigationTypeBackForward: {
            break;
        }
        case UIWebViewNavigationTypeReload: {
            break;
        }
        case UIWebViewNavigationTypeFormResubmitted: {
            break;
        }
        case UIWebViewNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
    NSString *title =[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.title = title;
    // =========JueJin Begin==================
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('header pos')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('author-info-block')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('tag-list-box')[0].style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('footer-author-block')[0].style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('article-banner')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('books-recommend books-recommend-footer book-box')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('comment-list-box')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('main-area recommended-area shadow')[0].style.display = 'none'"];
     [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName(' action-box action-bar')[0].style.display = 'none'"];
   
    // =========JueJin end==================
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('share cl')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('main-header-box')[0].style.display = 'none'"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - progress Delegete
- (void)webViewProgress:(WebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.progressView setProgress:progress animated:NO];
}

#pragma mark setter getter
- (void)setUrl:(NSURL *)url {
    _url = url;
}
- (void)setProgressViewColor:(UIColor *)progressViewColor {
    _progressViewColor = progressViewColor;
    self.progressView.progressColor = progressViewColor;
}


- (UIWebView *)webView {
    if (!_webView){
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [_webView addGestureRecognizer:self.swipePanGesture];
    }
    return _webView;
}

- (UIBarButtonItem *)customBackBarItem {
    if (!_closeButtonItem){
        UIImage* backItemImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage* backItemHlImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        [backButton sizeToFit];

        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}

- (UIBarButtonItem *)closeButtonItem {
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
    }
    return _closeButtonItem;
}

-(UIView*)swipingBackgroundView {
    if (!_swipingBackgroundView) {
        _swipingBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
        _swipingBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _swipingBackgroundView;
}

-(NSMutableArray*)snapShotArray {
    if (!_snapShotArray) {
        _snapShotArray = [NSMutableArray array];
    }
    return _snapShotArray;
}

-(BOOL)isSwipingBack{
    if (!_isSwipingBack) {
        _isSwipingBack = NO;
    }
    return _isSwipingBack;
}

-(UIPanGestureRecognizer*)swipePanGesture{
    if (!_swipePanGesture) {
        _swipePanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipePanGestureHandler:)];
    }
    return _swipePanGesture;
}

-(WebViewProgress *)progressProxy {
    if (!_progressProxy){
        _progressProxy = [[WebViewProgress alloc] init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate =self;
    }
    return _progressProxy;
}

- (WebViewProgressView *)progressView {
    if (!_progressView){
        CGFloat progressBarHeight = 3.0f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height, navigationBarBounds.size.width, progressBarHeight);
        _progressView = [[WebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.progressColor = self.progressViewColor;
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    }
    return _progressView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
