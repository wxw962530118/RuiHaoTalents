//
//  HZTFeedBackCell.m
//  RuiHaoTalents
//
//  Created by zhangshumeng on 2019/3/23.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTFeedBackCell.h"

@interface HZTFeedBackCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, copy) void(^callback)(void);

@end

@implementation HZTFeedBackCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    CGPoint tempPoint = [self.deleteBtn convertPoint:point fromView:self];
    if ([self.deleteBtn pointInside:tempPoint withEvent:event]) {
        return self.deleteBtn;
    }
    return view;
}

- (void)deleteBtnClick {
    if (self.callback) {
        self.callback();
    }
}

#pragma mark - private
- (void)addSubviews {
    [self addImgView];
    [self addDeleteBtn];
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.cornerRadius = 3.f;
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
}

- (void)addDeleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setImage:[UIImage imageNamed:@"default_delete"] forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
}

#pragma mark - public

- (void)setHiddenDeleteBtn:(BOOL)hiddenDeleteBtn {
    self.deleteBtn.hidden = hiddenDeleteBtn;
}

- (void)setImage:(UIImage *)image {
    self.imgView.image = image;
}

- (void)deleteBlock:(void (^)(void))callback {
    self.callback = callback;
}

@end
