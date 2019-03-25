//
//  HZTShareView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ShareType){
    ShareType_WeChat,  /**微信*/
    ShareType_Friends, /**朋友圈*/
};

@interface HZTShareView : UIView
+(instancetype)showWithCallBack:(void (^)(ShareType type))callBack;
@end

NS_ASSUME_NONNULL_END
