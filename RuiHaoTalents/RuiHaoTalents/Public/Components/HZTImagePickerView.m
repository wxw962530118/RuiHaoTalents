//
//  HZTImagePickerView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/22.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTImagePickerView.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "VPImageCropperViewController.h"
@interface HZTImagePickerView ()<ZLPhotoPickerBrowserViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/***/
@property (nonatomic, strong) VPImageCropperViewController * imageCropperController;
/***/
@property (nonatomic, copy) ImagePickerViewBlock Block;
/**从选择的最大数量*/
@property (nonatomic, assign) NSInteger maxCount;
/**拍照存储的照片*/
@property (nonatomic, strong) NSMutableArray * imageArry;
/***/
@property (nonatomic, copy) void(^uploadResultBlock)(BOOL isSucceed);
@end

@implementation HZTImagePickerView

+(instancetype)showImagePickerViewWithMaxCount:(NSUInteger)maxCount callBack:(ImagePickerViewBlock)callBack {
    HZTImagePickerView * view = [[HZTImagePickerView alloc]initWithMaxCount:maxCount callBack:callBack];
    return view;
}

-(instancetype)initWithMaxCount:(NSInteger)maxCount callBack:(ImagePickerViewBlock)callBack{
    self = [self init];
    if (self) {
        self.Block = callBack;
        self.maxCount = maxCount;
        [self simulateClick];
    }
    return self;
}

#pragma mark --- 模拟点击
-(void)simulateClick{
    __weak typeof(self) weakSelf = self;
    HZTActionSheet(@"上传图片", @"取消", nil,@[@"拍照",@"选择相册"], ^(NSUInteger index) {
        UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = weakSelf;
        switch (index) {
            case 1:{
                if([ToolBaseClass cheackDeviceAuthorityWithImagePickerSourceType:UIImagePickerControllerSourceTypeCamera])return;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    /**调用相机*/
                    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
                });
            }
                break;
            case 2:{
                if([ToolBaseClass cheackDeviceAuthorityWithImagePickerSourceType:UIImagePickerControllerSourceTypePhotoLibrary])return;
                ZLPhotoPickerViewController * pickerVc = [[ZLPhotoPickerViewController alloc] init];
                pickerVc.maxCount = weakSelf.maxCount;
                pickerVc.status = PickerViewShowStatusCameraRoll;
                void(^resultBlock)(BOOL isSuccessd) = ^(BOOL isSuccessd){
                    if (isSuccessd) {
                        weakSelf.uploadResultBlock(YES);
                    }else{
                        [HZTToastHUD showNormalWithTitle:@"上传失败!"];
                    }
                };
                
                pickerVc.Block = ^(void (^Block)(BOOL isSucceed)) {
                    weakSelf.uploadResultBlock = Block;
                };
                pickerVc.callBack = ^(id status) {
                    weakSelf.Block(status,HZTImagePickerViewType_PhotoLibrary,resultBlock);
                };
                [pickerVc showPickerVc:App_TheFrontViewC.navigationController];
            }
                break;
            case 0:
                return;
            default:
                break;
        }
    });
}

#pragma mark --- 打开相机
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type{
    UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
    //ipc.allowsEditing = YES;
    ipc.sourceType = type;
    ipc.delegate = self;
    [App_TheFrontViewC presentViewController:ipc animated:YES completion:nil];
    NSLog(@"App_TheFrontViewC%@",App_TheFrontViewC);
}

#pragma mark --- 拍照完毕
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    WS(weakSelf)
    if (self.maxCount == 1) {
        [picker dismissViewControllerAnimated:YES completion:^{
            weakSelf.imageCropperController = [[VPImageCropperViewController alloc] initWithImage:[ToolBaseClass fixOrientation:info[UIImagePickerControllerOriginalImage]] cropFrame:CGRectMake(0,(kScreenH - kScreenW) * .5, kScreenW,kScreenW) limitScaleRatio:5];
            [weakSelf.imageCropperController setSubmitblock:^(UIViewController *viewController , UIImage *image) {
                [weakSelf.imageArry addObject:image];
                void(^resultBlock)(BOOL isSuccessd) = ^(BOOL isSuccessd){
                    if (isSuccessd){
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [viewController.navigationController popViewControllerAnimated:YES];
                        });
                    }else{
                        [HZTToastHUD showNormalWithTitle:@"上传失败!"];
                    }
                };
                [weakSelf.imageArry addObject:image];
                weakSelf.Block(weakSelf.imageArry,HZTImagePickerViewType_Camera,resultBlock);
            }];
            [weakSelf.imageCropperController setCancelblock:^(UIViewController *viewController){
                [viewController.navigationController popViewControllerAnimated:YES];
            }];
            [App_TheFrontViewC.navigationController pushViewController:weakSelf.imageCropperController animated:YES];
        }];
    }else{
        [weakSelf.imageArry addObject:info];
        void(^resultBlock)(BOOL isSuccessd) = ^(BOOL isSuccessd){
        };
        weakSelf.Block(weakSelf.imageArry,HZTImagePickerViewType_Camera,resultBlock);
        [picker dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (NSMutableArray *)imageArry{
    if (!_imageArry) {
        _imageArry = [NSMutableArray array];
    }
    return _imageArry;
}

-(void)dealloc{
    NSLog(@"HZTImagePickerView dealloc");
}

@end
