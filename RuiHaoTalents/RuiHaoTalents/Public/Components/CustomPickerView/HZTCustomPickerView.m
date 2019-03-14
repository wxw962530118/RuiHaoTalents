//
//  HZTCustomPickerView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCustomPickerView.h"
#import "HZTProvinceModel.h"
#import "HZTCityModel.h"
#import "HZTDistrictModel.h"

@interface HZTCustomPickerView ()
<UIPickerViewDataSource,UIPickerViewDelegate>
/***/
@property (nonatomic, copy) void (^Block)(HZTCustomPickerModel * model);
/***/
@property (nonatomic, copy) NSString * title;
/***/
@property (nonatomic, strong) NSMutableArray * dataArray;

@property(nonatomic, strong)  UIView *  supersView;

@property(nonatomic, strong)  UIPickerView * pickerView;
/**取消 确定按钮*/
@property (nonatomic, strong) UIView * toolView;
/***/
@property (nonatomic, strong) HZTCustomPickerModel * selectdModel;
@end

@implementation HZTCustomPickerView

+(instancetype)showPickerViewWithTitle:(NSString *)title dataArray:(NSArray *)dataArray callBack:(void (^)(HZTCustomPickerModel * _Nonnull))callBack{
    HZTCustomPickerView * view = [[HZTCustomPickerView alloc]initWithTitle:title dataArray:dataArray callBack:callBack];
    return view;
}

-(instancetype)initWithTitle:(NSString *)title dataArray:(NSArray *)dataArray callBack:(void (^)(HZTCustomPickerModel * _Nonnull))callBack{
    self = [super init];
    if (self) {
        self.title = title;
        self.selectdModel = [[HZTCustomPickerModel alloc]init];
        self.dataArray = [NSMutableArray arrayWithArray:dataArray];
        self.Block = callBack;
        [self loadComponents];
    }
    return self;
}

-(void)loadComponents{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = RGBColorAlpha(33, 33, 33, 0);
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideBgView)]];
    [[ToolBaseClass getRootWindow] addSubview:self];
    [self.supersView.superview layoutIfNeeded];
    [UIView animateWithDuration:.4f animations:^{
        self.backgroundColor = RGBColorAlpha(33, 33, 33, .6f);
        [self.supersView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.supersView.superview.mas_bottom);
        }];
        [self.supersView.superview layoutIfNeeded];
    }];
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
}

-(UIView *)supersView{
    if (!_supersView) {
        _supersView = [[UIView alloc]init];
        _supersView.backgroundColor = RGBColor(255, 255, 255);
        [self addSubview:_supersView];
        [_supersView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.supersView.superview.mas_bottom).offset((250));
            make.size.mas_equalTo(CGSizeMake(kScreenW,250));
        }];
        
        self.pickerView = [[UIPickerView alloc]init];
        self.pickerView.delegate = self;
        self.pickerView.backgroundColor = [UIColor whiteColor];
        self.pickerView.dataSource = self;
        [self.supersView addSubview:self.pickerView];
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.supersView);
            make.height.mas_equalTo((200));
        }];
        
        self.toolView = [[UIView alloc]init];
        self.toolView.backgroundColor = RGBColor(216, 216, 216);
        [self.supersView addSubview:self.toolView];
        [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.supersView);
            make.height.mas_equalTo((50));
        }];
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.toolView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.toolView.mas_centerX);
            make.centerY.equalTo(self.toolView.mas_centerY);
        }];
        [self createToolBtnWithTitlesArray:@[@"取消",@"确定"]];
    }
    return _supersView;
}

-(void)createToolBtnWithTitlesArray:(NSArray *)titlesArray{
    for (int i = 0; i < titlesArray.count; i++) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:titlesArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = HZTFontSize(17);
        [btn setTitleColor:RGBColor(33, 33, 33) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((35), (35)));
            make.centerY.equalTo(btn.superview);
            !i ? make.left.equalTo(btn.superview).offset((20)): make.right.equalTo(btn.superview).offset(-(20));
        }];
    }
}

-(void)clickBtn:(UIButton *)sender{
    if ([[sender currentTitle]isEqualToString:@"确定"]) {
        if (self.Block) {
            self.Block(self.selectdModel);
        }
        [self hideBgView];
    }else{
        [self hideBgView];
    }
}

-(void)hideBgView{
    [self.supersView.superview layoutIfNeeded];
    [UIView animateWithDuration:.4f animations:^{
        self.backgroundColor = RGBColorAlpha(33, 33, 33, 0);
        [self.supersView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.supersView.superview.mas_bottom).offset((250));
        }];
        [self.supersView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark --- pickView代理方法
/**返回一共有几列*/
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.dataArray.count == 1) {
        return [[self.dataArray firstObject]count];
    }else if (self.dataArray.count == 2){
        if (!component) {
            return [[self.dataArray firstObject]count];
        }else{
            return [[self.dataArray lastObject]count];
        }
    }else{
        if (component == 0) {
            return [[self.dataArray firstObject]count];
        }else  if (component == 1){
            return [self.dataArray[1] count];
        }else{
            return [[self.dataArray lastObject]count];
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.dataArray.count == 1) {
        return [[self.dataArray firstObject]objectAtIndex:row];
    }else if (self.dataArray.count == 2){
        if (!component) {
            return [[self.dataArray firstObject]objectAtIndex:row];
        }else{
            return [[self.dataArray lastObject]objectAtIndex:row];
        }
    }else{
        if (component == 0) {
            HZTProvinceModel * model = [[self.dataArray firstObject]objectAtIndex:row];
            return model.name;
        }else  if (component == 1){
            HZTCityModel * model = [self.dataArray[1] objectAtIndex:row];
            return model.name;
        }else{
            HZTDistrictModel * model = [[self.dataArray lastObject]objectAtIndex:row];
            return model.name;
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.dataArray.count == 1) {
        self.selectdModel.name = [[self.dataArray firstObject] objectAtIndex:row];
    }else if (self.dataArray.count == 2){
        
    }else{
        switch (component) {
            case 0:{
                HZTProvinceModel * provinceModel = [[self.dataArray firstObject]objectAtIndex:row];
                self.dataArray[1] = provinceModel.city;
                HZTCityModel * cityModel=[self.dataArray[1] objectAtIndex:0];
                self.dataArray[2] = cityModel.district;
                HZTDistrictModel * districtModel = [[self.dataArray lastObject] objectAtIndex:0];
                
                self.selectdModel.province_name = provinceModel.name;
                self.selectdModel.province_code = provinceModel.code;
                self.selectdModel.city_name = cityModel.name;
                self.selectdModel.city_code = cityModel.code;
                self.selectdModel.district_name = districtModel.name;
                self.selectdModel.district_code = districtModel.code;
                
                [self.pickerView reloadComponent:1];
                [self.pickerView selectRow:0 inComponent:1 animated:YES];
                [self.pickerView  reloadComponent:2];
                [self.pickerView selectRow:0 inComponent:2 animated:YES];
                
                break;
            }
            case 1:{
                HZTCityModel * cityModel =[self.dataArray[1] objectAtIndex:row];
                self.dataArray[2] = cityModel.district;
                self.selectdModel.city_name = cityModel.name;
                self.selectdModel.city_code = cityModel.code;
                HZTDistrictModel * districtModel = [[self.dataArray lastObject] objectAtIndex:0];
                self.selectdModel.district_name = districtModel.name;
                self.selectdModel.district_code = districtModel.code;
                [self.pickerView  reloadComponent:2];
                [self.pickerView  selectRow:0 inComponent:2 animated:YES];
                break;
            }
            case 2:{
                HZTCityModel * districtModel = [[self.dataArray lastObject] objectAtIndex:row];
                self.selectdModel.district_name = districtModel.name;
                self.selectdModel.district_code = districtModel.code;
                [self.pickerView selectRow:row inComponent:2 animated:YES];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark --- 返回pickerViewTitleView
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor blackColor];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setFont:HZTFontSize(18)];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

@end
