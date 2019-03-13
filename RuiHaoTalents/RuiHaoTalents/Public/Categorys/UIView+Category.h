//
//  UIView+Category.h
//  评价网络请求封装
//
//  Created by 王新伟 on 2018/5/16.
//  Copyright © 2018年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

- (CGFloat)getWidth;
- (CGFloat)getHeight;
@end
