//
//  HZTWorkAreaModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTWorkAreaModel : HZTBaseModel
/***/
@property (nonatomic, copy) NSString * name;
/***/
@property (nonatomic, copy) NSString * id;
/***/
@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
