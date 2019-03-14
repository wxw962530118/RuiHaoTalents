//
//  HZTCustomSheetView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTCustomSheetView : UIView
+(instancetype)showCustomSheetViewTitle:(NSString *)title contentArr:(NSArray <NSString *>*)contentArr callBack:(void (^)(NSInteger index))callBack;
@end

NS_ASSUME_NONNULL_END
