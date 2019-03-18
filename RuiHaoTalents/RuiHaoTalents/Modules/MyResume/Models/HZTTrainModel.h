//
//  HZTTrainModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTTrainModel : HZTBaseModel
/**学历ID*/
@property (nonatomic, copy) NSString * humanDiploma;
/**学历名称*/
@property (nonatomic, copy) NSString * humanDiplomaName;
/**ID*/
@property (nonatomic, copy) NSString * trainId;
/**专业*/
@property (nonatomic, copy) NSString * trainMajor;
/**名称*/
@property (nonatomic, copy) NSString * trainName;
/**开始时间*/
@property (nonatomic, copy) NSString * trainStart;
/**结束时间*/
@property (nonatomic, copy) NSString * trainEnd;
/**cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
