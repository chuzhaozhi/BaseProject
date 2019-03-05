//
//  RootWebViewController.m
//  HalfTheStudyApp
//
//  Created by JackerooChu on 2017/6/24.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import "RootWebViewController.h"
#import <WebKit/WebKit.h>
@interface RootWebViewController ()<WKNavigationDelegate,WKUIDelegate>{
    WKUserContentController *userContentController;
}

@property (nonatomic, strong) WKWebView *wkWebView;
//  加载页面进度条
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation RootWebViewController
- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self){
        self.url = url;
        _progressViewColor = [UIColor colorWithRed:119.0/255 green:228.0/255 blue:115.0/255 alpha:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWkWebView];
    // Do any additional setup after loading the view.
}
#pragma mark - 初始化webView
-(void)initWkWebView{
    // 先实例化配置类 （相当于 UIWebView的属性有的放到了这里）
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //  注册js调用的方法
    userContentController = [[WKUserContentController alloc] init];
    //  弹出登录
//    [userContentController addScriptMessageHandler:self name:@"loginVC"];
    configuration.userContentController = userContentController;
    //  打开JS交互
    configuration.preferences.javaScriptEnabled = YES;
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) configuration:configuration];
    [self.view addSubview:_wkWebView];
    _wkWebView.backgroundColor = [UIColor clearColor];
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    //  打开网页的时候 滑动返回
    _wkWebView.allowsBackForwardNavigationGestures = YES;
    //  允许预览链接
    _wkWebView.allowsLinkPreview = YES;
    //  注册observer 拿到加载进度
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self initProgressView];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_wkWebView loadRequest:request];
}

#pragma mark --progressView
-(void)initProgressView{
    CGFloat progressBarHeight = 3.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
    _progressView.tintColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

#pragma mark - 检测进度条 显示完成之后进度条隐藏
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]){
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress ==1){
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        } else{
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark WKNavigationDelegate
//  页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//  页面内容开始返回调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    [self updateNavigationItems];
}

//  页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    self.title = webView.title;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
//  页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {

}

#pragma mark update NavigationItems
-(void)updateNavigationItems{
    if (self.wkWebView.canGoBack){
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(void)leftButtonClickAction:(UIButton *)sender{
    switch (sender.tag){
        case 2000:
            [self.wkWebView goBack];
            break;
        case 2001:
            break;
        default:
            break;
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.progressView removeFromSuperview];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.wkWebView.UIDelegate = nil;
    self.wkWebView.navigationDelegate = nil;
}

- (void)relodWebView {
    [self.wkWebView reload];
}
-(void)dealloc{

};
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
