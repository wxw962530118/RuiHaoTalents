//
//  HZTMyResumeCustomCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeCustomCell.h"

@interface HZTMyResumeCustomCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookMoreBtn;

@end

@implementation HZTMyResumeCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (IBAction)clickLookMoreBtn:(id)sender {
    if (self.callBack) {
        self.lookMoreBtn.hidden = YES;
        self.callBack(MyResumeCellCallBackType_LookMore);
    }
}

- (IBAction)clickDeleteBtn:(id)sender {
    NSLog(@"删除");
    if (self.callBack) {
        self.callBack(MyResumeCellCallBackType_Delete);
    }
}

-(void)setResumeModel:(HZTResumeModel *)resumeModel{
    _resumeModel = resumeModel;
    self.titleLabel.text = resumeModel.resumeName;
    self.jobNameLabel.text = resumeModel.resumePosition;
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",resumeModel.startDate,resumeModel.endDate];
    self.descLabel.text = resumeModel.resumeDescribe;
    self.lookMoreBtn.hidden = !resumeModel.isShowMore;
}

-(void)setProjiectModel:(HZTProjiectModel *)projiectModel{
    _projiectModel = projiectModel;
    self.titleLabel.text = projiectModel.projectName;
    self.jobNameLabel.text = projiectModel.projectPost;
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",projiectModel.projectStart,projiectModel.projectEnd];
    self.descLabel.text = projiectModel.projectDescribe;
    self.lookMoreBtn.hidden = !projiectModel.isShowMore;
}

@end
