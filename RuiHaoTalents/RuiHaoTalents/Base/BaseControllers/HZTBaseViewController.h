//
//  HZTBaseViewController.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTBaseViewController : UIViewController
/***/
@property (nonatomic, strong) HZTBaseView * baseView;
/**导航栏标题*/
@property (nonatomic, copy) NSString * navTitle;
/**
 构建导航栏右侧按钮
 @param title     文字
 @param imageName 图片
 @param callBack  回调
 */
-(void)ctNavRightItemWithTitle:(NSString * __nullable)title imageName:(NSString * __nullable)imageName callBack:(void (^)(void))callBack;
/**
 跳转页面
 @param viewController 跳转控制器
 @param animated       是否动画
 */
-(void)xw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
/**
 返回页面
 @param viewController 跳转控制器
 @param animated       是否动画
 */
-(void)xw_popViewController:(UIViewController * __nullable)viewController animated:(BOOL)animated;

/**
 展示无数据页面
 @param supersView 承载无数据的父级
 */
-(void)showNoDataViewWithSupersView:(UIView *)supersView;

/**
 隐藏无数据页面
 */
-(void)hideNoDataView;
@end

NS_ASSUME_NONNULL_END
