//
//  HZTTopTabView.h
//  KidsEvaluation
//
//  Created by 王新伟 on 2018/12/17.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTTopTabModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,AlignmentType){
    AlignmentType_Left = 0,  /**默认内容居左*/
    AlignmentType_Center     /**居中样式 内部实现已做特殊处理*/
};

@interface HZTTopTabView : UIView
/**
 构建顶部tab控件
 @param callBack 选中某个的回调
 */
-(instancetype)initWithCallBack:(void (^)(HZTTopTabModel * model))callBack;
/**数据源*/
@property (nonatomic, strong) NSArray <HZTTopTabModel *>* dataArray;
/**横向item 间距自定义*/
@property (nonatomic, assign) CGFloat itemMargin;
/**item对齐方式*/
@property (nonatomic, assign) AlignmentType alignType;
/**外界自己处理布局 包括 item底部指示器的宽度*/
@property (nonatomic, assign) BOOL isUserHandel;
/**外界回调 内部需要选中位置*/
@property (nonatomic, assign) NSInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
