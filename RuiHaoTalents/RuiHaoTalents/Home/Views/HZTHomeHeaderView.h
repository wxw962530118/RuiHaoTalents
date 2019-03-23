//
//  HZTHomeHeaderView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTHomeHeaderModel.h"
NS_ASSUME_NONNULL_BEGIN
@class HZTHomeHeaderView;
@protocol HZTHomeHeaderViewDelegate <NSObject>
@optional
/**成为伯乐*/
-(void)clickJoinTalent:(HZTHomeHeaderView *)view;
/**我是伯乐*/
-(void)clickImTalent:(HZTHomeHeaderView *)view;
/**扫一扫*/
-(void)clickScan:(HZTHomeHeaderView *)view;
/**求职安全*/
-(void)clickSecurity:(HZTHomeHeaderView *)view;
/**立即匹配*/
-(void)clickImmediateMatch:(HZTHomeHeaderView *)view;
/**工作区域*/
-(void)clickWorkArea:(HZTHomeHeaderView *)view;
/**期望工作*/
-(void)clickExpectJob:(HZTHomeHeaderView *)view expectJobLabel:(UILabel *)expectJobLabel;
/**到岗开始时间*/
-(void)clickStartDate:(HZTHomeHeaderView *)view startDate:(NSString *)startDate;
/**到岗结束时间*/
-(void)clickEndDate:(HZTHomeHeaderView *)view endDate:(NSString *)endDate;
@end

@interface HZTHomeHeaderView : UIView
+(instancetype)createHomeHeaderView;
@property (nonatomic, weak) id <HZTHomeHeaderViewDelegate> delegate;
/**当前定位显示的市区/县*/
@property (nonatomic, copy) NSString * cityName;
/**期望工作*/
@property (nonatomic, copy) NSString * expectJobName;
/**到岗开始时间*/
@property (nonatomic, copy) NSString * startTime;
/**到岗结束时间*/
@property (nonatomic, copy) NSString * endTime;
/**到岗时间*/
@property (nonatomic, copy) NSString * arriveDay;
@end

NS_ASSUME_NONNULL_END
