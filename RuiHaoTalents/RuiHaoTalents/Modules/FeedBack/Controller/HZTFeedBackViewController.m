//
//  HZTFeedBackViewController.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/22.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTFeedBackViewController.h"

#import "HZTTextView.h"
#import "HZTFeedBackCell.h"
#import "HZTImagePickerView.h"

@interface HZTFeedBackViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) HZTTextView *textView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, copy) NSString *content;

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
    self.view.backgroundColor = [UIColor whiteColor];

    [self addTextView];
    [self addCollectionView];
    [self addLineView];
    [self addSubmitBtn];
}

- (void)submit {
    NSLog(@"内容: %@", self.content);
}

- (void)submitHandler:(NSString *)content {
    
    self.content = content;
    
    if (kStringIsEmpty(content)) {
        self.submitBtn.enabled = NO;
        self.submitBtn.backgroundColor = [UIColor placeholder];
        return;
    }
    self.submitBtn.backgroundColor = HZTMainColor;
    self.submitBtn.enabled = YES;
}

#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.images.count >= 4) {
        return 4;
    }
    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HZTFeedBackCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HZTFeedBackCell" forIndexPath:indexPath];
    if (indexPath.row == self.images.count) {
        [cell setImage:[UIImage imageNamed:@"profile_add_image"]];
        [cell setHiddenDeleteBtn:YES];
    } else {
        [cell setImage:self.images[indexPath.row]];
        [cell setHiddenDeleteBtn:NO];
    }
    WS(weakSelf)
    [cell deleteBlock:^{
        [weakSelf.images removeObjectAtIndex:indexPath.row];
        [weakSelf.collectionView reloadData];
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.images.count) {
        WS(weakSelf)
        [HZTImagePickerView showImagePickerViewWithMaxCount:4 - self.images.count callBack:^(NSMutableArray *imagesArray, HZTImagePickerViewType type, void (^resultBlock)(BOOL isSucceed)) {
            switch (type) {
                    case HZTImagePickerViewType_PhotoLibrary: {
                        [imagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            ZLPhotoAssets *assets = (ZLPhotoAssets *)obj;
                            UIImage *image;
                            if (assets.originImage) {
                                image = assets.originImage;
                            }else if (assets.thumbImage){
                                image = assets.thumbImage;
                            }else{
                                image = assets.aspectRatioImage;
                            }
                            [weakSelf.images addObject:image];
                            [weakSelf.collectionView reloadData];
                        }];
                    }
                    break;
                    case HZTImagePickerViewType_Camera: {
                        
                    }
                    break;
                    
                default:
                    break;
            }
        }];
    }
}

#pragma mark --- 懒加载相关

- (void)addTextView {
    if (!_textView) {
        _textView = [HZTTextView textView];
        _textView.placeholder = @"请简单描述您的问题和建议，以便我们提供更好 的帮助";
        _textView.placeholderColor = [UIColor placeholder];
        _textView.font = HZTFontSize(15);
        WS(weakSelf)
        [_textView addTextDidChangeHandler:^(HZTTextView * _Nonnull textView) {
            [weakSelf submitHandler:textView.text];
        }];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.top.equalTo(self.view).offset(23);
            make.height.mas_equalTo(183);
        }];
    }
}

- (void)addCollectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (kScreenW - 30 - 28 * 4) / 4;
        [layout setItemSize:CGSizeMake(itemWidth, 93)];
        layout.sectionInset = UIEdgeInsetsMake(20, 15, 20, 15);
        layout.minimumInteritemSpacing = 28;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HZTFeedBackCell class] forCellWithReuseIdentifier:@"HZTFeedBackCell"];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.textView.mas_bottom).offset(23);
            make.height.mas_equalTo(133);
        }];
    }
}

- (void)addLineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor line];
        [self.view addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.top.equalTo(self.collectionView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
    }
}

- (void)addSubmitBtn {
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _submitBtn.titleLabel.font = HZTFontSize(16);
        _submitBtn.backgroundColor = [UIColor placeholder];
        _submitBtn.layer.cornerRadius = 5;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.enabled = NO;
        [_submitBtn addTarget:self action:@selector(submit) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_submitBtn];
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.top.equalTo(self.lineView.mas_bottom).offset(29);
            make.height.mas_equalTo(46);
        }];
    }
}

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

@end
