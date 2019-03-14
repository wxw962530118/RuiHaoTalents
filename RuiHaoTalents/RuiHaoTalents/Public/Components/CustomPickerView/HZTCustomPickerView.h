//
//  HZTCustomPickerView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTCustomPickerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTCustomPickerView : UIView
+(instancetype)showPickerViewWithTitle:(NSString *)title dataArray:(NSArray *)dataArray callBack:(void (^)(HZTCustomPickerModel * model))callBack;
@end

NS_ASSUME_NONNULL_END
