//
//  HZTChoosePostView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTChoosePostModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,MenuLevelType){
    MenuLevelType_First,  /**一级菜单*/
    MenuLevelType_Second, /**二级菜单*/
    MenuLevelType_Third   /**三级菜单*/
};
@interface HZTChoosePostView : UIView
-(instancetype)initWithType:(MenuLevelType)type callBack:(void (^)(NSString * name,NSString * Id,MenuLevelType type))callBack;
/***/
@property (nonatomic, strong) NSMutableArray <HZTChoosePostModel *>* dataArray;

@end

NS_ASSUME_NONNULL_END
