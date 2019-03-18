//
//  HZTResumeModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTResumeModel : HZTBaseModel
/**描述*/
@property (nonatomic, copy) NSString * resumeDescribe;
/**ID*/
@property (nonatomic, copy) NSString * resumeId;
/**名称*/
@property (nonatomic, copy) NSString * resumeName;
/**职位*/
@property (nonatomic, copy) NSString * resumePosition;
/**开始时间*/
@property (nonatomic, copy) NSString * startDate;
/**结束时间*/
@property (nonatomic, copy) NSString * endDate;
/**cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
