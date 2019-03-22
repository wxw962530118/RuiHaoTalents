//
//  UILabel+TextHelper.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/22.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "UILabel+TextHelper.h"
#import "HZTTextHelper.h"
#import <objc/runtime.h>

NSString const *HZT_TapBlock = @"HZT_TapBlock";
NSString const *HZT_TextHelper = @"HZT_TextHelper";

@interface UILabel ()

@property (nonatomic,strong) HZTTextHelper *hzt_textHelper;

@end

@implementation UILabel (TextHelper)

- (void)setHzt_tapBlock:(void (^)(NSInteger, NSAttributedString *))ay_tapBlock {
    objc_setAssociatedObject(self, &HZT_TapBlock, ay_tapBlock, OBJC_ASSOCIATION_COPY);
    self.userInteractionEnabled = YES;
    HZTTextHelper *textHelper = [[HZTTextHelper alloc] init];
    self.hzt_textHelper = textHelper;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ay_tapAction:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void (^)(NSInteger, NSAttributedString *))hzt_tapBlock {
    return objc_getAssociatedObject(self, &HZT_TapBlock);
}

- (void)setHzt_textHelper:(HZTTextHelper *)hzt_textHelper {
    objc_setAssociatedObject(self, &HZT_TextHelper, hzt_textHelper, OBJC_ASSOCIATION_RETAIN);
}

- (HZTTextHelper *)hzt_textHelper {
    return objc_getAssociatedObject(self, &HZT_TextHelper);
}
#pragma mark -Event
- (void)ay_tapAction:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:recognizer.view];
    __weak UILabel *weakSelf = self;
    [self.hzt_textHelper selectorLocation:location label:(UILabel *)recognizer.view selectedBlock:^(NSInteger index, NSAttributedString *charAttributedString) {
        if (weakSelf.hzt_tapBlock) {
            weakSelf.hzt_tapBlock(index, charAttributedString);
        }
    }];
}

@end
