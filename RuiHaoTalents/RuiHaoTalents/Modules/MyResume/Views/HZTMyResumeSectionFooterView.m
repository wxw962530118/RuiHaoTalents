//
//  HZTMyResumeSectionFooterView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeSectionFooterView.h"

@interface HZTMyResumeSectionFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
/***/
@property (nonatomic, copy) void (^Block)(NSString * title);
@end

@implementation HZTMyResumeSectionFooterView


+(instancetype)createMyResumeSectionFooterViewWithTitle:(NSString *)title callBack:(void (^)(NSString *title))callBack{
    HZTMyResumeSectionFooterView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTMyResumeSectionFooterView" owner:nil options:nil] lastObject];
    view.Block = callBack;
    [view.addButton setTitle:title forState:UIControlStateNormal];
    return view;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.clipsToBounds = YES;
    self.addButton.clipsToBounds = YES;
}

- (IBAction)clickAddBtn:(id)sender {
    if (self.Block) {
        self.Block(self.addButton.currentTitle);
    }
}

@end
