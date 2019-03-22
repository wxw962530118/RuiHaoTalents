//
//  ToolBaseClass.h
//  jia
//
//  Created by 王新伟 on 2018/9/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HZTCustomAlretView.h"
#import "HZTBaseViewController.h"
#import "HZTRootNavigationController.h"

#define CurrentVersion                 [ToolBaseClass getCurrentVersion]
#define IS_Simulator                   [[ToolBaseClass getPhoneExplicitModel] isEqualToString:@"Simulator"]
#define GetHomeCachPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define App_TheFrontViewC              [ToolBaseClass getTheFrontViewController]
#define RootWindow [ToolBaseClass getRootWindow]

@interface ToolBaseClass : NSObject
/***/
+(instancetype)shareManager;
/**获取应用根视图 */
+(UIWindow *)getRootWindow;
/**获取当前版本号 */
+(NSString *)getCurrentVersion;
/**计算字符串的高度 (包括对多行文字的处理) */
+(CGFloat)getHeightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font;
/**精确计算文本内容高度*/
+(CGFloat)getContentPreciseWith:(UIView *)obj width:(CGFloat )width;
/**计算字符串的宽度 */
+(CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font;
/**判断字符串是否为null */
+(BOOL)isNullClass:(NSString *)string;
/**绘制虚线边框*/
+(void)drawBorderDashLine:(UIView *)lineView lineWidth:(float )lineWidth lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**绘制一条虚线*/
+(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**根据传入的抖动幅度 进行抖动动画*/
+(void)shakeViewWithRranslate:(float )translate viewToShake:(UIView *)viewToShake;
/**将服务器错误转成字典*/
+(NSDictionary *)changeErrorToNSDictionary:(NSError *)error;
/**用颜色生成图片*/
+(UIImage *)imageWithColor:(UIColor *)color;
/**将stringBase64转码*/
+(NSString *)handleBase64StringWithString:(NSString *)string;
/**获取当前详细机型信息 */
+(NSString*)getPhoneExplicitModel;
/**将图片设成透明*/
+(UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image;
/**将原图转成灰色*/
+(UIImage *)handleGrayImageWithSourceImage:(UIImage *)sourceImage;
/**url 特殊字符提取替换*/
+(NSString *)URLEncodedString:(NSString *)string;
/**格式化时间戳*/
+(NSString *)handleTimeWithTimeInterval:(NSTimeInterval )timeInterval;
/**字符串转MD5*/
+(NSString *)getMD5WithString:(NSString *)str lowerCase:(BOOL)lowerCase;
/**存储用户偏好*/
+(BOOL)saveUserDefaultsWithKey:(NSString *)key value:(id)value;
/**获取存储用户偏好*/
+(id)getUserDefaultsWithKey:(NSString *)key;
/**删除存储的用户偏好*/
+(void)removeUserDefaultsWithKey:(NSString *)key;
/**计算两个日期之间的天数*/
+(NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;
/**处理手机型号*/
-(BOOL)handleIPhoneModel;
/**时间转换为时间戳，精确到微秒*/
+(NSInteger)getIntervalsWithTimeStamp:(NSInteger)timeStamp;
/**时间转换为时间戳*/
+(NSInteger)getTimeStampWithDate:(NSDate *)date;
/**登录注册密码复杂度的效验*/
+(BOOL)handlePredicatePassword:(NSString *)passWord;

/**
 校验中国手机号码
 
 @param input 输入的手机号码
 @return 是否为合法的中国手机号
 */
+ (BOOL)checkPhoneNumberInput:(NSString *)input;

/**获取设备内存总大小*/
+(double)getDeviceTotalMemorySize;
/**获取设备可用内存总大小*/
+(double)getDeviceAvailableMemorySize;
/**获取设备已用内存总大小*/
+(double)getDeviceUsedMemory;
/**将容量大小按照指定单位输出*/
+(NSString *)fileSizeToString:(long long)fileSize;
/**获取电池电量*/
+(CGFloat)getBatteryQuantity;
/**获取电池状态*/
+(UIDeviceBatteryState)getBatteryStauts;
/**字典转化字符串*/
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
/**json字符串转化字典*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**获取最前端的控制器*/
+ (HZTBaseViewController *)getTheFrontViewController;
/**检测是否需要登录*/
+(BOOL)isShouldLogin;
/**根据目的地经纬度调起三方地图导航*/
+(void)showNavigationWithLongitude:(double)longitude latitude:(double)latitude;
/**处理相机拍照图片被旋转的问题*/
+(UIImage *)fixOrientation:(UIImage *)image;
/**检测相机及相册访问权限*/
+(BOOL)cheackDeviceAuthorityWithImagePickerSourceType:(UIImagePickerControllerSourceType)sourceType;
/**获取当前时间前后若干月的时间*/
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
/**提示弹窗 快捷方式 otherButtonTitles类型:NSString或NSArray */
-(UIAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(id)otherButtonTitles callBack:(void(^)(NSUInteger index))callBack;
/**底部弹窗 快捷方式 otherButtonTitles类型:NSString或NSArray */
-(UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(id)otherButtonTitles callBack:(void (^)(NSUInteger))callBack;
/**
 根据状态展示提示框*/
-(void)showAlertViewType:(CustomAlretType)type title:(NSString *)title desc:(NSString *)desc isShowCancel:(BOOL)isShowCancel bottomTitle:(NSString *)bottomTitle callBack:(void (^)(void))callBack;
@end

/**Tool: 把彩色图片转成灰色*/
CG_INLINE UIImage * ToolGetGrayImageWithSourceImage(UIImage * image){
    return [ToolBaseClass handleGrayImageWithSourceImage:image];
}

/** Tool: 颜色转图片 */
CG_INLINE UIImage *ToolGetImageWithColor(UIColor *color){
    return [ToolBaseClass imageWithColor:color];
};

/** Tool: Alert快捷方式, otherButtonTitles类型:NSString或NSArray ,点击取消的返回值为 0 */
CG_INLINE UIAlertView *HZTAlertView(NSString *title, NSString *message, NSString *cancelButtonTitle, id otherButtonTitle, void(^callBack)(NSUInteger index)){
    return [[ToolBaseClass shareManager] alertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle callBack:^(NSUInteger index) {
        callBack(index);
    }];
};

/** Tool: ActionSheet快捷方式, otherButtonTitles类型:NSString或NSArray */
CG_INLINE UIActionSheet *HZTActionSheet(NSString *title, NSString *cancelButtonTitle, NSString *destructiveButtonTitle, id otherButtonTitles, void(^callBack)(NSUInteger index)){
    return [[ToolBaseClass shareManager] actionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles callBack:^(NSUInteger index) {
        callBack(index);
    }];
};

/** Tool: 判断设备是否为 iPhoneX、iPhone XR、iPhone Xs、iPhone Xs Max*/
CG_INLINE BOOL IS_IPhoneX(){
    return [[ToolBaseClass shareManager] handleIPhoneModel];
};

