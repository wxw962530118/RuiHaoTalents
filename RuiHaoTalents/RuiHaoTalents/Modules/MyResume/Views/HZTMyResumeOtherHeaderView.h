//
//  HZTMyResumeOtherHeaderView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/17.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTMyResumeOtherHeaderView : UIView
+(instancetype)createMyResumeOtherHeaderViewWithCallBack:(void (^)(void))callBack;
/***/
@property (nonatomic, copy) NSString *title;
/***/
@property (nonatomic, assign) BOOL isExpend;

@end

NS_ASSUME_NONNULL_END
