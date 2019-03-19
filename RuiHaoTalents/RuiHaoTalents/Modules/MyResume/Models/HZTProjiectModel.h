//
//  HZTProjiectModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTProjiectModel : HZTBaseModel
/**描述*/
@property (nonatomic, copy) NSString * projectDescribe;
/**ID*/
@property (nonatomic, copy) NSString * projectId;
/**名称*/
@property (nonatomic, copy) NSString * projectName;
/**职位*/
@property (nonatomic, copy) NSString * projectPost;
/**开始时间*/
@property (nonatomic, copy) NSString * projectStart;
/**结束时间*/
@property (nonatomic, copy) NSString * projectEnd;
/**cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/**展示查看更多*/
@property (nonatomic, assign) BOOL isShowMore;
@end

NS_ASSUME_NONNULL_END
