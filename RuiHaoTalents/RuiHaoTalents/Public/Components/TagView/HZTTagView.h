//
//  HZTTagView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTTagViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTTagView : UIView
+ (instancetype)createCollectionView;
/***/
@property (nonatomic,copy) void(^changed)(CGFloat height);
/**/
@property (nonatomic, strong) NSArray <HZTTagViewModel *>* dataArray;
@end

NS_ASSUME_NONNULL_END
