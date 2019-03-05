//
//  WebShareView.m
//  HalfTheStudy
//
//  Created by JackerooChu on 2018/12/19.
//  Copyright © 2018 JackerooChu. All rights reserved.
//

#import "WebShareView.h"
@interface WebShareView ()
@property (nonatomic,strong) UIImageView *shareImage;
@end
@implementation WebShareView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.shareImage];
        [self.shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self);
            make.size.equalTo(CGSizeMake(45, 45));
            
        }];
    }
    return self;
}
-(void)tapShare:(UITapGestureRecognizer *)tap{
    if (self.webShareDelegate && [self.webShareDelegate respondsToSelector:@selector(shareAction)]) {
        [self.webShareDelegate shareAction];
    }
}
-(UIImageView *)shareImage{
    if (!_shareImage) {
        _shareImage =[[UIImageView alloc] initWithFrame:CGRectZero];
        _shareImage.image =LOAD_LOCAL_IMG(@"webShare.jpg");
        _shareImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShare:)];
        [_shareImage addGestureRecognizer:tap];
    }
    return _shareImage;
}
@end
