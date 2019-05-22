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
/***/
@property (nonatomic, strong) NSMutableArray <HZTWorkExperienceView *>* viewsArr;
@end

@implementation HZTWorkTrainCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = HZTMainColor;
    [self addWorkSuperView];
}

-(NSMutableArray *)viewsArr{
    if (!_viewsArr) {
        _viewsArr = [NSMutableArray array];
    }
    return _viewsArr;
}

-(void)addWorkSuperView{
    if (!_workSuperView) {
        _workSuperView = [[UIView alloc] init];
        [self.contentView addSubview:_workSuperView];
        [_workSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.contentView);
        }];
    
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

-(void)setResumeArr:(NSArray<HZTResumeModel *> *)resumeArr{
    _resumeArr = resumeArr;
    if (self.viewsArr.count && self.viewsArr.count == resumeArr.count) {
        return;
    }else{
        for (HZTWorkExperienceView * view in self.viewsArr) {
            [view removeFromSuperview];
        }
        for (int i = 0; i< resumeArr.count; i++) {
            HZTWorkExperienceView * view = [HZTWorkExperienceView createWorkExperienceView];
            [self.viewsArr addObject:view];
            view.layer.cornerRadius = 5;
            view.model = resumeArr[i]; 
            [_workSuperView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_workSuperView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(343, resumeArr[i].cardHeight));
                make.top.equalTo(_workSuperView.mas_top).offset(!i ? 15 : (i*(resumeArr[i].cardHeight + 7) +15));
            }];
        }
    }
}

@end
