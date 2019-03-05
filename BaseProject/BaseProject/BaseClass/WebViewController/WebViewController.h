//
//  WebViewController.h
//  HalfTheStudyApp
//
//  Created by JackerooChu on 2017/6/23.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import "BaseViewController.h"
//#import "BannerInfo.h"
@interface WebViewController : BaseViewController

/**
 * Origin url
 */
@property (nonatomic, strong) NSURL *url;
@property (nonatomic,copy) NSString *articleTitle;

/**
 * WebView
 */
@property (nonatomic, strong)UIWebView *webView;

/**
 * The color of progress view
 */
@property (nonatomic, strong)UIColor *progressViewColor;

/**
 * get instance with url
 * @param url url
 * @return instance
 */
-(instancetype )initWithUrl:(NSURL *)url;

/**
 * relod WebView
 */
-(void)reloadWebView;
//@property (nonatomic,strong) BannerInfo *info;
@end
