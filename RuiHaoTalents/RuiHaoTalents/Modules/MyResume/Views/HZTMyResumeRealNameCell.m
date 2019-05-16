//
//  HZTMyResumeRealNameCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeRealNameCell.h"

@implementation HZTMyResumeRealNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = YES;
}

- (IBAction)clickRealName:(id)sender {
    NSLog(@"去实名认证");
    if(self.clickRealNameBlock){
        self.clickRealNameBlock();
    }
}

@end
