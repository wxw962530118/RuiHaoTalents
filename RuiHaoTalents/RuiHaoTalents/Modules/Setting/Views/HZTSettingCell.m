//
//  HZTSettingCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTSettingCell.h"

@interface HZTSettingCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HZTSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

@end
