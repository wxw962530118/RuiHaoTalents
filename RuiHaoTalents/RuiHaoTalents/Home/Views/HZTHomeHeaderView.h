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
@end

@interface HZTHomeHeaderView : UIView
+(instancetype)createHomeHeaderView;
@property (nonatomic, weak) id <HZTHomeHeaderViewDelegate> delegate;
/***/
@property (nonatomic, strong) HZTHomeHeaderModel * model;
@end

NS_ASSUME_NONNULL_END
