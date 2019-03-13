//
//  HZTLeftMenuView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTLeftMenuView.h"
#define MenuView_scale_of_Screen        0.8
#define CoverViewAlpha                  0.8
#define MenuViewBackgroundColor         [UIColor whiteColor]
#define CoverViewBackGround [UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1.0]

@interface HZTLeftMenuView ()
/**黑色遮罩*/
@property (nonatomic ,strong)UIView * coverView;
/**外界传入的左侧菜单栏*/
@property (nonatomic ,strong)UIView * leftMenuView;
/**是否展示黑色遮罩*/
@property (nonatomic ,assign)BOOL   isShowCoverView;;
/**左侧菜单宽度*/
@property (nonatomic, assign) CGFloat leftMenuWidth;
/*左侧菜单高度*/
@property (nonatomic, assign) CGFloat leftMenuHeight;
@end

@implementation HZTLeftMenuView

+(instancetype)menuViewWithVesselView:(UIView *)vesselView leftMenuView:(UIView *)leftMenuView isShowCover:(BOOL)isShowCover{
    HZTLeftMenuView * menu = [[HZTLeftMenuView alloc]initWithVesselView:vesselView leftMenuView:leftMenuView isShowCover:isShowCover];
    return menu;
}

-(instancetype)initWithVesselView:(UIView *)vesselView leftMenuView:(UIView *)leftMenuView isShowCover:(BOOL)isShowCover{
    if(self = [super init]){
        self.isShowCoverView = isShowCover;
        [self setDependencyView:vesselView];
        self.leftMenuWidth = leftMenuView.frame.size.width;
        self.leftMenuHeight = kScreenH;
        self.leftMenuView = leftMenuView;
        self.leftMenuView.frame = CGRectMake(-leftMenuView.frame.size.width,0,self.leftMenuWidth, self.leftMenuHeight);
        [self initView];
    }
    return self;
}

/**屏幕边缘pan手势(优先级高于其他手势)*/
-(void)setDependencyView:(UIView *)dependencyView{
    UIScreenEdgePanGestureRecognizer * leftEdgeGesture = \
    [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleLeftEdgeGesture:)];
    /**屏幕左侧边缘响应*/
    leftEdgeGesture.edges                             = UIRectEdgeLeft;
    [dependencyView addGestureRecognizer:leftEdgeGesture];
}

-(void)initView{
    self.coverView.backgroundColor = self.isShowCoverView ? CoverViewBackGround : [UIColor clearColor];
    [self setBackgroundColor:[UIColor clearColor]];
    [self.leftMenuView setBackgroundColor:MenuViewBackgroundColor];
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.coverView];
    [window addSubview:self.leftMenuView];
}

-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempFrame = self.leftMenuView.frame;
        tempFrame.origin.x = 0;
        self.leftMenuView.frame = tempFrame;
        self.coverView.alpha = CoverViewAlpha;
    }];
}

-(void)hidenWithoutAnimation{
    [self hideCoverAndMenuView];
}

-(void)hidenWithAnimation{
    [self coverTap];
}

#pragma mark --- 屏幕左侧菜单
-(UIView *)leftMenuView{
    if(!_leftMenuView){
        _leftMenuView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _leftMenuView;
}

#pragma mark --- 遮罩层
-(UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenW, kScreenH)];
        _coverView.backgroundColor                     = CoverViewBackGround;
        _coverView.alpha                               = 0;
        UITapGestureRecognizer * taoGes             = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverTap)];
        [_coverView addGestureRecognizer:taoGes];
        UIGestureRecognizer * panGes = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(handleftPan:)];
        [_coverView addGestureRecognizer:panGes];
        [taoGes requireGestureRecognizerToFail:panGes];
    }
    return _coverView;
}

#pragma mark --- coverView往左滑隐藏
-(void)handleftPan:(UIPanGestureRecognizer*)recognizer{
    CGPoint translation = [recognizer translationInView:recognizer.view];
    static CGFloat BeganX;
    if(UIGestureRecognizerStateBegan == recognizer.state){
        BeganX = translation.x;
    }
    CGFloat Place = (-translation.x) - (-BeganX);
    if(UIGestureRecognizerStateBegan == recognizer.state ||
       UIGestureRecognizerStateChanged == recognizer.state){
        if(Place <= self.leftMenuView.frame.size.width &&  Place >0){
            CGFloat x           = 0 - Place;
            self.leftMenuView.frame = CGRectMake(x, 0,self.leftMenuWidth, self.leftMenuHeight);
            self.coverView.alpha    = CoverViewAlpha*((self.leftMenuWidth - Place) / self.leftMenuWidth);
        }else if(Place >0){
            self.leftMenuView.frame = CGRectMake(-self.leftMenuWidth, 0, self.leftMenuWidth, self.leftMenuHeight);
        }else{
            self.leftMenuView.frame = CGRectMake(0, 0, self.leftMenuWidth, self.leftMenuHeight);
            self.coverView.alpha    = CoverViewAlpha;
        }
    }else{
        /**结束*/
        if(Place > self.leftMenuWidth/2){
            /**收起设置*/
            [self closeMenuView];
        }else{
            /**展开设置*/
            [self openMenuView];
        }
    }
}

#pragma mark - 屏幕往右滑处理
- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture{
    /**根据被触摸手势的view计算得出坐标值*/
    CGPoint translation = [gesture translationInView:gesture.view];
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state){
        if(translation.x <= self.leftMenuWidth){
            CGFloat x           = translation.x  - self.leftMenuWidth;
            CGFloat y           = 0;
            CGFloat w           = self.leftMenuWidth;
            CGFloat h           = self.leftMenuHeight;
            self.leftMenuView.frame = CGRectMake(x, y, w, h);
            self.coverView.alpha    = CoverViewAlpha*(translation.x / self.leftMenuView.frame.size.width);
        }else{
            self.leftMenuView.frame = CGRectMake(0,0,self.leftMenuWidth, self.leftMenuHeight);
            NotificationPost(HZTNOTIFICATION_SHOW_LEFT_MENU, nil, nil);
        }
    }
    else{
        /**结束*/
        if(translation.x > self.leftMenuWidth/2){
            /**展开设置*/
            [self openMenuView];
        }else{
            /**恢复设置*/
            [self closeMenuView];
        }
    }
}

-(void)openMenuView{
    [UIView animateWithDuration:0.3 animations:^{
        self.leftMenuView.frame = CGRectMake(0, 0, self.leftMenuWidth, self.leftMenuHeight);
        self.coverView.alpha    = CoverViewAlpha;
    }];
}

-(void)closeMenuView{
    [UIView animateWithDuration:0.3 animations:^{
        self.leftMenuView.frame = CGRectMake(-self.leftMenuWidth, 0, self.leftMenuWidth, self.leftMenuHeight);
    } completion:^(BOOL finished) {
        [self hideCoverAndMenuView];
    }];
}

#pragma mark --- 点击遮盖移除
-(void)coverTap{
    [UIView animateKeyframesWithDuration:0.003 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        self.leftMenuView.frame = CGRectMake(-self.leftMenuWidth,0, self.leftMenuWidth,  self.leftMenuHeight);
        self.coverView.alpha    = 0.0;
    } completion:^(BOOL finished) {
        NotificationPost(HZTNOTIFICATION_HIDE_LEFT_MENU, nil, nil);
    }];
}

#pragma mark --- 移除菜单和遮盖
-(void)hideCoverAndMenuView{
    self.leftMenuView.frame = CGRectMake(-self.leftMenuWidth,0, self.leftMenuWidth, self.leftMenuHeight);
    self.coverView.alpha    = 0.0;
    NotificationPost(HZTNOTIFICATION_HIDE_LEFT_MENU, nil, nil);
}


@end
