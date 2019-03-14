//
//  HZTToastHUD.h
//  KidsDigitalLibrary
//
//  Created by 王新伟 on 2018/6/21.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZTToastHUD : UIView
/**
 展示成功提示 包含图片
 @param title 需要展示文字
 */
+(void)showSucceedWithTitle:(NSString *)title;
/**
 展示错误提示 包含图片
 
 @param title 需要展示文字
 */
+(void)showErrorWithTitle:(NSString *)title;
/**
 展示警告提示 包含图片
 
 @param title 需要展示文字
 */
+(void)showWarnWithTitle:(NSString *)title;
/**
 展示纯文字提示
 @param title 需要展示文字
 */
+(void)showNormalWithTitle:(NSString *)title;
/**
 展示加载中
 */
+(void)showLoadingWithTitle:(NSString *)title;
/**
 隐藏加载中
 */
+(void)hideLoading;

+(void)showLoading;
@end
