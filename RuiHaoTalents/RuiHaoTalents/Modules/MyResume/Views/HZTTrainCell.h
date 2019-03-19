//
//  HZTTrainCell.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/19.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTTrainModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,TrainCallBackType){
    TrainCallBackType_Add,     /**添加*/
    TrainCallBackType_LookMore /**查看更多*/
};

@interface HZTTrainCell : UITableViewCell
/**教育经历模型*/
@property (nonatomic, strong) HZTTrainModel * model;
/***/
@property (nonatomic, copy) void (^callBack)(TrainCallBackType type);
@end

NS_ASSUME_NONNULL_END
