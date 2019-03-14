//
//  HZTLoginRegisterCell.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTLoginRegisterModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface HZTLoginRegisterCell : UITableViewCell
@property (nonatomic, strong) HZTLoginRegisterModel * model;
@property (nonatomic,copy) void (^getCodeBtnCallBack)(void);
@property (nonatomic,copy) void (^textChangedBlock)(NSString * str,NSString * placeholder);
-(void)getCodeSucceed;
-(void)destroyTimer;
@end

NS_ASSUME_NONNULL_END
