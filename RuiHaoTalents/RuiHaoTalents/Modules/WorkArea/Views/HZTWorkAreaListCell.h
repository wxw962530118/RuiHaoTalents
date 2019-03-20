//
//  HZTWorkAreaListCell.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTWorkAreaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTWorkAreaListCell : UICollectionViewCell
+ (instancetype)creatListCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)path;
/***/
@property (nonatomic, strong) HZTWorkAreaModel * model;
@end

NS_ASSUME_NONNULL_END
