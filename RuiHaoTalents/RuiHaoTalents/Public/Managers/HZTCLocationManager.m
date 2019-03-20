//
//  HZTCLocationManager.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCLocationManager.h"

@interface HZTCLocationManager ()<CLLocationManagerDelegate>{
    LocationCallback _locationCallback;
    BOOL _keepLocation; //持续定位
    HeadingCallback _headingCallback;
    FailCallback _failCallback;
    CLLocationDistance _delayDistance;  //超出距离
    NSTimeInterval _delayTime;  //超出时间
}

@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,assign) BOOL deferringUpdates;  //推迟更新
@end

@implementation HZTCLocationManager
+ (HZTCLocationManager *)manager{
    static HZTCLocationManager *location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[HZTCLocationManager alloc] init];
        [location initializedLocationManager];
    });
    return location;
}

# pragma mark - APIs(private)
- (void)initializedLocationManager {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    /*
     定位精确度
     kCLLocationAccuracyBestForNavigation    最适合导航
     kCLLocationAccuracyBest    精度最好的
     kCLLocationAccuracyNearestTenMeters    附近10米
     kCLLocationAccuracyHundredMeters    附近100米
     kCLLocationAccuracyKilometer    附近1000米
     kCLLocationAccuracyThreeKilometers    附近3000米
     */
    //    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    /*
     每隔多少米更新一次位置，即定位更新频率
     */
    //    _locationManager.distanceFilter = kCLDistanceFilterNone; //系统默认值
}

#pragma mark --- 申请定位权限
- (void)requestPermission {
//iOS9.0以上系统除了配置info之外，还需要添加这行代码，才能实现后台定位，否则程序会crash
//    if (@available(iOS 9.0, *)) {
//        _locationManager.allowsBackgroundLocationUpdates = YES;
//    } else {
//        // Fallback on earlier versions
//    }
//    [_locationManager requestAlwaysAuthorization];  //一直保持定位
    [_locationManager requestWhenInUseAuthorization]; //使用期间定位
}

/*
 获取当前定位
 */
- (void)updateLocationWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy block:(LocationCallback)block fail:(FailCallback)fail {
    _locationCallback = block;
    _failCallback = fail;
    _keepLocation = NO;
    self.locationManager.desiredAccuracy = desiredAccuracy;
    [self.locationManager startUpdatingLocation];
}

/*
 持续获取当前定位
 */
- (void)keepUpdateLocationWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy distanceFilter:(CGFloat)distanceFilter block:(LocationCallback)block fail:(FailCallback)fail {
    _locationCallback = block;
    _failCallback = fail;
    _keepLocation = YES;
    
    self.locationManager.desiredAccuracy = desiredAccuracy;
    self.locationManager.distanceFilter = distanceFilter;
    
    [self.locationManager startUpdatingLocation];
}

/*
 后台持续定位
 */
//- (void)keepUpdateLocationInBackgroundWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy distanceFilter:(CGFloat)distanceFilter block:(LocationCallback)block fail:(FailCallback)fail {
//
//    //后台持续定位
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
//        self.locationManager.allowsBackgroundLocationUpdates = YES;
//    }else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
//        [self.locationManager requestAlwaysAuthorization];//在后台也可定位
//    }
//
//    /*
//     定位权限为应用使用期间的时候，程序在后台运行时会在顶部有一条蓝色的信息框
//     定位权限为始终的时候，就不会有蓝色框了
//     */
//    self.locationManager.pausesLocationUpdatesAutomatically = NO;   //系统是否可以自行中断程序的定位功能
//    [self keepUpdateLocationWithDesiredAccuracy:desiredAccuracy distanceFilter:distanceFilter block:block fail:fail];
//}

/*
 停止获取定位
 */
- (void)stopUpdateLocaiton {
    [self.locationManager stopUpdatingLocation];
    _keepLocation = NO;
    _locationCallback = nil;
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
}

/*
 获取指南针信息
 */
- (void)updateHeadingToBlock:(HeadingCallback)block {
    _headingCallback = block;
    [self.locationManager startUpdatingHeading];
}

/*
 停止获取指南针信息
 */
- (void)stopUpdateHeading {
    [self.locationManager stopUpdatingHeading];
}

/*
 地理编码
 */
- (void)geocodeAddressString:(NSString *)address block:(PlacemarkCallback)block fail:(FailCallback)fail {
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            if (fail) {
                fail(error);
            }
            return;
        }
        block(placemarks.lastObject);
        
    }];
}

/*
 反地理编码
 */
- (void)reverseGeocodeLocation:(CLLocation *)location block:(PlacemarkCallback)block fail:(FailCallback)fail {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            if (fail) {
                fail(error);
            }
            return;
        }
        //        for (CLPlacemark *placemark in placemarks) {
        //            NSLog(@"%@,%@,%@",placemark.name,placemark.addressDictionary,placemark.location);
        //        }
        block(placemarks.lastObject);
    }];
}

- (void)reverseGeocodeCoordinate:(CLLocationCoordinate2D)coordinate block:(PlacemarkCallback)block fail:(FailCallback)fail {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self reverseGeocodeLocation:location block:block fail:fail];
}

/*
 后台定位低功耗设置,设置后，当定位超过该距离或超过该时间后才会去进行下一次定位，避免多次定位导致耗电量增加
 distance:距离(米)
 timeout:时间(秒)
 */
- (void)delayUpdateLocationWith:(CLLocationDistance)distance timeout:(NSTimeInterval)timeout {
    _delayDistance = distance;
    _delayTime = timeout;
    self.deferringUpdates = YES;
}

/*
 取消低功耗设置
 */
- (void)cancelDelayUpdateLocation {
    self.deferringUpdates = NO;
}

# pragma mark - Lazy load
# pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (_locationCallback) {
        _locationCallback(locations.lastObject);
    }
    if (_keepLocation == NO) {
        [self.locationManager stopUpdatingLocation];
        _locationCallback = nil;
    }
    if (self.deferringUpdates == YES) {
        NSLog(@"低功耗设置");
        [self.locationManager allowDeferredLocationUpdatesUntilTraveled:_delayDistance
                                                                timeout:_delayTime];
    }else {
        NSLog(@"没有低功耗设置");
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if(error.code == kCLErrorLocationUnknown) {
        //        NSLog(@"无法检索位置");
    }
    else if(error.code == kCLErrorNetwork) {
        //        NSLog(@"网络问题");
    }
    else if(error.code == kCLErrorDenied) {
        //        NSLog(@"定位权限的问题");
        [self.locationManager stopUpdatingLocation];
        self.locationManager = nil;
    }
    if (_failCallback) {
        _failCallback(error);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (_headingCallback) {
        _headingCallback(newHeading.magneticHeading);
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户尚未进行选择");
            break;
        case kCLAuthorizationStatusRestricted:
            HZTAlertView(@"提示", @"定位权限被限制", @"确定", nil, ^(NSUInteger index) {
            });
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
        case kCLAuthorizationStatusDenied:
            HZTAlertView(@"提示", @"不允许定位", @"确定", nil, ^(NSUInteger index) {
            });
            break;
        default:
            break;
    }
}

@end
