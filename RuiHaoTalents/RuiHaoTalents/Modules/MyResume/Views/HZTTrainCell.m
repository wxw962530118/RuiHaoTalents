//
//  HZTTrainCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/19.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTTrainCell.h"

@interface HZTTrainCell ()
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookMoreBtn;

@end

@implementation HZTTrainCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)clickMoreBtn:(id)sender {
    if (self.callBack) {
        self.lookMoreBtn.hidden = true;
        self.callBack(TrainCallBackType_LookMore);
    }
}

-(void)setModel:(HZTTrainModel *)model{
    _model = model;
    self.lookMoreBtn.hidden = !model.isShowMore;
    self.schoolNameLabel.text = model.trainName;
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",model.trainStart,model.trainEnd];
    self.specialNameLabel.text = model.trainMajor;
}

@end
