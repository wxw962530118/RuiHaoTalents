//
//  HZTTopTabCollectionCell.h
//  KidsEvaluation
//
//  Created by 王新伟 on 2018/12/17.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTTopTabModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTTopTabCollectionCell : UICollectionViewCell
+ (instancetype)creatListCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)path;
/***/
@property (nonatomic, strong) HZTTopTabModel * model;
@end

NS_ASSUME_NONNULL_END
