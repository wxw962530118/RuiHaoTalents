//
//  HZTTopTabCollectionCell.m
//  KidsEvaluation
//
//  Created by 王新伟 on 2018/12/17.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import "HZTTopTabCollectionCell.h"

@interface HZTTopTabCollectionCell()
/**名称*/
@property (nonatomic, strong) UILabel * titleLabel;
/**底部指示器*/
@property (nonatomic, strong) UIView * lineView;
/**图片*/
@property (nonatomic, strong) UIImageView * imgView;
/***/
@property (nonatomic, strong) UILabel * messageCntLabel;
@end

@implementation HZTTopTabCollectionCell

+ (instancetype)creatListCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)path{
    HZTTopTabCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HZTTopTabCollectionCell" forIndexPath:path];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadCompents];
    }
    return self;
}

-(void)loadCompents{
    [self addImgView];
    [self addMessageCntLabel];
    [self addTitleLabel];
    [self addLineView];
}

-(void)addImgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(31, 31));
        }];
    }
}

-(void)addMessageCntLabel{
    if (!_messageCntLabel) {
        _messageCntLabel = [[UILabel alloc] init];
        _messageCntLabel.layer.cornerRadius = 8;
        _messageCntLabel.layer.masksToBounds = true;
        _messageCntLabel.backgroundColor = RGBColorAlpha(255, 79, 29,1);
        _messageCntLabel.font = HZTFontSize(14);
        _messageCntLabel.textColor = HZTColorWhiteGround;
        _messageCntLabel.textAlignment = NSTextAlignmentCenter;
        [_imgView addSubview:_messageCntLabel];
        [_messageCntLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(16);
            make.left.equalTo(_imgView.mas_right).offset(-8);
            make.bottom.equalTo(_imgView.mas_top).offset(13);
        }];
    }
}

-(void)addLineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HZTMainColor;
        _lineView.layer.cornerRadius = 2;
        _lineView.layer.masksToBounds = true;
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(4);
        }];
    }
}

-(void)addTitleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = RGBColorAlpha(0, 0, 0, .54);
        _titleLabel.font = HZTFontSize(16);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
}

-(void)setModel:(HZTTopTabModel *)model{
    _model = model;
    _lineView.hidden = !model.isSelectd;
    _titleLabel.text = model.title;
    _imgView.image = [UIImage imageNamed:model.imageName];
    _imgView.hidden = [ToolBaseClass isNullClass:model.imageName];
    _messageCntLabel.hidden = !model.messageCnt;
    _messageCntLabel.text = [NSString stringWithFormat:@"%ld",model.messageCnt];
    [_messageCntLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake([ToolBaseClass getWidthWithString:_messageCntLabel.text font:_messageCntLabel.font] + 10,16));
    }];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset([ToolBaseClass isNullClass:model.imageName] ? 0 : 20);
    }];
}

@end
