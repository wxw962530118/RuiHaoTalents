//
//  HZTExpectJobViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTExpectJobViewController.h"
#import "HZTChoosePostController.h"
@interface HZTExpectJobViewController ()
@property (weak, nonatomic) IBOutlet UILabel *choosePostLabel;
@property (weak, nonatomic) IBOutlet UILabel *choosePayLabel;
@property (nonatomic, copy) void (^Block)(NSString * postName,NSString *payName,NSString *payId,NSString * personIndustry,NSString *personFunction);
@property (nonatomic, copy) NSString * expectJobName;
@property (nonatomic, copy) NSString * payName;
@property (nonatomic, copy) NSString * secondId;
@property (nonatomic, copy) NSString * thirdId;
@property (nonatomic, copy) NSString * payId;
@end

@implementation HZTExpectJobViewController

-(instancetype)initWithExpectJobName:(NSString *)expectJobName payName:(NSString *)payName callBack:(void (^)(NSString * _Nonnull, NSString * _Nonnull,NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))callBack{
    if (self = [super init]) {
        self.Block         = callBack;
        self.payName       = [ToolBaseClass isNullClass:payName]  ? @"请选择期望薪资": payName;
        self.expectJobName = [ToolBaseClass isNullClass:expectJobName] ? @"请选择期望职位": expectJobName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"期望工作";
    self.choosePayLabel.text = self.payName;
    self.choosePostLabel.text = self.expectJobName;
    [self addSelectors];
}

-(void)addSelectors{
    [self.choosePostLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChoosePost)]];
    [self.choosePayLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChoosePay)]];

}

#pragma mark --- 选择期望职位
-(void)clickChoosePost{
    WS(weakSelf)
    HZTChoosePostController * vc = [[HZTChoosePostController alloc] init];
    vc.callBack = ^(NSString * _Nonnull secondId, NSString * _Nonnull thirdId, NSString * _Nonnull thirdName) {
        weakSelf.thirdId = thirdId;
        weakSelf.secondId = secondId;
        weakSelf.choosePostLabel.text = thirdName;
    };
    [self xw_pushViewController:vc animated:YES];
}

#pragma mark --- 选择期望薪资
-(void)clickChoosePay{
    WS(weakSelf)
    [HZTToastHUD showLoading];
    [[HZTOthersNetWorkManager manager] requestPayListWithId:@"37" succeed:^(id  _Nonnull responseObject) {
        [HZTToastHUD hideLoading];
        NSMutableArray * namesArray = [NSMutableArray array];
        NSMutableArray * idsArray = [NSMutableArray array];
        NSArray * arr = responseObject[@"content"];
        for (int i = 0; i< arr.count; i++) {
            NSDictionary * dict = arr[i];
            [namesArray addObject:dict[@"name"]];
            [idsArray addObject:dict[@"id"]];
        }
        if (!namesArray.count) {
            [HZTToastHUD showNormalWithTitle:@"暂无薪资信息"];
            return ;
        }
        [HZTCustomPickerView showPickerViewWithTitle:@"薪资要求(月薪,单位:千元)" dataArray:@[namesArray] callBack:^(HZTCustomPickerModel * _Nonnull model) {
            NSInteger index = [namesArray indexOfObject:model.name];
            weakSelf.choosePayLabel.text = model.name;
            weakSelf.payId = idsArray[index];
            NSLog(@"选择结果%@-%@",model.name,idsArray[index]);
        }];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark --- 选择完成
- (IBAction)clickCompelete:(id)sender {
    if ([self.choosePostLabel.text isEqualToString:@"请选择期望职位"] && [self.choosePayLabel.text isEqualToString:@"请选择期望薪资"]) {
        [HZTToastHUD showNormalWithTitle:@"请选择期望职位和薪资"];
        return;
    }else if([self.choosePostLabel.text isEqualToString:@"请选择期望职位"]){
        [HZTToastHUD showNormalWithTitle:@"请选择期望职位"];
        return;
    }else if([self.choosePayLabel.text isEqualToString:@"请选择期望薪资"]){
        [HZTToastHUD showNormalWithTitle:@"请选择期望薪资"];
        return;
    }
    if (self.Block) {
        self.Block(self.choosePostLabel.text,self.payName,self.payId,self.secondId,self.thirdId);
    }
    [self xw_popViewController:nil animated:YES];
}

@end
