//
//  HZTDatePickerView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/22.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTDatePickerView.h"

@interface HZTDatePickerView ()
/**箭头*/
@property (nonatomic, strong) UIView * toolView;
/**透明背景*/
@property (nonatomic, strong) UIButton * blackCoverView;
/**选择时间的回调*/
@property (nonatomic, copy) void (^Block)(NSDate *date);
/**时间选择器*/
@property (nonatomic, strong) UIDatePicker *datePicker;
/**高斯模糊*/
@property (nonatomic, strong) UIVisualEffectView * effectView;
/**时间选择器的默认时间*/
@property (nonatomic, strong) NSDate *defaultDate;
/**时间选择器的最小可选时间*/
@property (nonatomic, strong) NSDate *minDate;
/**时间选择器的最大可选时间*/
@property (nonatomic, strong) NSDate *maxDate;
/***/
@property (nonatomic, strong) NSString * title;
@end

@implementation HZTDatePickerView

+(instancetype)showDatePickerViewWithFrame:(CGRect)frame title:(NSString *)title defaultDate:(NSDate *)defaultDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate callBack:(void (^)(NSDate * date))callBack{
    HZTDatePickerView * view = [[HZTDatePickerView alloc] initDatePickerViewWithFrame:frame title:title defaultDate:defaultDate minDate:minDate maxDate:maxDate callBack:callBack];
    return view;
}

-(instancetype)initDatePickerViewWithFrame:(CGRect)frame title:(NSString *)title defaultDate:(NSDate *)defaultDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate callBack:(void (^)(NSDate *date))callBack{
    if (self = [super initWithFrame:frame]){
        self.title = title;
        self.Block = callBack;
        self.minDate = minDate;
        self.maxDate = maxDate;
        self.defaultDate = defaultDate;
        [self addBlackCoverView];
        [self addWhiteView];
        [self addEffectView];
        [self addToolView];
        [self addDatePicker];
        [self configDateInfo];
        [self autoShowPickerView];
    }
    return self;
}

-(void)autoShowPickerView{
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:.3f animations:^{
        _blackCoverView.backgroundColor = RGBColorAlpha(0, 0, 0,.2f);
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.superview.mas_bottom).offset(0);
        }];
        [self.superview layoutIfNeeded];
    }];
}

-(void)addEffectView{
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        [self addSubview:_effectView];
        [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        _effectView.layer.cornerRadius = 10;
        _effectView.layer.masksToBounds = true;
        [self insertSubview:_effectView atIndex:0];
    }
}

-(void)addWhiteView{
    self.backgroundColor = RGBColor(255, 255, 255);
    [[ToolBaseClass getRootWindow] addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.superview.mas_bottom).offset(207);
        make.centerX.equalTo(self.superview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 217));
    }];
}

-(void)addToolView{
    if (!_toolView) {
        _toolView = [[UIView alloc]init];
        _toolView.backgroundColor = HZTColorWhiteGround;
        [self addSubview:_toolView];
        [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(40);
        }];
    }
    [self addCancelBtn];
}
-(void)addCancelBtn{
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.textColor = RGBColor(216, 216, 216);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.toolView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.toolView.mas_centerX);
        make.centerY.equalTo(self.toolView.mas_centerY);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = HZTColorComponentLine;
    [self.toolView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.toolView);
        make.height.mas_equalTo(.7);
    }];
    
    NSArray * imagesArray = @[@"picker_cancel_icon",@"picker_sure_icon"];
    for (int i = 0; i < imagesArray.count; i++) {
        UIButton * btn = [[UIButton alloc]init];
        btn.tag = 1000 + i;
        [btn setImage:[UIImage imageNamed:imagesArray[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.toolView.mas_centerY);
            make.size.mas_equalTo(!i ? CGSizeMake(15, 15) : CGSizeMake(18, 13));
            if (!i) {
                make.left.equalTo(self.mas_left).offset(20);
            }else{
                make.right.equalTo(self.mas_right).offset(-20);
            }
        }];
    }
}

-(void)addDatePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:_datePicker];
        [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.mas_top).offset(40);
        }];
    }
}

-(void)addBlackCoverView{
    if (!_blackCoverView) {
        _blackCoverView = [[UIButton alloc] init];
        _blackCoverView.backgroundColor = RGBColorAlpha(0, 0, 0,0);
        [_blackCoverView addTarget:self action:@selector(clickCoverView) forControlEvents:UIControlEventTouchUpInside];
        [[ToolBaseClass getRootWindow] addSubview:_blackCoverView];
        [_blackCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_blackCoverView.superview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

-(void)configDateInfo{
    if (self.minDate) {
        self.datePicker.minimumDate = self.minDate;
    }
    if (self.maxDate) {
        self.datePicker.maximumDate = self.maxDate;
    }else {
        self.datePicker.maximumDate = [NSDate date];
    }
    
    if (_defaultDate) {
        self.datePicker.date = _defaultDate;
    }
}

-(void)clickCoverView{
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:.3f animations:^{
        _blackCoverView.backgroundColor = RGBColorAlpha(0, 0, 0,0);
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.superview.mas_bottom).offset(207);
        }];
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [_blackCoverView removeFromSuperview];
        [self removeFromSuperview];
    }];

}

-(void)selectBtn:(UIButton *)sender{
    if (sender.tag - 1000){
        NSLog(@"当前选择的时间:%@",_datePicker.date);
        [self clickCoverView];
        if (self.Block) {
            self.Block(_datePicker.date);
        }
    }else{
        [self clickCoverView];
    }
}

@end
