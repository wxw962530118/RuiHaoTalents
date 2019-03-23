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
}

-(void)setModel:(HZTImmediateMatchModel *)model{
    _model = model;
    self.titleLabel.text = model.jobPosition;
    self.payCountLabel.text = [NSString stringWithFormat:@"%@-%@",model.fullPayStartName,model.fullPayEndName];
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.personJobEnterVO.enterLogo] placeholderImage:[ToolBaseClass imageWithColor:HZTMainColor]];
    self.companyNameLabel.text = model.personJobEnterVO.enterName;
    self.companyInfoLabel.text = [NSString stringWithFormat:@"%@|%@人|%@",model.personJobEnterVO.enterNatureName,model.personJobEnterVO.enterFinancName,@"移动互联网"];
}

@end
