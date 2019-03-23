//
//  HZTFeedBackCell.h
//  RuiHaoTalents
//
//  Created by zhangshumeng on 2019/3/23.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTFeedBackCell : UICollectionViewCell

@property (nonatomic, assign) BOOL hiddenDeleteBtn;

@property (nonatomic, strong) UIImage *image;

- (void)deleteBlock:(void(^)(void))callback;

@end

NS_ASSUME_NONNULL_END
