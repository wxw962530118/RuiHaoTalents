//
//  HZTImmediateMatchHeaderView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CallBackType){
    CallBackType_AllSort,   /**综合排序*/
    CallBackType_Distance,  /**距离*/
    CallBackType_Pay,       /**薪资*/
    CallBackType_Score      /**评分*/
};

@interface HZTImmediateMatchHeaderView : UIView
+(instancetype)createHomeHeaderView;
/***/
@property (nonatomic, copy) void (^callBack)(CallBackType type);
@end

NS_ASSUME_NONNULL_END
