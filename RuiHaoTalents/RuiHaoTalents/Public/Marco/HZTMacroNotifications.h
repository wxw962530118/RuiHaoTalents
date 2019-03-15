//
//  HZTMacroNotifications.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HZTMacroNotifications : NSObject

@end

CG_INLINE void NotificationRegister(NSString *name, id observer, SEL selector, id object) {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}

CG_INLINE void NotificationPost(NSString *name, id object, NSDictionary *userInfo) {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

CG_INLINE void NotificationRemove(NSString *name, id observer, id object) {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
}

CG_INLINE void NotificationRemoveAll(id observer) {
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}

/**
 通知: 隐藏首页左侧菜单栏*/
UIKIT_EXTERN NSString *const HZTNOTIFICATION_HIDE_LEFT_MENU;

/**
 通知: 显示首页左侧菜单栏*/
UIKIT_EXTERN NSString *const HZTNOTIFICATION_SHOW_LEFT_MENU;

/**
 通知: 需要登录*/
UIKIT_EXTERN NSString *const HZTNOTIFICATION_SHOULD_LOGIN;

/**
 通知: 已经登录*/
UIKIT_EXTERN NSString *const HZTNOTIFICATION_DID_LOGIN_SUCCEED;

/**
 通知: 网络状态发生变化*/
UIKIT_EXTERN NSString *const HZTNOTIFICATION_NETWORK_CHANGED;

NS_ASSUME_NONNULL_END
