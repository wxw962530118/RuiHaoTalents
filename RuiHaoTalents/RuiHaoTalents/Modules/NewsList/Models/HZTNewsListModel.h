//
//  HZTNewsListModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/19.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTNewsListModel : HZTBaseModel
/***/
@property (nonatomic, copy) NSString * imageName;
/***/
@property (nonatomic, copy) NSString * title;
/**/
@property (nonatomic, strong) NSString * desc;
/***/
@property (nonatomic, copy) NSString * createTime;
/***/
@property (nonatomic, assign) BOOL isHideRed;
/***/
@property (nonatomic, assign) BOOL isShowState;
/***/
@property (nonatomic, copy) NSString * stateName;
/***/
@property (nonatomic, strong) UIColor * stateColor;
@end

NS_ASSUME_NONNULL_END
