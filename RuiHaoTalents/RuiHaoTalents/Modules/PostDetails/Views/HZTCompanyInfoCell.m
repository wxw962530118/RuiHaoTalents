//
//  HZTCompanyInfoCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCompanyInfoCell.h"

@interface HZTCompanyInfoCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

@implementation HZTCompanyInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImgView.layer.cornerRadius = 55/2;
    self.iconImgView.layer.masksToBounds = true;
}

-(void)setTitle:(NSString *)title desc:(NSString *)desc imageUrl:(NSString *)imageUrl{
    self.titleLabel.text = title;
    self.descLabel.text = desc;
}

@end
