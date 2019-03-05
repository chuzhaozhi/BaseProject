//
//  WebShareView.h
//  HalfTheStudy
//
//  Created by JackerooChu on 2018/12/19.
//  Copyright © 2018 JackerooChu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol WebShareViewDelegate <NSObject>
-(void)shareAction;

@end
@interface WebShareView : UIView
@property (nonatomic,weak) id<WebShareViewDelegate> webShareDelegate;
@end

NS_ASSUME_NONNULL_END
