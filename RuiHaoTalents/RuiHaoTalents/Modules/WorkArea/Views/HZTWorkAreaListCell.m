//
//  HZTWorkAreaListCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTWorkAreaListCell.h"
@interface HZTWorkAreaListCell ()

/***/
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation HZTWorkAreaListCell
+ (instancetype)creatListCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)path{
    HZTWorkAreaListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HZTWorkAreaListCell" forIndexPath:path];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = true;
        [self addTitleLabel];
    }
    return self;
}

-(void)addTitleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = HZTFontSize(15);
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
}

-(void)setModel:(HZTWorkAreaModel *)model{
    _model = model;
    _titleLabel.text = model.name;
    self.backgroundColor = model.isSelected ? HZTMainColor : [UIColor whiteColor];
    self.layer.borderColor = model.isSelected ? HZTClearColor.CGColor : RGBColor(231, 231, 231).CGColor;
    _titleLabel.textColor = model.isSelected ? HZTColorWhiteGround : RGBColor(102, 102, 102);
}

@end
