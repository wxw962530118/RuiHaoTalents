//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
#define Tag 989
#import "MBProgressHUD+MJ.h"
#import "AppDelegate.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    /**
     将 [self getRootWindow] 替换为 App_TheFrontViewC.view 处理当UIAlertView 和 MBProgressHUD同时出现  取keyWindow引起的MBProgressHUD 显示方向的bug [在适配ipad横屏显示的时候]
     */
    if (view == nil) view = [ToolBaseClass getRootWindow];
    UIView  * tagView  =[view viewWithTag:Tag];
    if (tagView) {
        return;
    }
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.tag = Tag;
    hud.labelText = text;
    
    hud.labelFont= [UIFont systemFontOfSize:18];
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.opacity=0.7;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.8 秒之后再消失
    [hud hide:YES afterDelay:1.8];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [self getRootWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.opacity=0.7;
    
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)showLoading{
    return [self showLoadingtoView:nil];
}

+ (MBProgressHUD *)showLoadingtoView:(UIView *)view {
    if (view == nil) view = [self getRootView];
    
//    view = App_TheFrontNavC.view;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, (126), (131))];
    bgView.backgroundColor=[UIColor clearColor];
    bgView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
    bgView.layer.cornerRadius = 30;
    
    UIView *bgCoverView=[[UIView alloc]initWithFrame:bgView.bounds];
    bgCoverView.backgroundColor=[UIColor blackColor];
    bgCoverView.layer.cornerRadius = 30;
    bgCoverView.alpha=0.7;
    [bgView addSubview:bgCoverView];
    
//    NSMutableArray *animateImages=[[NSMutableArray alloc]init];
//    for (int i=80; i>0; i--) {
//        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
//        [animateImages addObject:image];
//    }
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [TCScreeAdaptation changeStaticWidthtNumberToFit:128], [TCScreeAdaptation changeStaticHeightNumberToFit:215])];
//    imageView.center=CGPointMake(bgView.bounds.size.width/2.0, bgView.bounds.size.height/2.0);
//    imageView.backgroundColor=[UIColor clearColor];
//    imageView.userInteractionEnabled=YES;
//    imageView.animationImages=[NSArray arrayWithArray:animateImages];
//    imageView.animationDuration=3;
//    imageView.animationRepeatCount=0;
//    [imageView startAnimating];
//    [bgView addSubview:imageView];

//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Toast_Load_Round_Bg"]];
//    [bgView addSubview:imageView];
//    [TCToolBaseClass popRotationAnimation:imageView];
//    imageView.sd_layout
//    .centerXEqualToView(bgView)
//    .topSpaceToView(bgView, TCHeight(25))
//    .widthIs(TCWidth(55))
//    .heightIs(TCHeight(55));
//    
//    UILabel *label = [[UILabel alloc] init];
//    [bgView addSubview:label];
//    label.text = @"正在加载";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = TCFontSizeSys14;
//    label.textColor = TCColorWhiteGround;
//    label.sd_layout
//    .topSpaceToView(imageView, 16)
//    .leftEqualToView(bgView)
//    .rightEqualToView(bgView)
//    .heightIs(TCHeight(14));
//    
//     //设置图片
//    hud.customView = bgView;
//    
//     //再设置模式
//    hud.mode = MBProgressHUDModeCustomView;
//    
//     //隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    
//    hud.color=[UIColor clearColor];
    
    return hud;
}

+ (UIView *)getRootView{
    UIWindow *window=[self getRootWindow];
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    UIViewController *result = nil;
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result.view;
}

+ (UIWindow *)getRootWindow{
    NSArray *windows = [UIApplication sharedApplication].windows;
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)&&window==delegate.window)
            
            return window;
    }
    return [[UIApplication sharedApplication].delegate window];
}

+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [self getRootWindow];
    
//    view = App_TheFrontNavC.view;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUDForMessage{
    [self hideHUDForView:nil];
}

+ (void)hideHUD{
    NSEnumerator *subviewsEnum = [[self getRootView].subviews reverseObjectEnumerator];
    
//    NSEnumerator *subviewsEnum = [App_TheFrontNavC.view.subviews reverseObjectEnumerator];

    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            MBProgressHUD *hud=(MBProgressHUD *)subview;
            if (hud.mode == MBProgressHUDModeCustomView) {
                for (id view in hud.customView.subviews) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES];
                    }
                }
            }
        }
    }
}


+ (void)showMessageForDelay:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self getRootWindow] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    //    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

@end
