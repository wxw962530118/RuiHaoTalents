//
//  UITableViewCell+HZTableViewCell.h
//  评价网络请求封装
//
//  Created by 王新伟 on 2018/5/15.
//  Copyright © 2018年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITableViewExpand <NSObject>

@optional
/**
 私有方法： 不允许外界去主动调用
 非Xib加载控件的代码 写在这里 */
- (void)loadWithComponents;

@end

@interface UITableViewCell (HZTableViewCell)<UITableViewExpand>

/**
 *  tableViewCell 构建方法
 *  必须使用 loadWithComponents 创建cell内的控件
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  tableViewCell 构建方法 XIB */
+ (instancetype)cellWithTableViewFromXIB:(UITableView *)tableView;

/**
 *  tableViewCell 赋值方法 */
- (void)setDataWithModel:(NSObject *)model;

/** tableViewCell 获取高度方法 */
+ (CGFloat)getCellHeightWithModel:(NSObject *)model;



@end
