//
//  HZTMyResumeLevelCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/17.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeLevelCell.h"

@interface HZTMyResumeLevelCell ()
@property (weak, nonatomic) IBOutlet UIButton *expendBtn;

@end

@implementation HZTMyResumeLevelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)clickExpendBtn:(id)sender {
    if (self.Block) {
        self.Block();
    }
}

-(void)setIsExpend:(BOOL)isExpend{
    _isExpend = isExpend;
    [self.expendBtn setTitle:isExpend ? @"收起" : @"展开" forState:UIControlStateNormal];
}

@end
