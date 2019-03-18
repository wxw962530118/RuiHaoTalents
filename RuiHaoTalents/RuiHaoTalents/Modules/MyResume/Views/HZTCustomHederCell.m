//
//  HZTCustomHederCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCustomHederCell.h"

@interface HZTCustomHederCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation HZTCustomHederCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (IBAction)clickAddBtn:(id)sender {
    
}

@end
