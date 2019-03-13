//
//  HZTPageControl.m
//  KidsEvaluation
//
//  Created by 王新伟 on 2019/1/17.
//  Copyright © 2019年 haizitong. All rights reserved.
//

#import "HZTPageControl.h"

@interface HZTPageControl()
/***/
@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, assign) HZTPageControlType pageType;
/***/
@property (nonatomic, assign) CGSize  pageContrlSize;
@end

@implementation HZTPageControl

-(instancetype)initWithPageCount:(NSInteger)pageCount type:(HZTPageControlType)type pageContrlSize:(CGSize )pageContrlSize{
    self = [super init];
    if (self) {
        self.pageType = type;
        self.pageCount = pageCount;
        self.pageContrlSize = pageContrlSize;
    }
    return self;
}

-(void)setPageSpace:(CGFloat)pageSpace{
    _pageSpace = pageSpace;
    switch (self.pageType) {
        case HZTPageControlType_default:{
            CGFloat pointWidth  = self.pageContrlSize.width;
            CGFloat pointHeight = self.pageContrlSize.height;
            CGFloat sunWidth = (_pageCount * pointWidth) +  (_pageCount - 1) * pageSpace;
            CGFloat imgX = (kScreenWidth - sunWidth)/2;
            UIImageView * imageView;
            for (NSInteger i = 0; i < _pageCount; i++) {
                imageView = [[UIImageView alloc] init];
                imageView.layer.borderWidth = 2.5;
                imageView.layer.cornerRadius = pointWidth / 2.0;
                imageView.layer.masksToBounds = YES;
                imageView.layer.borderColor = RGBColorAlpha(33, 33, 33,1).CGColor;
                [self addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(pointWidth, pointHeight));
                    make.centerY.equalTo(self);
                    make.left.equalTo(self).offset(imgX + (_pageSpace + pointWidth) * i);
                }];
            }
        }
            break;
        case HZTPageControlType_rectangle:{
            for (NSInteger i = 0; i < _pageCount; i++) {
                UIImageView * imageView = [[UIImageView alloc] init];
                imageView.layer.cornerRadius = 3.5;
                imageView.layer.masksToBounds = YES;
                imageView.tag = 1000 + i;
                [self addSubview:imageView];
                if (i==0) {
                    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(self);
                        make.width.mas_equalTo(21);
                        make.height.mas_equalTo(7);
                    }];
                }else if(i< _pageCount-1 && i>0){
                    UIImageView * temView = [self viewWithTag:1000 + i-1];
                    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(temView.mas_right).with.offset(6);
                        make.width.mas_equalTo(7);
                        make.height.mas_equalTo(7);
                        make.centerY.equalTo(self);
                    }];
                }else{
                    UIImageView * temView = [self viewWithTag:1000 + i-1];
                    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(temView.mas_right).with.offset(6);
                        make.width.mas_equalTo(7);
                        make.height.mas_equalTo(7);
                        make.centerY.equalTo(self);
                        make.right.equalTo(self).with.offset(-15);
                    }];
                }
            }
        }
            break;
        default:
            break;
    }
}

-(void)setCurrentPageNumber:(NSInteger)currentPageNumber{
    _currentPageNumber = currentPageNumber;
    if (self.subviews.count) {
        if (self.pageType == HZTPageControlType_default) {
            for (UIImageView * imageView in self.subviews) {
                imageView.backgroundColor = _pageBackgroundColor;
            }
            UIImageView * imageView = [self.subviews objectAtIndex:currentPageNumber];
            imageView.backgroundColor = _selectedColor;
        }else if (self.pageType == HZTPageControlType_rectangle){
            for (UIImageView *imageView in self.subviews) {
                imageView.backgroundColor = _pageBackgroundColor;
                [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(7);
                }];
                imageView.backgroundColor = _pageBackgroundColor;
            }
            UIImageView * imageView = [self.subviews objectAtIndex:currentPageNumber];
            imageView.backgroundColor = _selectedColor;
            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(21);
            }];
        }
    }
}

#pragma mark --- 设置背景颜色方法
-(void)setPageBackgroundColor:(UIColor *)pageBackgroundColor{
    _pageBackgroundColor = pageBackgroundColor;
    if (self.subviews.count != 0) {
        for (UIImageView *imageView in self.subviews) {
            imageView.backgroundColor = _pageBackgroundColor;
        }
        UIImageView *imageView = [self.subviews objectAtIndex:_currentPageNumber];
        imageView.backgroundColor = _selectedColor;
    }
}

#pragma mark --- 被选中的颜色
-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    if (self.subviews.count) {
        UIImageView *imageView = [self.subviews objectAtIndex:_currentPageNumber];
        imageView.backgroundColor = _selectedColor;
    }
}

-(void)setIsShowBorder:(BOOL)isShowBorder{
    _isShowBorder = isShowBorder;
    if (!isShowBorder) {
        if (self.subviews.count != 0) {
            for (UIImageView *imageView in self.subviews) {
                imageView.layer.borderWidth = .1f;
                imageView.layer.borderColor = [UIColor clearColor].CGColor;
            }
        }
    }
}

@end
