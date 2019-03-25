//
//  HZTMyWalletCell.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/25.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTMyWalletCell.h"

@interface HZTMyWalletCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *rightImgView;

@end

@implementation HZTMyWalletCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

- (void)setImg:(NSString *)imageName text:(NSString *)text {
    self.imgView.image = [UIImage imageNamed:imageName];
    self.contentLabel.text = text;
}

- (void)addSubviews {
    
    [self addImgView];
    [self addRightImgView];
    [self addContentLabel];
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(20);
        }];
    }
}

- (void)addContentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = HZTFontSize(16);
        _contentLabel.textColor = [UIColor dark];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(67);
        }];
    }
}

- (void)addRightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] init];
        _rightImgView.image = [UIImage imageNamed:@"default_arrow"];
        [self.contentView addSubview:_rightImgView];
        [_rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.size.mas_equalTo(CGSizeMake(6, 10));
        }];
    }
}

@end
