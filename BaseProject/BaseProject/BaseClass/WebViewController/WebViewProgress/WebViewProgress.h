//
//  WebViewProgress.h
//  HalfTheStudyApp
//
//  Created by JackerooChu on 2017/6/23.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef czz_weak
#if __has_feature(objc_arc_weak)
#define czz_weak weak
#else
#define czz_weak unsafe_unretained
#endif

extern const float InitialProgressValue;
extern const float InteractiveProgressValue;
extern const float FinalProgressValue;

typedef void (^WebViewProgressBlock)(float progress);

@protocol WebViewProgressDelegate;



@interface WebViewProgress : NSObject <UIWebViewDelegate>



@property (nonatomic,czz_weak) id <WebViewProgressDelegate> progressDelegate;
@property (nonatomic,czz_weak) id <UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) WebViewProgressBlock progressBlock;
@property (nonatomic, readonly) float progress;  //0.0...1.0

-(void)reset;
@end
@protocol WebViewProgressDelegate<NSObject>
-(void)webViewProgress:(WebViewProgress *)webViewProgress updateProgress:(float )progress;
@end
