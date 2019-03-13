//
//  HZTLeftMenuView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTLeftMenuView : UIView
/**
 类方法构建侧边菜单栏
 @param vesselView      承载手势侧滑手势的容器view
 @param leftMenuView    需要展示的菜单栏
 @param isShowCover     是否展示遮罩层
 */
+(instancetype)menuViewWithVesselView:(UIView *)vesselView leftMenuView:(UIView *)leftMenuView isShowCover:(BOOL)isShowCover;
/**
 实例方法构建侧边菜单栏
 @param vesselView      承载手势侧滑手势的容器view
 @param leftMenuView    需要展示的菜单栏
 @param isShowCover     是否展示遮罩层
 */
-(instancetype)initWithVesselView:(UIView *)vesselView leftMenuView:(UIView *)leftMenuView isShowCover:(BOOL)isShowCover;
/**外界点击按钮事件触发 动画弹出侧边栏*/
-(void)show;
/**不带动画形式隐藏侧边栏*/
-(void)hidenWithoutAnimation;
/**以动画形式隐藏侧边栏*/
-(void)hidenWithAnimation;
@end

NS_ASSUME_NONNULL_END
