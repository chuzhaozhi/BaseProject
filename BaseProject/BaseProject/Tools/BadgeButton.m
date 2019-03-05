//
//  BadgeButton.m
//  BCWMall
//
//  Created by Reminisce on 16/4/25.
//  Copyright (c) 2016 百草味. All rights reserved.
//

#import "BadgeButton.h"

#import "View+MASShorthandAdditions.h"

#define COLOR_TEXT RGBA(109,116,121,1)
@interface BadgeButton()


@property (nonatomic, strong) UILabel *badge;


@end

@implementation BadgeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 * 初始化页面
 */
-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc] init];
        self.img.contentMode = UIViewContentModeScaleAspectFit;
        self.badge = [[UILabel alloc] init];
        self.badge.backgroundColor = [UIColor redColor];
        self.badge.font = FONT(8);
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.textColor = [UIColor whiteColor];
        self.badge.layer.cornerRadius = 8;
        self.badge.layer.masksToBounds = YES;
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = FONT(11);
        self.titleLabel.textColor = COLOR_TEXT;
        self.userInteractionEnabled = YES;
        self.img.userInteractionEnabled = YES;
        self.badge.userInteractionEnabled = YES;
        self.titleLabel.userInteractionEnabled = YES;
        [self addSubview];
        [self autoLayout];
    }
    return self;
}
/**
 * 添加页面
 */
-(void)addSubview{

    [self addSubview:self.img];
    [self addSubview:self.badge];
    [self addSubview:self.titleLabel];

}
/**
 * 页面自动适配
 */
-(void) autoLayout{

    [self.img makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.offset(0);
        make.bottom.equalTo(self.titleLabel.top).offset(-12);
        make.size.equalTo(CGSizeMake(self.frame.size.width,self.frame.size.width));
//        make.centerX.equalTo(self.centerX);
    }];

    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.equalTo(14);
        make.centerX.equalTo(self.img.centerX);
    }];

    [self.badge makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img.top).offset(-7);
        make.leading.equalTo(self.img.trailing).offset(-7);
        make.size.equalTo(CGSizeMake(16,16));
    }];
}

-(void)setBadgeButtonInfo:(UIImage *)buttonIMG
                 badgeNum:(NSInteger) badge
              buttonTitle:(NSString *) title {

    self.badge.hidden = badge > 0 ? false : true;
    if (badge > 99){
        self.badge.text = @"99+";
    }else{
        self.badge.text = [NSString stringWithFormat:@"%ld",(long)badge];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@",title];
    self.img.image = buttonIMG;

}

@end
