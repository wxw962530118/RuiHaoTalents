//
//  HZTWorkTrainCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTWorkTrainCell.h"
#import "HZTWorkExperienceView.h"

@interface HZTWorkTrainCell ()
/***/
@property (nonatomic, strong) UIView * workSuperView;
@end

@implementation HZTWorkTrainCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = HZTMainColor;
    [self addWorkSuperView];
}

-(void)addWorkSuperView{
    if (!_workSuperView) {
        _workSuperView = [[UIView alloc] init];
        [self.contentView addSubview:_workSuperView];
        [_workSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.contentView);
        }];
        
        for (int i = 0; i< 2; i++) {
            HZTWorkExperienceView * view = [HZTWorkExperienceView createWorkExperienceView];
            view.layer.cornerRadius = 5;
            [_workSuperView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_workSuperView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(343, 98));
                make.top.equalTo(_workSuperView.mas_top).offset(!i ? 15 : (i*(98 + 7) +15));
            }];
        }
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 344, 48)];
        [btn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
        btn.titleLabel.font = HZTFontSize(15);
        [btn setTitle:@"添加工作经历" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = RGBColor(255, 255, 255).CGColor;
        [_workSuperView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_workSuperView.mas_centerX);
            make.bottom.equalTo(_workSuperView.mas_bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(344, 48));
        }];
    }
}

@end
