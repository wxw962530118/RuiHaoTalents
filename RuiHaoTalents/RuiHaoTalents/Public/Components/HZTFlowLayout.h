//
//  HZTFlowLayout.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
/**对齐方式*/
typedef NS_ENUM(NSInteger,AlignType){
    AlignWithLeft,    /**左对齐*/
    AlignWithCenter,  /**居中对齐*/
    AlignWithRight    /**右对齐*/
};
NS_ASSUME_NONNULL_BEGIN

@interface HZTFlowLayout : UICollectionViewFlowLayout
/**两个Cell之间的距离*/
@property (nonatomic,assign)CGFloat betweenOfCell;
/**cell对齐方式*/
@property (nonatomic,assign)AlignType cellType;
/***/
-(instancetype)initWthType : (AlignType)cellType;
/**初始化方法 其他方式初始化最终都会走到这里*/
-(instancetype)initWithType:(AlignType) cellType betweenOfCell:(CGFloat)betweenOfCell;

@end

NS_ASSUME_NONNULL_END
