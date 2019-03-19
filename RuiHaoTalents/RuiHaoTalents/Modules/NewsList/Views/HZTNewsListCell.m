//
//  HZTNewsListCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/19.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTNewsListCell.h"

@interface HZTNewsListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation HZTNewsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.redView.layer.cornerRadius = 3;
}

-(void)setModel:(HZTNewsListModel *)model{
    _model = model;
    self.iconImgView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    self.stateLabel.hidden = !model.isShowState;
    self.timeLabel.text = model.createTime;
    self.stateLabel.text = model.stateName;
    self.stateLabel.textColor = model.stateColor;
}

@end
