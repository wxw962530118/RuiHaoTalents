//
//  HZTPostDetailsSectionView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTPostDetailsSectionView.h"

@interface HZTPostDetailsSectionView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@end

@implementation HZTPostDetailsSectionView

+(instancetype)createSectionView{
    HZTPostDetailsSectionView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTPostDetailsSectionView" owner:nil options:nil] lastObject];
    return view;
}

-(void)setTitle:(NSString *)title imageName:(NSString *)imageName{
    self.titleLabel.text = title;
    self.iconImgView.image = [UIImage imageNamed:imageName];
}

@end
