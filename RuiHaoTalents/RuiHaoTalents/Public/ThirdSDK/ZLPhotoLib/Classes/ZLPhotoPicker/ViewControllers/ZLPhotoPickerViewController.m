//
//  PickerViewController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoPickerViewController.h"
#import "ZLPhoto.h"
#import "VPImageCropperViewController.h"
@interface ZLPhotoPickerViewController ()
@property (nonatomic , weak) ZLPhotoPickerGroupViewController *groupVc;
/***/
@property (nonatomic, strong) VPImageCropperViewController * imageCropperController;
/***/
@property (nonatomic, strong) UINavigationController * nav;
@end

@implementation ZLPhotoPickerViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNotification];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - init Action
- (void) createNavigationController{
    ZLPhotoPickerGroupViewController *groupVc = [[ZLPhotoPickerGroupViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:groupVc];
    nav.view.frame = self.view.bounds;
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    self.groupVc = groupVc;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self createNavigationController];
    }
    return self;
}

- (void)setSelectPickers:(NSArray *)selectPickers{
    _selectPickers = selectPickers;
    self.groupVc.selectAsstes = selectPickers;
}

- (void)setStatus:(PickerViewShowStatus)status{
    _status = status;
    self.groupVc.status = status;
}

- (void)setMaxCount:(NSInteger)maxCount{
    if (maxCount <= 0) return;
    _maxCount = maxCount;
    self.groupVc.maxCount = maxCount;
}

- (void)setTopShowPhotoPicker:(BOOL)topShowPhotoPicker{
    _topShowPhotoPicker = topShowPhotoPicker;
    self.groupVc.topShowPhotoPicker = topShowPhotoPicker;
}

#pragma mark - 展示控制器
- (void)showPickerVc:(UINavigationController *)vc{
    __weak typeof(vc)weakVc = vc;
    self.nav = vc;
    if (weakVc != nil) {
        [weakVc presentViewController:self animated:YES completion:nil];
    }
}

- (void) addNotification{
    // 监听异步done通知
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done:) name:PICKER_TAKE_DONE object:nil];
    });
    
    // 监听异步点击第一个Cell的拍照通知
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCamera:) name:PICKER_TAKE_PHOTO object:nil];
    });
}

#pragma mark - 监听点击第一个Cell进行拍照
- (void)selectCamera:(NSNotification *)noti{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(pickerCollectionViewSelectCamera:withImage:)]){
            [self.delegate pickerCollectionViewSelectCamera:self withImage:noti.userInfo[@"image"]];
        }
    });
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听点击Done按钮
- (void)done:(NSNotification *)note{
    NSArray *selectArray =  note.userInfo[@"selectAssets"];
    WS(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(pickerViewControllerDoneAsstes:)]) {
            [self.delegate pickerViewControllerDoneAsstes:selectArray];
        }else if (weakSelf.callBack){
            if (weakSelf.maxCount == 1) {
                ZLPhotoAssets * assets = (ZLPhotoAssets *)[selectArray firstObject];
                NSLog(@"assets.originImage%@\n thumbImage%@\n aspectRatioImage%@",assets.originImage,assets.thumbImage,assets.aspectRatioImage);
                UIImage * image ;
                if (assets.originImage) {
                    image = assets.originImage;
                }else if (assets.thumbImage){
                    image = assets.thumbImage;
                }else{
                    image = assets.aspectRatioImage;
                }
                weakSelf.imageCropperController = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, (kScreenH - kScreenW) * .5, kScreenW, kScreenW) limitScaleRatio:5];
                [weakSelf.imageCropperController setSubmitblock:^(UIViewController *viewController , UIImage *image) {
                    void(^resultBlock)(BOOL isSuccessd) = ^(BOOL isSuccessd){
                        if (isSuccessd) {
                            [weakSelf dismissViewControllerAnimated:YES completion:nil];
                            [viewController.navigationController popViewControllerAnimated:YES];
                        }
                    };
                    if (self.Block) {
                        self.Block(resultBlock);
                    }
                    self.callBack(@[image]);
                }];
                [weakSelf.imageCropperController setCancelblock:^(UIViewController *viewController){
                    [viewController.navigationController popViewControllerAnimated:YES];
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }];
                [weakSelf.nav pushViewController:weakSelf.imageCropperController animated:YES];
            }else{
                void(^resultBlock)(BOOL isSuccessd) = ^(BOOL isSuccessd){
                    
                };
                
                if (self.Block) {
                    self.Block(resultBlock);
                }
                self.callBack(selectArray);
            }
        }
    });
}

- (void)setDelegate:(id<ZLPhotoPickerViewControllerDelegate>)delegate{
    _delegate = delegate;
    self.groupVc.delegate = delegate;
}
@end
