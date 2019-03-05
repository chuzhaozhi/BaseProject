//
//  RootWebViewController.h
//
//  Created by JackerooChu on 2017/6/24.
//  Copyright © 2017年 JackerooChu. All rights reserved.
//

#import "BaseViewController.h"

/**
 * WebView 基类
 */
@interface RootWebViewController : BaseViewController

/**
 * origin url
 */
@property (nonatomic, copy) NSString *url;

/**
 * 进度条颜色
 */
@property (nonatomic, strong) UIColor *progressViewColor;

/**
 * 初始化
 * @param url  访问的地址
 * @return
 */
-(instancetype )initWithUrl:(NSString *)url;
/**
 * 刷新网页
 */
-(void)relodWebView;
@end
