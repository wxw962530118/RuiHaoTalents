//
//  HZTCustomAlretView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CustomAlretType){
    CustomAlretType_Succeed,  /**成功样式*/
    CustomAlretType_Faield,   /**失败样式*/
};

@interface HZTCustomAlretView : UIView
+(instancetype)createAlretView;
-(void)configSubViewsType:(CustomAlretType)type title:(NSString *)title desc:(NSString *)desc isShowCancel:(BOOL)isShowCancel bottomTitle:(NSString *)bottomTitle callBack:(void (^)(void))callBack;
@end

NS_ASSUME_NONNULL_END
