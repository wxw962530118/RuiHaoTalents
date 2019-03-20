//
//  HZTImmediateMatchCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTImmediateMatchCell.h"

@interface HZTImmediateMatchCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *payCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation HZTImmediateMatchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImgView.layer.cornerRadius = 23;
    self.iconImgView.layer.masksToBounds = true;
    self.iconImgView.image = [ToolBaseClass imageWithColor:HZTMainColor];
}

@end
