//
//  HZTTagViewCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTTagViewCell.h"

@interface HZTTagViewCell ()
/***/
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation HZTTagViewCell
+ (instancetype)creatListCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)path{
    HZTTagViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HZTTagViewCell" forIndexPath:path];
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
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = HZTFontSize(15);
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
}

-(void)setModel:(HZTTagViewModel *)model{
    _model = model;
    _titleLabel.text = model.name;
    self.backgroundColor = model.isSelected ? HZTMainColor : model.bgColor;
    self.layer.borderColor = model.isSelected ? HZTClearColor.CGColor : RGBColor(231, 231, 231).CGColor;
    _titleLabel.textColor = model.isSelected ? HZTColorWhiteGround : RGBColor(102, 102, 102);
}

@end
