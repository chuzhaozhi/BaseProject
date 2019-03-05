//
//  GuideView.m
//  HalfTheStudy
//
//  Created by JackerooChu on 2018/3/1.
//  Copyright © 2018年 JackerooChu. All rights reserved.
//

#import "GuideView.h"


#define  isIphone5 568

#define  isIphone6 667

#define isIphone6plus 736

@interface GuideView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation GuideView



- (UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [[UIButton alloc]initWithFrame:CGRectMake(40, ScreenH - 130 , ScreenW - 80, 50)];
        [_sureButton setTitle:@"立即体验" forState:UIControlStateNormal];
        _sureButton.userInteractionEnabled = YES;
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = 25;
        _sureButton.backgroundColor = RGB(0, 145, 212);
        _sureButton.enabled = YES;
        [_sureButton addTarget:self action:@selector(clickSureButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (instancetype)init {

    self = [super init];

    self.userInteractionEnabled = YES;

    self.frame = CGRectMake(0,0,ScreenW,ScreenH);

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,ScreenW,ScreenH)];
    self.scrollView.contentSize = CGSizeMake(4*ScreenW,ScreenH);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(ScreenW/2 -30,ScreenH - 50,60,30)];
//    self.pageControl.numberOfPages = 4;
//    self.pageControl.currentPage = 0;
//    self.pageControl.currentPageIndicatorTintColor = RGB(0, 145, 212);;
//    self.pageControl.pageIndicatorTintColor = RGB(64, 64, 64);
    self.scrollView.contentOffset = CGPointMake(0,0);
    self.scrollView.bounces = NO;

    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];

    UIImageView *pageOne = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,ScreenW,ScreenH)];
//    pageOne.userInteractionEnabled = YES;
    UIImageView *pageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW,0,ScreenW,ScreenH)];
//    pageTwo.userInteractionEnabled = YES;
    UIImageView *pageThree = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW*2,0,ScreenW,ScreenH)];
//    pageThree.userInteractionEnabled = YES;
    UIImageView *pageFourth = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW*3,0,ScreenW,ScreenH)];
//    pageFourth.userInteractionEnabled = YES;
//    UIImageView *pageFive = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW*4,0,ScreenW,ScreenH)];
    [pageFourth addSubview:self.sureButton];
    pageFourth.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];

    [pageFourth addGestureRecognizer:tapGestureRecognizer];

//    int screenh = (int)ScreenH;
    pageOne.image = LOAD_LOCAL_IMG(@"guid_1");
    pageTwo.image = LOAD_LOCAL_IMG(@"guid_2");
    pageThree.image =LOAD_LOCAL_IMG(@"guid_3");
    pageFourth.image = LOAD_LOCAL_IMG(@"guid_4");
//    switch (screenh){
//
//        case isIphone5:{
//            pageOne.image = LOAD_LOCAL_IMG(@"guideHome");
//            pageTwo.image = LOAD_LOCAL_IMG(@"guideHouseSource");
//            pageThree.image =LOAD_LOCAL_IMG(@"guideBalance");
//            pageFourth.image = LOAD_LOCAL_IMG(@"guideSecurity");
//            pageFive.image = LOAD_LOCAL_IMG(@"guideUseful");
//            break;
//        }
//
//        case isIphone6:{
//            pageOne.image = LOAD_LOCAL_IMG(@"guideHome6");
//            pageTwo.image = LOAD_LOCAL_IMG(@"guideHouseSource6");
//            pageThree.image =LOAD_LOCAL_IMG(@"guideBalance6");
//            pageFourth.image = LOAD_LOCAL_IMG(@"guideSecurity6");
//            pageFive.image = LOAD_LOCAL_IMG(@"guideUseful6");
//            break;
//        }
//
//        case isIphone6plus:{
//            pageOne.image = LOAD_LOCAL_IMG(@"guideHome");
//            pageTwo.image = LOAD_LOCAL_IMG(@"guideHouseSource");
//            pageThree.image =LOAD_LOCAL_IMG(@"guideBalance");
//            pageFourth.image = LOAD_LOCAL_IMG(@"guideSecurity");
//            pageFive.image = LOAD_LOCAL_IMG(@"guideUseful");
//            break;
//        }
//
//        default:{
//            pageOne.image = LOAD_LOCAL_IMG(@"guideHome");
//            pageTwo.image = LOAD_LOCAL_IMG(@"guideHouseSource");
//            pageThree.image =LOAD_LOCAL_IMG(@"guideBalance");
//            pageFourth.image = LOAD_LOCAL_IMG(@"guideSecurity");
//            pageFive.image = LOAD_LOCAL_IMG(@"guideUseful");
//            break;
//        }
//    }

    [self.scrollView addSubview:pageOne];

    [self.scrollView addSubview:pageTwo];

    [self.scrollView addSubview:pageThree];

    [self.scrollView addSubview:pageFourth];

//    [self.scrollView addSubview:pageFive];
    return self;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger page = (NSInteger) (scrollView.contentOffset.x / ScreenW);

    _pageControl.currentPage = page;

}
-(void)clickSureButton:(UIButton *)sender{

    [UserDefaults setUsed:YES];

    [self removeFromSuperview];
}
-(void)hideView{

    [UserDefaults setUsed:YES];

    [self removeFromSuperview];

}

-(void)showInView:(UIView *)view{

    [view addSubview:self];

}



@end
