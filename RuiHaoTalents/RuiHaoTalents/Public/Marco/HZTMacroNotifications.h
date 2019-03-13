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
 通知: NAME*/
UIKIT_EXTERN NSString *const HZTNOTIFICATION_CLASS_TEACHER_LIST_SELECED_NORMAL;

NS_ASSUME_NONNULL_END
