//
//  HZTLoginRegisterCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTLoginRegisterCell.h"

@interface HZTLoginRegisterCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton * getCodeBtn;
@property(nonatomic,assign)NSTimeInterval currentInterval;

@property(nonatomic,assign)NSTimeInterval startInterval;

@property (nonatomic,strong) NSTimer * timer;

@end

@implementation HZTLoginRegisterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.textField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

-(void)setModel:(HZTLoginRegisterModel *)model{
    _model = model;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (![model.placeholder isEqualToString:@"请输入8-16位密码"]) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        self.textField.secureTextEntry = true;
    }
    self.iconImgView.image = [UIImage imageNamed:model.iconName];
    self.textField.placeholder = model.placeholder;
    self.getCodeBtn.hidden = !model.isShowGetCode;
    [self.getCodeBtn setTitleColor:HZTMainColor forState:UIControlStateNormal];
    if (![ToolBaseClass isNullClass:model.phone] && [model.placeholder isEqualToString:@"请输入手机号码"]) {
        self.textField.text = model.phone;
    }if (![ToolBaseClass isNullClass:model.password] && [model.placeholder isEqualToString:@"请输入8-16位密码"]) {
        self.textField.text = model.password;
    }
}

- (IBAction)clickGetCodeBtn:(id)sender {
    if (self.getCodeBtnCallBack) {
        self.getCodeBtnCallBack();
    }
}

#pragma mark --- 获取验证码成功
-(void)getCodeSucceed{
    self.getCodeBtn.enabled = NO;
    self.startInterval = [[NSDate date] timeIntervalSince1970];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark --- 定时器倒计时
-(void)countDown{
    self.currentInterval = [[NSDate date] timeIntervalSince1970];
    int leftTime = 60 - (self.currentInterval-self.startInterval);
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"剩余%lds",(long)leftTime] forState:UIControlStateNormal];
    if(leftTime <= 0){
        [self.timer invalidate];
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getCodeBtn.enabled = YES;
    }
}

-(void)destroyTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)textFieldDidChange{
    if (self.textChangedBlock) {
        if ([self.textField.placeholder isEqualToString:@"请输入验证码"] && self.textField.text.length > 6) {
            [MBProgressHUD showError:@"验证码最多不超过6位"];
            self.textField.text = [self.textField.text substringToIndex:6];
        }else if([self.textField.placeholder isEqualToString:@"请输入手机号码"] && self.textField.text.length > 11){
            [MBProgressHUD showError:@"手机号码最多不超过11位"];
            self.textField.text = [self.textField.text substringToIndex:11];
        }
        [self.textLabel resignFirstResponder];
        self.textChangedBlock(self.textField.text,self.textField.placeholder);
    }
}

@end
