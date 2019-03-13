//
//  HZTMenuListCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMenuListCell.h"

@interface HZTMenuListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation HZTMenuListCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setModel:(HZTMenuListModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.iconImgView.image = [UIImage imageNamed:model.imageName];
}

@end
