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
-(void)clickJoinTalent:(HZTHomeHeaderView *)view;
-(void)clickImTalent:(HZTHomeHeaderView *)view;
-(void)clickScan:(HZTHomeHeaderView *)view;
-(void)clickSecurity:(HZTHomeHeaderView *)view;
@end

@interface HZTHomeHeaderView : UIView
+(instancetype)createHomeHeaderView;
@property (nonatomic, weak) id <HZTHomeHeaderViewDelegate> delegate;
/***/
@property (nonatomic, strong) HZTHomeHeaderModel * model;
@end

NS_ASSUME_NONNULL_END
