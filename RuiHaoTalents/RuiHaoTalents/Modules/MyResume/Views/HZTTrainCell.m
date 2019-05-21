//
//  HZTTrainCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/19.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTTrainCell.h"
#import "HZTEducationView.h"
@interface HZTTrainCell ()
/***/
@property (nonatomic, strong) UIView * educationSuperView;
@end

@implementation HZTTrainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = HZTMainColor;
    [self addEducationSuperView];
}

-(void)addEducationSuperView{
    if (!_educationSuperView) {
        _educationSuperView = [[UIView alloc] init];
        [self.contentView addSubview:_educationSuperView];
        [_educationSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.contentView);
        }];
        
        for (int i = 0; i< 2; i++) {
            HZTEducationView * view = [HZTEducationView createEducationView];
            view.layer.cornerRadius = 5;
            [_educationSuperView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_educationSuperView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(343, 90));
                make.top.equalTo(_educationSuperView.mas_top).offset(!i ? 15 : (i*(90 + 7) +15));
            }];
        }
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 344, 48)];
        [btn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
        btn.titleLabel.font = HZTFontSize(15);
        [btn setTitle:@"添加教育经历" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = RGBColor(255, 255, 255).CGColor;
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_educationSuperView.mas_centerX);
            make.bottom.equalTo(_educationSuperView.mas_bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(344, 48));
        }];
        
    }
}

//- (IBAction)clickMoreBtn:(id)sender {
//    if (self.callBack) {
//        self.lookMoreBtn.hidden = true;
//        self.callBack(TrainCallBackType_LookMore);
//    }
//}

-(void)setModel:(HZTTrainModel *)model{
    _model = model;
//    self.lookMoreBtn.hidden = !model.isShowMore;
//    self.schoolNameLabel.text = model.trainName;
//    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",model.trainStart,model.trainEnd];
//    self.specialNameLabel.text = model.trainMajor;
}

@end
