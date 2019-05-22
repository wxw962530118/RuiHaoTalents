//
//  HZTProjectExperienceCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTProjectExperienceCell.h"
#import "HZTWorkExperienceView.h"
@interface HZTProjectExperienceCell ()
/***/
@property (nonatomic, strong) UIView * workSuperView;
/***/
@property (nonatomic, strong) NSMutableArray <HZTWorkExperienceView *>* viewsArr;
@end

@implementation HZTProjectExperienceCell

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
        [btn setTitle:@"添加项目经历" forState:UIControlStateNormal];
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

#pragma mark --- 卡片view的点击事件
-(void)clickView:(UITapGestureRecognizer *)ges{
    UIView * view = [ges view];
    /**取出 index*/
    NSInteger index = view.tag - 1000;
    /**通过index 取数据源取模型 block 回调到控制器*/
    HZTProjiectModel * model = self.projectArr[index];
    NSLog(@"projectName:%@",model.projectName);
}

#pragma mark --- 数据源赋值
-(void)setProjectArr:(NSArray<HZTProjiectModel *> *)projectArr{
    _projectArr = projectArr;
    if (self.viewsArr.count && self.viewsArr.count == projectArr.count) {
        return;
    }else{
        for (HZTWorkExperienceView * view in self.viewsArr) {
            [view removeFromSuperview];
        }
        for (int i = 0; i< projectArr.count; i++) {
            HZTWorkExperienceView * view = [HZTWorkExperienceView createWorkExperienceView];
            view.projectModel = projectArr[i];
            view.tag = 1000 + i;
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)]];
            view.layer.cornerRadius = 5;
            [_workSuperView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_workSuperView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(343, projectArr[i].cardHeight));
                make.top.equalTo(_workSuperView.mas_top).offset(!i ? 15 : (i*(projectArr[i].cardHeight + 7) +15));
            }];
        }
    }
}

@end
