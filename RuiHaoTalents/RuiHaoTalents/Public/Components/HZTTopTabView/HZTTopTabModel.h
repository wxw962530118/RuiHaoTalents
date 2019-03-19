//
//  HZTTopTabModel.h
//  KidsEvaluation
//
//  Created by 王新伟 on 2018/12/17.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTTopTabModel : HZTBaseModel
/***/
@property (nonatomic, copy) NSString * title;
/***/
@property (nonatomic, copy) NSString * imageName;
/***/
@property (nonatomic, assign) BOOL isSelectd;
/**根据文字计算的item宽度*/
@property (nonatomic, assign) float itemW;
/**根据item的高度*/
@property (nonatomic, assign) float itemH;
/**未读消息数量*/
@property (nonatomic, assign) NSInteger messageCnt;
@end

NS_ASSUME_NONNULL_END
