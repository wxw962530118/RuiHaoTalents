//
//  HZTBaseViewController.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTBaseViewController : UIViewController
-(void)ctNavRightItemWithTitle:(NSString * __nullable)title imageName:(NSString * __nullable)imageName callBack:(void (^)(void))callBack;
@end

NS_ASSUME_NONNULL_END
