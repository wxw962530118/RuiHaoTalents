//
//  HZTToastHUD.m
//  KidsDigitalLibrary
//
//  Created by 王新伟 on 2018/6/21.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import "HZTToastHUD.h"

/**动画等待加载样式*/
static HZTToastHUD * loadHud;
static CAReplicatorLayer * replicatorLayer;
static CALayer * dot;

@interface HZTToastHUD (){
    
}
/***/
@property (nonatomic, strong) UIView * blackView;
/**上面的图片*/
@property (nonatomic, strong) UIImageView * topImageView;
/**下面的文字*/
@property (nonatomic, strong) UILabel * bottomLabel;
/**最上层的window*/
@property (nonatomic, strong) UIWindow * coverWindow;

@end

@implementation HZTToastHUD

+(void)showSucceedWithTitle:(NSString *)title{
    HZTToastHUD * hud = [[HZTToastHUD alloc]init];
    [hud handleToastWith:hud title:title imageName:@"right_write_big_icon"];
}


+(void)showErrorWithTitle:(NSString *)title{
    HZTToastHUD * hud = [[HZTToastHUD alloc]init];
    [hud handleToastWith:hud title:title imageName:@"wrong_write_big_icon"];
}

+(void)showWarnWithTitle:(NSString *)title{
    HZTToastHUD * hud = [[HZTToastHUD alloc]init];
    [hud handleToastWith:hud title:title imageName:@"warn_write_big_icon"];
}

+(void)showLoading{
    if (loadHud) {
        [loadHud removeFromSuperview];
    }
    loadHud = [[HZTToastHUD alloc]init];
    [[ToolBaseClass getRootWindow] addSubview:loadHud];
    [loadHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(loadHud.superview).with.insets(UIEdgeInsetsMake((IS_IPhoneX() ? 64 : 44) + StatusHeight, 0, 0, 0));
    }];
    loadHud.blackView.backgroundColor = RGBColorAlpha(0, 0, 0,.54);
    [loadHud addSubview:loadHud.blackView];
    [loadHud.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(loadHud.blackView.superview);
        make.size.mas_equalTo(CGSizeMake((120), (120)));
    }];
    [loadHud creatCircleJoinAnimationWithTitle:@"加载中..."];
}

+(void)showNormalWithTitle:(NSString *)title{
    HZTToastHUD * hud = [[HZTToastHUD alloc]init];
    for (UIWindow * windowView in [UIApplication sharedApplication].windows) {
        if ([@"UIRemoteKeyboardWindow" isEqualToString:NSStringFromClass([windowView class])]) {
            [windowView addSubview:hud];
            break;
        }else{
            [hud.coverWindow addSubview:hud];
        }
    }
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(hud.superview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    CGFloat width = [ToolBaseClass getWidthWithString:title font:HZTFontSize(16)] + (30);
    [hud addSubview:hud.blackView];
    hud.blackView.layer.cornerRadius = (4);
    [hud.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(hud.mas_bottom).offset((-20));
        make.centerX.equalTo(hud);
        make.size.mas_equalTo(CGSizeMake(width + 24,(35)));
    }];
    
    hud.bottomLabel.text = title;
    hud.bottomLabel.alpha = 0;
    hud.bottomLabel.numberOfLines = 1;
    [hud.blackView addSubview:hud.bottomLabel];
    [hud.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hud.blackView.mas_top).offset((7));
        make.center.equalTo(hud.blackView);
        make.width.mas_equalTo(width);
    }];
    
    [UIView animateWithDuration:.7f animations:^{
        hud.bottomLabel.alpha = 1;
        hud.blackView.backgroundColor = RGBColorAlpha(33, 33, 33, .8f);
    }];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.7f animations:^{
            hud.blackView.backgroundColor = RGBColorAlpha(33, 33, 33,0);
            hud.bottomLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
            hud.coverWindow.hidden = YES;
            hud.coverWindow = nil;
        }];
    });
}

-(void)handleToastWith:(HZTToastHUD *)hud title:(NSString *)title imageName:(NSString *)imageName{
    [self.coverWindow addSubview:hud];
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(hud.superview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [hud addSubview:hud.blackView];
    [hud.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(hud.blackView.superview);
        make.size.mas_equalTo(CGSizeMake((160), (160)));
    }];
    
    hud.topImageView.image = [UIImage imageNamed:imageName];
    [hud.blackView addSubview:hud.topImageView];
    hud.topImageView.alpha = 0;
    [hud.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(hud.blackView.mas_top).offset((100));
        make.centerX.equalTo(hud.blackView);
        make.size.mas_equalTo(CGSizeMake((70), (70)));
    }];
    
    hud.bottomLabel.text = title;
    hud.bottomLabel.alpha = 0;
    [hud.blackView addSubview:hud.bottomLabel];
    
    [hud.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hud.blackView.mas_top).offset((113));
        make.centerX.equalTo(hud.blackView);
        make.width.mas_equalTo((132));
    }];
    
    CGFloat oneLineHeight = [ToolBaseClass getHeightWithString:@"ZHT" width:(160) font:HZTFontSize(16)];
    CGFloat twoLineHeight =  [ToolBaseClass getHeightWithString:title width:(160) font:HZTFontSize(16)];
    if (twoLineHeight > oneLineHeight) {
        [hud.topImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hud.blackView.mas_top).offset((20));
            make.centerX.equalTo(hud.blackView);
            make.size.mas_equalTo(CGSizeMake((70), (70)));
        }];
        
        [hud.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hud.topImageView.mas_bottom).offset((13));
            make.centerX.equalTo(hud.blackView);
            make.width.mas_equalTo((132));
        }];
    }else{
        [hud.topImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(hud.blackView.mas_top).offset((100));
            make.centerX.equalTo(hud.blackView);
            make.size.mas_equalTo(CGSizeMake((70), (70)));
        }];
        
        [hud.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hud.blackView.mas_top).offset((113));
            make.centerX.equalTo(hud.blackView);
            make.width.mas_equalTo((132));
        }];
    }
    
    [UIView animateWithDuration:.7f animations:^{
        hud.topImageView.alpha = 1;
        hud.bottomLabel.alpha = 1;
        hud.blackView.backgroundColor = RGBColorAlpha(33, 33, 33, .8f);
    }];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.7f animations:^{
            hud.blackView.backgroundColor = RGBColorAlpha(33, 33, 33,0);
            hud.topImageView.alpha = 0;
            hud.bottomLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
            hud.coverWindow.hidden = YES;
            hud.coverWindow = nil;
        }];
    });
}

+(void)showLoadingWithTitle:(NSString *)title{
    if (loadHud) {
        [loadHud removeFromSuperview];
    }
    loadHud = [[HZTToastHUD alloc]init];
    [[ToolBaseClass getRootWindow] addSubview:loadHud];
    [loadHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(loadHud.superview).with.insets(UIEdgeInsetsMake((IS_IPhoneX() ? 64 : 44) + StatusHeight, 0, 0, 0));
    }];
    loadHud.blackView.backgroundColor = RGBColorAlpha(255, 255, 255,1);
    [loadHud addSubview:loadHud.blackView];
    [loadHud.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(loadHud.blackView.superview);
        make.size.mas_equalTo(CGSizeMake((120), (120)));
    }];
    [loadHud creatCircleJoinAnimationWithTitle:title];
//    if (loadHud) {
//        [loadHud removeFromSuperview];
//    }
//    loadHud = [[HZTToastHUD alloc]init];
//    [[ToolBaseClass getRootWindow] addSubview:loadHud];
//    [loadHud mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(loadHud.superview).with.insets(UIEdgeInsetsMake(NavBarHeight + StatusHeight, 0, 0, 0));
//    }];
//    loadHud.blackView.backgroundColor = RGBColorAlpha(33, 33, 33, .8f);
//    [loadHud addSubview:loadHud.blackView];
//    [loadHud.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(loadHud.blackView.superview);
//        make.size.mas_equalTo(CGSizeMake((120), (120)));
//    }];
    //[loadHud createCircleWithTitle:title];
}

-(void)createCircleWithTitle:(NSString *)title{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds          = CGRectMake(0, 0, (90), (90));
    replicatorLayer.position        =  CGPointMake(60,45);
    [loadHud.blackView.layer addSublayer:replicatorLayer];
    dot  = [CALayer layer];
    dot.bounds          = CGRectMake(0, 0, 10, 10);
    dot.position        = CGPointMake(50, 20);
    dot.backgroundColor = RGBColorAlpha(255, 255, 255,1).CGColor;
    dot.cornerRadius    = 5;
    dot.masksToBounds   = YES;
    [replicatorLayer addSublayer:dot];
    
    [loadHud.blackView addSubview:loadHud.bottomLabel];
    loadHud.bottomLabel.alpha = 1;
    loadHud.bottomLabel.text = title;
    [loadHud.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(loadHud.blackView.mas_bottom).offset(-(5));
        make.centerX.equalTo(loadHud.blackView);
        make.size.mas_equalTo(CGSizeMake((120), (30)));
    }];
    
    CGFloat count                     = 10.0;
    replicatorLayer.instanceCount     = count;
    CGFloat angel                     = 2 * M_PI/count;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angel, 0, 0, 1);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @1;
    animation.toValue     = @0.1;
    animation.repeatCount = MAXFLOAT;
    [dot addAnimation:animation forKey:nil];
    replicatorLayer.instanceDelay = 1.0/ count;
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}

- (void)creatCircleJoinAnimationWithTitle:(NSString *)title{
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds          = CGRectMake(0, 0, (90), (90));
    replicatorLayer.position        =  CGPointMake(60,55);
    [loadHud.blackView.layer addSublayer:replicatorLayer];
    dot = [CALayer layer];
    dot.bounds          = CGRectMake(0, 0, 4, 4);
    dot.position        = CGPointMake(50, 20);
    dot.backgroundColor = RGBColorAlpha(255, 255, 255,.8).CGColor;
    dot.cornerRadius    = 4;
    dot.masksToBounds   = YES;
    [replicatorLayer addSublayer:dot];
    
    [loadHud.blackView addSubview:loadHud.bottomLabel];
    loadHud.bottomLabel.alpha = 1;
    loadHud.bottomLabel.textColor = RGBColorAlpha(255, 255, 255, .8);
    loadHud.bottomLabel.text = title;
    [loadHud.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(loadHud.blackView.mas_bottom).offset(-(5));
        make.centerX.equalTo(loadHud.blackView);
        make.size.mas_equalTo(CGSizeMake((120), (30)));
    }];
    
    CGFloat count                     = 300.0;
    replicatorLayer.instanceCount     = count;
    CGFloat angel                     = 2 * M_PI/count;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angel, 0, 0, 1);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @0.8;
    animation.toValue     = @0.1;
    animation.repeatCount = MAXFLOAT;
    [dot addAnimation:animation forKey:nil];
    replicatorLayer.instanceDelay = 1.0/ count;
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}

+(void)hideLoading{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2f/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.5f animations:^{
            replicatorLayer.backgroundColor =  RGBColorAlpha(33, 33, 33, 0).CGColor;
            loadHud.blackView.backgroundColor = RGBColorAlpha(33, 33, 33,0);
            loadHud.bottomLabel.alpha = 0;
            dot.backgroundColor = RGBColorAlpha(255, 255, 255,0).CGColor;
        } completion:^(BOOL finished) {
            [loadHud.blackView removeFromSuperview];
            [loadHud.bottomLabel removeFromSuperview];
            [loadHud removeFromSuperview];
            loadHud.blackView = nil;
            loadHud.bottomLabel = nil;
            loadHud = nil;
        }];
    });
}

-(UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]init];
    }
    return _topImageView;
}

-(UIView *)blackView{
    if (!_blackView) {
        _blackView = [[UIView alloc]init];
        _blackView.layer.cornerRadius = (12);
        _blackView.layer.masksToBounds = true;
        _blackView.backgroundColor = RGBColorAlpha(33, 33, 33, 0);
    }
    return  _blackView;
}

-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.numberOfLines = 2;
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.font = HZTFontSize(16);
        _bottomLabel.textColor = [UIColor whiteColor];
    }
    return _bottomLabel;
}

-(UIWindow *)coverWindow{
    if (!_coverWindow) {
        _coverWindow = [[UIWindow alloc]init];
        _coverWindow.windowLevel = 1000000000;
        _coverWindow.hidden = NO;
        _coverWindow.backgroundColor = [UIColor clearColor];
    }
    return _coverWindow;
}

@end
