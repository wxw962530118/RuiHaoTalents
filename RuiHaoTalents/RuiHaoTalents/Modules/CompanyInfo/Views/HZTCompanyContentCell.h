//
//  HZTCompanyContentCell.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/26.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTCompanyContentCell : UITableViewCell
/***/
@property (nonatomic, copy) void (^Block)(CGFloat offSetY);
@end

NS_ASSUME_NONNULL_END
