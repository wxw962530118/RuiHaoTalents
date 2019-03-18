//
//  HZTMyResumeSectionFooterView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTMyResumeSectionFooterView : UIView
+(instancetype)createMyResumeSectionFooterViewWithTitle:(NSString *)title callBack:(void (^)(NSString * title))callBack;

@end

NS_ASSUME_NONNULL_END
