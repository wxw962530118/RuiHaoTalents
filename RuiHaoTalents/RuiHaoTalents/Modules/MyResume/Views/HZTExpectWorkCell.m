//
//  HZTExpectWorkCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTExpectWorkCell.h"
#import "HZTCardTypeView.h"

@interface HZTExpectWorkCell ()
/***/
@property (nonatomic, strong) UIView * cardSuperView;
@end

@implementation HZTExpectWorkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addCardSuperView];
}

-(void)addCardSuperView{
    if (!_cardSuperView) {
        _cardSuperView = [[UIView alloc] init];
        [self.contentView addSubview:_cardSuperView];
        [_cardSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.contentView);
        }];
        for (int i = 0; i< 3; i++) {
            HZTCardTypeView * view = [HZTCardTypeView createCardTypeView];
            view.layer.cornerRadius = 5;
            view.layer.masksToBounds = NO;
            [_cardSuperView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_cardSuperView.mas_centerX);
                make.top.equalTo(_cardSuperView.mas_top).offset(!i ? 16 : (i*(41+7) + 16));
                make.size.mas_equalTo(CGSizeMake(kScreenW - 32, 41));
            }];
        }
    }
}

@end
