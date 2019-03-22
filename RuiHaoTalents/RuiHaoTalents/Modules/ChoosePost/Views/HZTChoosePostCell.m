//
//  HZTChoosePostCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTChoosePostCell.h"

@interface HZTChoosePostCell ()
@property (weak, nonatomic) IBOutlet UILabel * titleLabel;

@end

@implementation HZTChoosePostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HZTChoosePostModel *)model{
    _model = model;
    self.titleLabel.text = model.name;
    self.titleLabel.textColor = model.isSelected ? HZTMainColor : RGBColor(51, 51, 51);
}

@end
