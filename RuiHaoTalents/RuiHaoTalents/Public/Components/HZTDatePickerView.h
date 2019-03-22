//
//  HZTDatePickerView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/22.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTDatePickerView : UIView
/**
 构建时间选择器
 @param title       标题
 @param frame       大小 / 位置
 @param defaultDate 默认时间
 @param minDate     最小时间
 @param maxDate     最大时间
 @param callBack    回调
 */
+(instancetype)showDatePickerViewWithFrame:(CGRect)frame title:(NSString *)title defaultDate:(NSDate *)defaultDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate callBack:(void (^)(NSDate * date))callBack;
@end

NS_ASSUME_NONNULL_END
