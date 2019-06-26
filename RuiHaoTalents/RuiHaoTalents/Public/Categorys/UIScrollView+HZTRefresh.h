//
//  UIScrollView+HZTRefresh.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/23.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (HZTRefresh)
-(void)beginRefresh;
/**
 下拉刷新
 @param beginRefresh 是否自动刷新
 @param animation    是否需要动画
 @param refreshBlock 刷新回调
 */
- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void(^)(NSInteger pageIndex))refreshBlock;

/**
 上拉加载
 @param autoRefresh 是否自动加载
 @param loadMoreBlock        加载回调
 */
- (void)addFooterWithWithHeaderWithAutoRefresh:(BOOL)autoRefresh loadMoreBlock:(void(^)(NSInteger pageIndex))loadMoreBlock;

/**
 普通请求结束刷新
 */
- (void)endFooterRefresh;

/**
 没有数据结束刷新
 */
- (void)endFooterNoMoreData;
/**
 处理滚动时图的insets
 */
-(void)handleScrollIndicatorInsets;
@end

NS_ASSUME_NONNULL_END
