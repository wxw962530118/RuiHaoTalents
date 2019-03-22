//
//  HZTImagePickerView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/22.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,HZTImagePickerViewType){
    /**相机拍照*/
    HZTImagePickerViewType_Camera,
    /**相册选择*/
    HZTImagePickerViewType_PhotoLibrary
};

/**
 拍照或选择相册的回调
 @param imagesArray 选择的照片数组
 @param type 当前选择的获取照片方式
 */

typedef void(^ImagePickerViewBlock)(NSMutableArray * imagesArray,HZTImagePickerViewType type,void(^resultBlock)(BOOL isSucceed));

NS_ASSUME_NONNULL_BEGIN

@interface HZTImagePickerView : UIView
/**
 展示图片选择器
 @param maxCount 最大选择图片个数
 @param callBack 选择完成的回调
 */
+(instancetype)showImagePickerViewWithMaxCount:(NSUInteger)maxCount callBack:(ImagePickerViewBlock)callBack;
@end

NS_ASSUME_NONNULL_END
