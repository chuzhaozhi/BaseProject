//
//  BadgeButton.h
//  BCWMall
//
//  Created by Reminisce on 16/4/25.
//  Copyright (c) 2016 百草味. All rights reserved.
//

@interface BadgeButton : UIView
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *titleLabel;
/**
 * 设置按钮信息
 */
-(void)setBadgeButtonInfo:(UIImage *)buttonIMG badgeNum:(NSInteger) badge buttonTitle:(NSString *) title;

@end
