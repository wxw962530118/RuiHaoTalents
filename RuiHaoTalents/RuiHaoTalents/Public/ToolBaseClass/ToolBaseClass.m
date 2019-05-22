//
//  ToolBaseClass.m
//  jia
//
//  Created by 王新伟 on 2018/9/12.
//

#import "ToolBaseClass.h"
#import "AppDelegate.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <CommonCrypto/CommonDigest.h>
#import "HZTOthersNetWorkManager.h"
@interface ToolBaseClass ()<UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic, copy) void(^callBack)(NSUInteger index);
@property (nonatomic, copy) void(^alertBlock)(void);
@end
@implementation ToolBaseClass

static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

+ (instancetype)shareManager{
    static ToolBaseClass * manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

+ (NSString*)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    //NSString *platform = [NSString stringWithCString:machine];
    NSString* platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString*)getPhoneExplicitModel{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])            return @"iPhone 1G";
    else if ([platform isEqualToString:@"iPhone1,2"])       return @"iPhone 3G";
    else if ([platform isEqualToString:@"iPhone2,1"])       return @"iPhone 3GS";
    else if ([platform isEqualToString:@"iPhone3,1"])       return @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone3,2"])       return @"Verizon iPhone 4";
    else if ([platform isEqualToString:@"iPhone4,1"])       return @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone4,2"])       return @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone5,1"])       return @"iPhone 5";
    else if ([platform isEqualToString:@"iPhone5,2"])       return @"iPhone 5";
    else if ([platform isEqualToString:@"iPhone6,1"])       return @"iPhone 6";
    else if ([platform isEqualToString:@"iPhone6,2"])       return @"iPhone 6";
    else if ([platform isEqualToString:@"iPod1,1"])         return @"iPod Touch 1G";
    else if ([platform isEqualToString:@"iPod2,1"])         return @"iPod Touch 2G";
    else if ([platform isEqualToString:@"iPod3,1"])         return @"iPod Touch 3G";
    else if ([platform isEqualToString:@"iPod4,1"])         return @"iPod Touch 4G";
    else if ([platform isEqualToString:@"iPad1,1"])         return @"iPad";
    else if ([platform isEqualToString:@"iPad2,1"])         return @"iPad 2 (WiFi)";
    else if ([platform isEqualToString:@"iPad2,2"])         return @"iPad 2 (GSM)";
    else if ([platform isEqualToString:@"iPad2,3"])         return @"iPad 2 (CDMA)";
    else if ([platform isEqualToString:@"i386"])            return @"Simulator";
    else if ([platform isEqualToString:@"x86_64"])          return @"Simulator";
    return platform;
}

/**颜色转换为背景图片*/
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**获取Window*/
+ (UIWindow *)getRootWindow{
    NSArray * windows = [UIApplication sharedApplication].windows;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)&&window==delegate.window)
            return window;
    }
    return [[UIApplication sharedApplication].delegate window];
}


-(UIAlertView *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable id)otherButtonTitles callBack:(void (^)(NSUInteger))callBack{
    self.callBack = callBack;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    if ([otherButtonTitles isKindOfClass:[NSArray class]]) {
        for (NSString *otherTitle in otherButtonTitles) {
            [alert addButtonWithTitle:otherTitle];
        }
    }else if ([otherButtonTitles isKindOfClass:[NSString class]] && ![otherButtonTitles isEqualToString:@""] && otherButtonTitles != nil) {
        [alert addButtonWithTitle:otherButtonTitles];
    }
    [alert show];
    return alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.callBack) {
        self.callBack(buttonIndex);
    }
}

- (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(id)otherButtonTitles callBack:(void (^)(NSUInteger))callBack{
    self.callBack = callBack;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    if ([otherButtonTitles isKindOfClass:[NSArray class]]) {
        for (NSString *otherTitle in otherButtonTitles) {
            [sheet addButtonWithTitle:otherTitle];
        }
    }else if ([otherButtonTitles isKindOfClass:[NSString class]]) {
        [sheet addButtonWithTitle:otherButtonTitles];
    }
    [sheet showInView:[UIApplication sharedApplication].delegate.window];
    return sheet;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.callBack) {
        self.callBack(buttonIndex);
    }
}

+ (NSDictionary *)changeErrorToNSDictionary:(NSError *)error{
    NSData* data = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (data!=nil) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dic;
    }
    return nil;
}

+ (NSString *)getCurrentVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (BOOL)isNullClass:(NSObject *)obj{
    if (!obj || obj == nil || [obj isKindOfClass:[NSNull class]]){
        return YES;
    }else if ([obj isKindOfClass:[NSString class]]){
        NSString * str = (NSString *)obj;
        return str.length == 0;
    }else if ( [obj isKindOfClass:[NSArray class]]){
        NSArray * arr = (NSArray *)obj;
        return  arr.count == 0;
    }else if ( [obj isKindOfClass:[NSDictionary class]]){
        NSDictionary * dict = (NSDictionary *)obj;
        return dict.allKeys.count == 0;
    }
    return NO;
}


+(CGFloat )getContentPreciseWith:(UIView *)obj width:(CGFloat)width{
    CGSize labelSize = [obj sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return ceil(labelSize.height) + 1;
}

+ (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font{
    return [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
}

+ (CGFloat)getHeightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font{
    CGFloat height = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
    if ([string isEqualToString:@"\n"]) {
        height += [self hasLineWithString:string]*font.lineHeight;
    }
    return height;
}

+ (NSUInteger)hasLineWithString:(NSString *)string{
    return [string componentsSeparatedByString:@"\n"].count;
}

+(UIImage *)handleGrayImageWithSourceImage:(UIImage *)sourceImage{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

-(BOOL)handleIPhoneModel{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow * mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

+(NSString *)handleBase64StringWithString:(NSString *)string{
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity:lentext];
    raw = [data bytes];
    ixtext = 0;
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString:[NSString stringWithFormat:@"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString:@"="];
        
        ixtext += 3;
        charsonline += 4;
    }
    return result;
}

+(NSString *)URLEncodedString:(NSString *)string{
    NSString * unencodedString = string;
    NSString * encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

+(NSString *)handleTimeWithTimeInterval:(NSTimeInterval )timeInterval{
    NSDate * d = [[NSDate alloc]initWithTimeIntervalSince1970:timeInterval/1000.0];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString * timeString=[formatter stringFromDate:d];
    return timeString;
}

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *)getMD5WithString:(NSString *)str lowerCase:(BOOL)lowerCase {
    if (str == nil || str.length == 0) return nil;
    const char *value = [str UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        if (lowerCase) {
            [outputString appendFormat:@"%02x",outputBuffer[count]];
        }else {
            [outputString appendFormat:@"%02X",outputBuffer[count]];
        }
    }
    return outputString;
}

+(BOOL)saveUserDefaultsWithKey:(NSString *)key value:(id)value{
    NSUserDefaults * df = [NSUserDefaults standardUserDefaults];
    [df setObject:value forKey:key];
    return [df synchronize];
}

+(id)getUserDefaultsWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(void)removeUserDefaultsWithKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

/**
 绘制虚线
 @param lineView    需要绘制成虚线的控件
 @param lineLength  虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor   虚线的颜色
 */
+(void )drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    /**设置虚线颜色为*/
    [shapeLayer setStrokeColor:lineColor.CGColor];
    /** 设置虚线宽度*/
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    /**设置线宽，线间距*/
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    /**设置路径*/
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    /**把绘制好的虚线添加上来*/
    [lineView.layer addSublayer:shapeLayer];
}


/**
 添加虚线边框
 @param lineView    需要绘制成虚线的控件
 @param lineWidth   虚线宽度
 @param lineLength  虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor   虚线颜色
 */
+(void)drawBorderDashLine:(UIView *)lineView lineWidth:(float )lineWidth  lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    CAShapeLayer * border = [CAShapeLayer layer];
    border.strokeColor = lineColor.CGColor;
    border.fillColor = nil;
    /**绘制带圆角的边框*/
    border.path = [UIBezierPath bezierPathWithRoundedRect:lineView.bounds cornerRadius:3].CGPath;
    border.frame = lineView.bounds;
    border.lineWidth =lineWidth;
    border.lineCap = @"square";
    border.lineDashPattern = @[@(lineLength),@(lineSpacing)];
    [lineView.layer addSublayer:border];
}

/**
 创建抖动动画
 @param translate   抖动幅度
 @param viewToShake 需要抖动的控件
 */
+ (void)shakeViewWithRranslate:(float )translate viewToShake:(UIView *)viewToShake{
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, translate,0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity,-translate,0.0);
    viewToShake.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

#pragma mark --- 计算两个日期之间的天数
+(NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    /**去掉时分秒信息*/
    NSDate * fromDate;
    NSDate * toDate;
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:beginDate];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents * comp = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    NSLog(@" -- >>  comp : %@  << --",comp);
    return comp.day;
}

/**时间转换为时间戳，精确到微秒*/
+ (NSInteger)getIntervalsWithTimeStamp:(NSInteger)timeStamp{
    return [[NSDate date] timeIntervalSinceDate:[self getDateWithTimeStamp:timeStamp]];
}

/**时间戳转换为时间*/
+ (NSDate *)getDateWithTimeStamp:(NSInteger)timeStamp{
    return [NSDate dateWithTimeIntervalSince1970:timeStamp * 0.001 * 0.001];
}

/**时间转换为时间戳，精确到微秒*/
+ (NSInteger)getTimeStampWithDate:(NSDate *)date{
    return [[NSNumber numberWithDouble:[date timeIntervalSince1970] * 1000 * 1000] integerValue];
}

/**获取设备内存总大小 单位MB*/
+(double)getDeviceTotalMemorySize{
    return [NSProcessInfo processInfo].physicalMemory/1024.0/1024.0;
}

/**获取设备可用内存总大小 单位MB*/
+(double)getDeviceAvailableMemorySize{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS){
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count)/1024.0)/1024.0;
}

/**获取设备已用内存总大小 单位MB*/
+(double)getDeviceUsedMemory{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    return taskInfo.resident_size/1024.0/1024.0;
}

+(NSString *)fileSizeToString:(long long)fileSize{
    NSInteger KB = 1024;
    NSInteger MB = KB * KB;
    NSInteger GB = MB * KB;
    if (fileSize < 10)  {
        return @"0 B";
    }else if (fileSize < KB) {
        return @"< 1 KB";
    }else if (fileSize < MB) {
        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize)/KB];
    }else if (fileSize < GB) {
        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize)/MB];
    }else   {
        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
    }
}

+(BOOL)handlePredicatePassword:(NSString *)passWord{
    BOOL result = false;
    if ([passWord length] >= 8 && [passWord length] <= 16){
        /**判断长度大于8位后再接着判断是否同时包含数字和字符*/
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = ![pred evaluateWithObject:passWord];
    }
    return result;
}

+ (BOOL)checkPhoneNumberInput:(NSString *)input {
    if (!input || [input isEqual:[NSNull null]] || [input isKindOfClass:[NSNull class]] || input.length == 0) {
        return NO;
    }
    NSString * mobile = @"^1(3|4|5|6|7|8|9)[0-9]\\d{8}$";
    NSPredicate * regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    if ([regextestmobile evaluateWithObject:input] == NO) {
        return NO;
    }
    return YES;
}

/**获取电池电量*/
+(CGFloat)getBatteryQuantity{
    return [[UIDevice currentDevice] batteryLevel];
}

/**获取电池状态*/
+(UIDeviceBatteryState)getBatteryStauts{
    return [UIDevice currentDevice].batteryState;
}

-(void)showAlertViewType:(CustomAlretType)type title:(NSString *)title desc:(NSString *)desc isShowCancel:(BOOL)isShowCancel bottomTitle:(NSString *)bottomTitle callBack:(void (^)(void))callBack{
    self.alertBlock = callBack;
    HZTCustomAlretView * view = [HZTCustomAlretView createAlretView];
    [view configSubViewsType:type title:title desc:desc isShowCancel:isShowCancel bottomTitle:bottomTitle callBack:^{
        if (self.alertBlock) {
            self.alertBlock();
        }
    }];
}

+(NSString *)dictionaryToJson:(NSDictionary *)dic{
    NSError * error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString * mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    /**1.去掉字符串中的空格*/
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    /**2.去掉字符串中的换行符*/
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) return nil;
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(BOOL)isShouldLogin{
    BOOL isShouldLogin = NO;
    if ([ToolBaseClass isNullClass:[HZTAccountManager getUser].token]) {
        NotificationPost(HZTNOTIFICATION_SHOULD_LOGIN, nil, nil);
        isShouldLogin = YES;
    }
    return isShouldLogin;
}

+ (HZTBaseViewController *)getTheFrontViewController{
    UINavigationController * rootNavC = [self getRootNavController];
    return rootNavC.viewControllers.lastObject;
}

+ (HZTRootNavigationController *)getRootNavController{
    HZTRootNavigationController * nav = (HZTRootNavigationController *)[[[UIApplication sharedApplication].delegate window] rootViewController];
    return nav;
}

+(void)showNavigationWithLongitude:(double)longitude latitude:(double)latitude{
    /**当前手机可用地图容器 里面是存放字典 @{@"title":@"",@"url":""}*/
    NSMutableArray <NSMutableDictionary *>* mapsArr = [NSMutableArray array];
    /**1.苹果内置地图比较特殊 没有安装的话会提示用户恢复Maps 不用自己特殊判定是否安装*/
    NSMutableDictionary * appleMapDict = [NSMutableDictionary dictionary];
    [appleMapDict setValue:@"苹果地图" forKey:@"title"];
    [mapsArr addObject:appleMapDict];
    /**2.百度地图*/
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary * baiduMapDic = [NSMutableDictionary dictionary];
        [baiduMapDic setValue:@"百度地图" forKey:@"title"];
        NSString * urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=北京&mode=driving&coord_type=gcj02",latitude,longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [baiduMapDic setValue:urlString forKey:@"url"];
        [mapsArr addObject:baiduMapDic];
    }
    /**3.高德地图*/
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary * gaodeMapDic = [NSMutableDictionary dictionary];
        [gaodeMapDic setValue:@"高德地图" forKey:@"title"];
        NSString * urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=2",@"刷哪儿",latitude,longitude,@""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [gaodeMapDic setValue:urlString forKey:@"url"];
        [mapsArr addObject:gaodeMapDic];
    }
    /**4.谷歌地图*/
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary * googleMapDic = [NSMutableDictionary dictionary];
        [googleMapDic setValue:@"谷歌地图" forKey:@"title"];
        NSString * urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"",@"",latitude, longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [googleMapDic setValue:urlString forKey:@"url"];
        [mapsArr addObject:googleMapDic];
    }
    /**5.腾讯地图*/
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary * qqMapDic = [NSMutableDictionary dictionary];
        [qqMapDic setValue:@"腾讯地图" forKey:@"title"];
        NSString * urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",latitude, longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [qqMapDic setValue:urlString forKey:@"url"];
        [mapsArr addObject:qqMapDic];
    }
    
    NSMutableArray <NSString *>* titles = [NSMutableArray array];
    for (NSMutableDictionary * dict in mapsArr) {
        [titles addObject:dict[@"title"]];
    }
    [HZTCustomSheetView showCustomSheetViewTitle:@"选择地图" contentArr:titles callBack:^(NSInteger index) {
        if (![titles[index] isEqualToString:@"苹果地图"]) {
            NSMutableDictionary * dict = mapsArr[index];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict objectForKey:@"url"]]];
        }else{
            CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(latitude, longitude);
            MKMapItem * currentLoc = [MKMapItem mapItemForCurrentLocation];
            MKMapItem * toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
            toLocation.name = @"西安";
            NSArray * items = @[currentLoc,toLocation];
            NSDictionary * dic = @{
                                  MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                                  MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                                  MKLaunchOptionsShowsTrafficKey : @(YES)
                                  };
            [MKMapItem openMapsWithItems:items launchOptions:dic];
        }
    }];
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar * calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate * mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

+(NSString *)handleDateFormatterWithDate:(NSDate *)date isDot:(BOOL)isDot hasYear:(BOOL)hasYear{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    if (isDot && hasYear) {
        [formatter setDateFormat:@"yyyy年.MM月.dd日"];
    }else if (isDot && !hasYear){
        [formatter setDateFormat:@"yyyy.MM.dd"];
    }else if (!isDot && hasYear){
        [formatter setDateFormat:@"yyyy年-MM月-dd日"];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return [formatter stringFromDate:date];
}

+(BOOL)cheackDeviceAuthorityWithImagePickerSourceType:(UIImagePickerControllerSourceType)sourceType{
    NSString * tipTitle;
    NSString * tipMessage;
    /**当前是否可用*/
    BOOL       isAvailable = false;
    /**摄像头是否可用,或授权*/
    BOOL available = [UIImagePickerController isSourceTypeAvailable:sourceType];
    AVAuthorizationStatus authStatus;
    if(sourceType == UIImagePickerControllerSourceTypeCamera){
        NSString * mediaType = AVMediaTypeVideo;
        authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(!available || authStatus == AVAuthorizationStatusDenied){
            isAvailable = YES;
            tipTitle = @"未获得授权使用摄像头";
            tipMessage = @"请在iOS“设置”－“隐私”－“相机”中打开";
        }else{
            isAvailable = NO;
        }
    }
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (!available || author == ALAuthorizationStatusDenied){
            isAvailable = YES;
            tipTitle = @"未获得授权访问相册";
            tipMessage = @"请在IOS“设置”-“隐私”-“照片”中打开";
        }else{
            isAvailable = NO;
        }
    }
    
    if(isAvailable){
        HZTAlertView(tipTitle, tipMessage, @"稍后再说",@"去开启", ^(NSUInteger index) {
            if (index == 1) {
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        });
    }
    return isAvailable;
}

#pragma mark --- 处理相机拍照图片被旋转的问题
+(UIImage *)fixOrientation:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage * img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
