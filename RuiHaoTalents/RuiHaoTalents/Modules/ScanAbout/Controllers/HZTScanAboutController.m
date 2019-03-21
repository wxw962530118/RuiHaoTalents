//
//  HZTScanAboutController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTScanAboutController.h"
#import "SWScannerView.h"
@interface HZTScanAboutController ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/** 扫描器 */
@property (nonatomic, strong) SWScannerView *scannerView;
@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation HZTScanAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫一扫";
    [self setupUI];
    NotificationRegister(UIApplicationDidBecomeActiveNotification, self, @selector(appDidBecomeActive:), nil);
    NotificationRegister(UIApplicationWillResignActiveNotification, self, @selector(appWillResignActive:), nil);
}

- (void)dealloc {
    NotificationRemoveAll(self);
}

- (SWScannerView *)scannerView{
    if (!_scannerView) {
        _scannerView = [[SWScannerView alloc]initWithFrame:self.view.bounds config:self.codeConfig];;
    }
    return _scannerView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self resumeScanning];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scannerView sw_setFlashlightOn:NO];
    [self.scannerView sw_hideFlashlightWithAnimated:YES];
}

- (void)setupUI{
    WS(weakSelf)
    [self ctNavRightItemWithTitle:@"相册" imageName:nil callBack:^{
        [weakSelf showAlbum];
    }];
    [self.view addSubview:self.scannerView];
    /**校验相机权限*/
    [SWQRCodeManager sw_checkCameraAuthorizationStatusWithGrand:^(BOOL granted) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setupScanner];
            });
        }
    }];
}

/** 创建扫描器 */
- (void)setupScanner {
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput * deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput * metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if (self.codeConfig.scannerArea == SWScannerAreaDefault) {
        metadataOutput.rectOfInterest = CGRectMake([self.scannerView scanner_y]/self.view.frame.size.height, [self.scannerView scanner_x]/self.view.frame.size.width, [self.scannerView scanner_width]/self.view.frame.size.height, [self.scannerView scanner_width]/self.view.frame.size.width);
    }
    
    AVCaptureVideoDataOutput * videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:deviceInput]) {
        [self.session addInput:deviceInput];
    }
    if ([self.session canAddOutput:metadataOutput]) {
        [self.session addOutput:metadataOutput];
    }
    if ([self.session canAddOutput:videoDataOutput]) {
        [self.session addOutput:videoDataOutput];
    }
    metadataOutput.metadataObjectTypes = [SWQRCodeManager sw_metadataObjectTypesWithType:self.codeConfig.scannerType];
    AVCaptureVideoPreviewLayer * videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    videoPreviewLayer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:videoPreviewLayer atIndex:0];
    [self.session startRunning];
}

#pragma mark -- 跳转相册
- (void)imagePicker {
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.navigationBar.translucent = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    /**获取扫一扫结果*/
    if (metadataObjects && metadataObjects.count > 0) {
        [self pauseScanning];
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        NSString * stringValue = metadataObject.stringValue;
        [self sw_handleWithValue:stringValue];
    }
}

#pragma mark -- AVCaptureVideoDataOutputSampleBufferDelegate
/**此方法会实时监听亮度值*/
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary * metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary *)metadataDict];
    CFRelease(metadataDict);
    NSDictionary * exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    /**亮度值*/
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    if (![self.scannerView sw_flashlightOn]) {
        if (brightnessValue < -4.0) {
            [self.scannerView sw_showFlashlightWithAnimated:YES];
        }else{
            [self.scannerView sw_hideFlashlightWithAnimated:YES];
        }
    }
}

- (void)showAlbum {
    /**校验相册权限*/
    WS(weakSelf)
    [SWQRCodeManager sw_checkAlbumAuthorizationStatusWithGrand:^(BOOL granted) {
        if (granted) {
            [weakSelf imagePicker];
        }
    }];
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * pickImage = info[UIImagePickerControllerOriginalImage];
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    /**获取选择图片中识别结果*/
    NSArray * features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(pickImage)]];
    [picker dismissViewControllerAnimated:YES completion:^{
        if (features.count > 0) {
            CIQRCodeFeature *feature = features[0];
            NSString *stringValue = feature.messageString;
            [self sw_handleWithValue:stringValue];
        }else {
            [self sw_didReadFromAlbumFailed];
        }
    }];
}

#pragma mark -- App 从后台进入前台
- (void)appDidBecomeActive:(NSNotification *)notify {
    [self resumeScanning];
}

#pragma mark -- App 从前台进入后台
- (void)appWillResignActive:(NSNotification *)notify {
    [self pauseScanning];
}

/**恢复扫一扫功能*/
- (void)resumeScanning {
    if (self.session) {
        [self.session startRunning];
        [self.scannerView sw_addScannerLineAnimation];
    }
}

/**暂停扫一扫功能*/
- (void)pauseScanning {
    if (self.session) {
        [self.session stopRunning];
        [self.scannerView sw_pauseScannerLineAnimation];
    }
}

#pragma mark -- 扫一扫API
/**
 处理扫一扫结果
 @param value 扫描结果
 */
- (void)sw_handleWithValue:(NSString *)value{
    NSLog(@"sw_handleWithValue === %@", value);
    HZTAlertView(@"提示", [NSString stringWithFormat:@"扫描结果:%@",value], @"确定", nil, ^(NSUInteger index) {
    });
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 相册选取图片无法读取数据
 */
- (void)sw_didReadFromAlbumFailed {
    NSLog(@"sw_didReadFromAlbumFailed");
}

@end
