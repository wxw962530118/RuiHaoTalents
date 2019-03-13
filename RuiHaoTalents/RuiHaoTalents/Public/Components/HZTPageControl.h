//
//  HZTPageControl.h
//  KidsEvaluation
//
//  Created by 王新伟 on 2019/1/17.
//  Copyright © 2019年 haizitong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HZTPageControlType){
    HZTPageControlType_default,   /**默认的圆点样式*/
    HZTPageControlType_rectangle, /**首页长条样式*/
};

@interface HZTPageControl : UIControl
/**
 构建圆点指示器
 @param pageCount 总的个数
 @param type      需要展示的类型
 */
-(instancetype)initWithPageCount:(NSInteger )pageCount type:(HZTPageControlType )type pageContrlSize:(CGSize )pageContrlSize;
/**边框宽度*/
@property (nonatomic, assign) CGFloat borderWidth;
/**是否显示边框 默认显示边框*/
@property (nonatomic, assign) BOOL isShowBorder;
/**点的间隔*/
@property(nonatomic, assign)CGFloat   pageSpace;
/**点的背景颜色*/
@property(nonatomic, strong)UIColor   * pageBackgroundColor;
/**选中的背景色*/
@property(nonatomic, strong)UIColor   * selectedColor;
/**当前点击的pageNumber*/
@property(nonatomic, assign)NSInteger currentPageNumber;
@end

NS_ASSUME_NONNULL_END
