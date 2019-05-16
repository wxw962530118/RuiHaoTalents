//
//  HZTNavView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/26.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTNavView : UIView
-(instancetype)initWithFrame:(CGRect)frame callBack:(void(^)(void))callBack;
@property (nonatomic, copy) void (^clickRightBlock)(void);
-(void)setNavBarWithAlpha:(CGFloat )alpha;
-(void)setNavTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
