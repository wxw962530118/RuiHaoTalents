//
//  HZTPostDescCell.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTTagViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTPostDescCell : UITableViewCell
/***/
@property (nonatomic,copy) void(^changed)(CGFloat height);
/***/
@property (nonatomic, strong) NSArray <HZTTagViewModel *>* array;
@end

NS_ASSUME_NONNULL_END
