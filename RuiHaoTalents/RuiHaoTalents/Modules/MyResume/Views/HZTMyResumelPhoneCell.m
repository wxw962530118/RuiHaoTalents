//
//  HZTMyResumelPhoneCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/17.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumelPhoneCell.h"


@interface HZTMyResumelPhoneCell ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation HZTMyResumelPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setListModel:(HZTMyResumeListModel *)listModel{
    _listModel = listModel;
    self.phoneLabel.text = listModel.humanPhone;
}

@end
