//
//  HZTTagViewModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTTagViewModel : HZTBaseModel
/***/
@property (nonatomic, copy) NSString * name;
/***/
@property (nonatomic, copy) NSString * id;
/***/
@property (nonatomic, assign) BOOL isSelected;
/**背景色*/
@property (nonatomic, strong) UIColor * bgColor;
/**边框颜色*/
@property (nonatomic, strong) UIColor * borderColor;

@end

NS_ASSUME_NONNULL_END
