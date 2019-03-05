//
//  WebViewProgress.m
//
//  Created by JackerooChu on 2017/6/23.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import "WebViewProgress.h"

NSString *completeRPCURLPath =@"/webviewprogressproxy/complete";

const float InitialProgressValue = 1.0f;
const float InteractiveProgressValue = 0.5f;
const float FinalProgressValue = 0.9f;

@implementation WebViewProgress {
    NSInteger _loadingCount;
    NSInteger _maxLoadCount;
    NSURL * _currentURL;
    BOOL _interactive;
}

- (id)init {
    self = [super init];
    if (self){
        _maxLoadCount = _loadingCount = 0;
        _interactive = NO;
    }
    return self;
}

-(void)startProgress{
    if (_progress < InitialProgressValue){
        [self setProgress:InitialProgressValue];
    }
}

-(void)increamentProgress{
    float progress = self.progress;
    float maxProgress = _interactive ? FinalProgressValue : InteractiveProgressValue;
    float remainPercent = (float )_loadingCount / (float )_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self setProgress:progress];
}

- (void)completeProgress{
    [self setProgress:1.0];
}

-(void) setProgress:(float )progress{
    if (progress > _progress || progress ==0){
        _progress = progress;
        if ([_progressDelegate respondsToSelector:@selector(webViewProgress:updateProgress:)]){
            [_progressDelegate webViewProgress:self updateProgress:progress];
        }
        if (_progressBlock){
            _progressBlock(progress);
        }
    }
}

- (void)reset {
    _maxLoadCount = _loadingCount = 0;
    _interactive = NO;
    [self setProgress:0.0];
}


#pragma mark -  UIWebViewDelegate
-(BOOL )webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.path isEqualToString:completeRPCURLPath]){
        [self completeProgress];
        return NO;
    }
    BOOL ret = YES;
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]){
        ret = [_webViewProxyDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    BOOL isFragmentJump = NO;
    if (request.URL.fragment){
        NSString *nonFragmentURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:request.URL.fragment] withString:@""];
        isFragmentJump = [nonFragmentURL isEqualToString:webView.request.URL.absoluteString];
    }

    BOOL isTopLevelNavigation = [request.mainDocumentURL isEqual:request.URL];

    BOOL isHttp = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"];
    if (ret && !isFragmentJump && isHttp && isTopLevelNavigation){
        _currentURL = request.URL;
        [self reset];
    }
    return ret;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidStartLoad:)]){
        [_webViewProxyDelegate webViewDidStartLoad:webView];
    }
    _loadingCount++;
    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
    [self startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]){
        [_webViewProxyDelegate webViewDidFinishLoad:webView];
    }
    _loadingCount--;
    [self increamentProgress];

    NSString *readyState  =[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL interactive =[readyState isEqualToString:@"interactive"];
    if (interactive){
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);",webView.request.mainDocumentURL.scheme,webView.request.mainDocumentURL.host,completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }

    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect){
        [self completeProgress];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView: didFailLoadWithError:)]){
        [_webViewProxyDelegate webView:webView didFailLoadWithError:error];
    }
    _loadingCount--;
    [self increamentProgress];

    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive){
        _interactive = YES;
        NSString *waitForCompleteJS =[NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if ((complete && isNotRedirect)||(error)){
        [self completeProgress];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]){
        return YES;
    }
    if ([self.webViewProxyDelegate respondsToSelector:aSelector]){
        return YES;
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature){
        if ([_webViewProxyDelegate respondsToSelector:aSelector]){
            return [(NSObject *)_webViewProxyDelegate methodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([_webViewProxyDelegate respondsToSelector:[anInvocation selector]]){
        [anInvocation invokeWithTarget:_webViewProxyDelegate];
    }
}

@end
