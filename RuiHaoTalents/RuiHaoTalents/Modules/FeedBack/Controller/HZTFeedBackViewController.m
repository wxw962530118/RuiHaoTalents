//
//  HZTFeedBackViewController.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/22.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTFeedBackViewController.h"

@interface HZTFeedBackViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation HZTFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self addSubviews];
}

#pragma mark --- private

- (void)setupNav {
    self.navigationItem.title = @"反馈与建议";
}

- (void)addSubviews {
    self.view.backgroundColor = HZTColorBackGround;

    [self addTextView];
}


#pragma mark --- 懒加载相关

- (void)addTextView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        
    }
}

@end
