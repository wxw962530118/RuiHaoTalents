//
//  HZTMyWalletDetailCell.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/25.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTMyWalletDetailCell.h"

@interface HZTMyWalletDetailCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation HZTMyWalletDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    [self addTitleLabel];
    [self addDateLabel];
    [self addMoneyLabel];
}

- (void)addTitleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"退款";
        _titleLabel.font = HZTFontSize(17);
        _titleLabel.textColor = [UIColor dark];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.contentView).offset(20);
        }];
    }
}

- (void)addDateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = @"2018-12-02 19:52:05";
        _dateLabel.font = HZTFontSize(12);
        _dateLabel.textColor = [UIColor colorWithHexString:@"#ABABAB"];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView).offset(11);
            make.left.equalTo(self.contentView).offset(20);
        }];
    }
}

- (void)addMoneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = @"+96.04";
        _moneyLabel.font = HZTFontSizeBold(20);
        _moneyLabel.textColor = [UIColor colorWithHexString:@"#4AD3C3"];
        [self.contentView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-20);
        }];
    }
}

@end
