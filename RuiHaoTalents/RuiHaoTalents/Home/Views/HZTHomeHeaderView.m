//
//  HZTHomeHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTHomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "HZTPageControl.h"
#import "HZTWorkAreaViewController.h"
#import "HZTDatePickerView.h"
@interface HZTHomeHeaderView ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView * cycleView;
/***/
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
/***/
@property (nonatomic, strong) HZTPageControl * pageControl;
/***/
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
/***/
@property (weak, nonatomic) IBOutlet UILabel *startMouthLabel;
/***/
@property (weak, nonatomic) IBOutlet UILabel *startYearLabel;
/***/
@property (weak, nonatomic) IBOutlet UILabel *endMouthLabel;
/***/
@property (weak, nonatomic) IBOutlet UILabel *endYearLabel;
/***/
@property (weak, nonatomic) IBOutlet UILabel *arriveTimeLabel;
/***/
@property (weak, nonatomic) IBOutlet UILabel *expectJobLabel;
/***/
@property (strong ,nonatomic) NSArray * localImageArr;
/**记录选择的开始时间*/
@property (strong ,nonatomic) NSDate * startDate;
/**记录选择的结束时间*/
@property (strong ,nonatomic) NSDate * endDate;
@end

@implementation HZTHomeHeaderView

+(instancetype)createHomeHeaderView{
    HZTHomeHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTHomeHeaderView" owner:nil options:nil] lastObject];
    view.clipsToBounds = YES;
    return view;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self configInfo];
    [self addGestureRecognizers];
    [self configCycleInfo];
    [self createPageControl];
}

/**时间相关的初始化*/
-(void)configInfo{
    self.startDate = [NSDate date];
    self.endDate = [NSDate date];
    self.startYearLabel.text = [self handleDateToYearMouth:[NSDate date] isYear:YES];
    self.startMouthLabel.text = [self handleDateToYearMouth:[NSDate date] isYear:NO];
    self.endYearLabel.text = [self handleDateToYearMouth:[NSDate date] isYear:YES];
    self.endMouthLabel.text = [self handleDateToYearMouth:[NSDate date] isYear:NO];
    [self handleCalcDaysWithStartDate:[NSDate date] endDate:[NSDate date]];
}

-(void)addGestureRecognizers{
    [self.locationNameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAddress:)]];
    [self.expectJobLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickExpectJob:)]];
    [self.startYearLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickStartDate:)]];
    [self.startMouthLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickStartDate:)]];
    [self.endMouthLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEndDate:)]];
    [self.endYearLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEndDate:)]];
}

-(void)configCycleInfo{
    self.localImageArr = @[@"IMG_01",@"IMG_02"];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW,147) delegate:self placeholderImage:nil];
    self.cycleScrollView.localizationImageNamesGroup = self.localImageArr;
    [self.cycleView addSubview:self.cycleScrollView];
    self.cycleScrollView.showPageControl = false;
}

#pragma mark --- HZTPageControl 自定义分页控件
- (void)createPageControl{
    _pageControl = [[HZTPageControl alloc]initWithPageCount:self.localImageArr.count type:HZTPageControlType_rectangle pageContrlSize:CGSizeMake(10,10)];
    [self.cycleView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth - 10);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.cycleView.mas_bottom);
        make.right.equalTo(self.cycleView.mas_right);
    }];
    _pageControl.pageSpace = 20;
    _pageControl.currentPageNumber = 0;
    _pageControl.selectedColor = HZTMainColor;
    _pageControl.pageBackgroundColor = RGBColorAlpha(0, 0, 0, 0.2);
    _pageControl.isShowBorder = NO;
}

#pragma mark --- 成为伯乐
- (IBAction)clickJoinTalent:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickJoinTalent:)]) {
        [self.delegate clickJoinTalent:self];
    }
}

#pragma mark --- 我是伯乐
- (IBAction)clickImTalent:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickImTalent:)]) {
        [self.delegate clickImTalent:self];
    }
}

#pragma mark --- 扫一扫
- (IBAction)clickScan:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickScan:)]) {
        [self.delegate clickScan:self];
    }
}

#pragma mark --- 求职安全
- (IBAction)clickSecurity:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickSecurity:)]) {
        [self.delegate clickSecurity:self];
    }
}

#pragma mark --- 立即匹配
- (IBAction)clickImmediateMatch:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickImmediateMatch:)]) {
        [self.delegate clickImmediateMatch:self];
    }
}

#pragma mark --- 工作区域
-(void)clickAddress:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(clickWorkArea:)]) {
        [self.delegate clickWorkArea:self];
    }
}

#pragma mark --- 期望工作
-(void)clickExpectJob:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(clickExpectJob:expectJobLabel:)]) {
        [self.delegate clickExpectJob:self expectJobLabel:self.expectJobLabel];
    }
}

#pragma mark --- 选择到岗开始时间
-(void)clickStartDate:(UITapGestureRecognizer *)tap{
   [self showDatePickerViewWithStartTime:YES];
}

#pragma mark --- 选择到岗结束时间
-(void)clickEndDate:(UITapGestureRecognizer *)tap{
    [self showDatePickerViewWithStartTime:NO];
}

-(void)showDatePickerViewWithStartTime:(BOOL)isStartTime{
    WS(weakSelf)
    [HZTDatePickerView showDatePickerViewWithFrame:CGRectZero title:@"请选择您期望的到岗时间" defaultDate:isStartTime ? self.startDate : self.endDate minDate:self.startDate maxDate:[ToolBaseClass getPriousorLaterDateFromDate:self.startDate withMonth:12] callBack:^(NSDate * _Nonnull date) {
        if (isStartTime) {
            weakSelf.startDate = date;
            weakSelf.endDate = date;
            weakSelf.startYearLabel.text = [weakSelf handleDateToYearMouth:date isYear:YES];
            weakSelf.startMouthLabel.text = [weakSelf handleDateToYearMouth:date isYear:NO];
            weakSelf.endYearLabel.text = weakSelf.startYearLabel.text;
            weakSelf.endMouthLabel.text = weakSelf.startMouthLabel.text;
            [weakSelf handleCalcDaysWithStartDate:weakSelf.startDate endDate:weakSelf.endDate];
        }else{
            weakSelf.endDate = date;
            weakSelf.endYearLabel.text = [weakSelf handleDateToYearMouth:date isYear:YES];
            weakSelf.endMouthLabel.text = [weakSelf handleDateToYearMouth:date isYear:NO];
            [weakSelf handleCalcDaysWithStartDate:weakSelf.startDate endDate:weakSelf.endDate];
        }
    }];
}

-(NSString *)handleDateToYearMouth:(NSDate *)date isYear:(BOOL)isYear{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:isYear ? @"yyyy年" : @"MM月dd日"];
    return [formatter stringFromDate:date];
}

-(void)handleCalcDaysWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    NSInteger days = [ToolBaseClass calcDaysFromBegin:startDate end:endDate];
    self.arriveTimeLabel.text = [NSString stringWithFormat:@"%ld天",days <= 1 ? 1 : days];
}

-(void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    self.locationNameLabel.text = cityName;
}

-(void)setEndTime:(NSString *)endTime{
    _endTime = endTime;
}

-(void)setStartTime:(NSString *)startTime{
    _startTime = startTime;
}

-(void)setArriveDay:(NSString *)arriveDay{
    _arriveDay = arriveDay;
}

-(void)setExpectJobName:(NSString *)expectJobName{
    _expectJobName = expectJobName;
    self.expectJobLabel.text = expectJobName;
    self.expectJobLabel.textColor = [expectJobName isEqualToString:@"您所期望的工作"] ? RGBColor(204, 204, 204) : RGBColor(51, 51, 51);
}

#pragma mark --- SDCycleScrollView图片点击回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

#pragma mark --- SDCycleScrollView图片滚动回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    _pageControl.currentPageNumber = index;
}

@end
