//
//  AppDelegate.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "AppDelegate.h"
#import "HZTRootNavigationController.h"
#import "HZTHomeViewController.h"
#import "HZTCLocationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)initCLocation{
    [[HZTCLocationManager manager] requestPermission];
    [[HZTCLocationManager manager] updateLocationWithDesiredAccuracy:kCLLocationAccuracyBest block:^(CLLocation * location) {
        [[HZTCLocationManager manager] reverseGeocodeLocation:location block:^(CLPlacemark *placemark) {
            [[HZTCLocationManager manager] stopUpdateLocaiton];
            NSMutableDictionary * tempDict = [NSMutableDictionary dictionary];
            /**经度*/
            [tempDict setValue:@(location.coordinate.longitude) forKey:@"longitude"];
            /**纬度*/
            [tempDict setValue:@(location.coordinate.latitude) forKey:@"latitude"];
            /**地理编码城市名称*/
            [tempDict setValue:placemark.addressDictionary[@"City"] forKey:@"LocationCityName"];
            /**地理编码区县名称*/
            [tempDict setValue:placemark.addressDictionary[@"SubLocality"] forKey:@"SubLocality"];
            NotificationPost(HZTNOTIFICATION_UPDATE_USER_LOCATION_SUCCEED,nil, tempDict);
        } fail:^(NSError *error) {
            NSLog(@"反地理编码出错,error: %@",error);
        }];
    } fail:^(NSError *error) {
        
    }];
}

-(void)configRootWindow{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.window.backgroundColor = HZTColorWhiteGround;
    self.window.rootViewController = [[HZTRootNavigationController alloc] initWithRootViewController:[[HZTHomeViewController alloc] init]];
    [self.window makeKeyAndVisible];
}

-(void)configIQKeyboardManager{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

+(void)popToRootViewController{
    HZTRootNavigationController * rootNav = (HZTRootNavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    [rootNav popToViewController:[rootNav.viewControllers firstObject] animated:YES];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initCLocation];
    [self configIQKeyboardManager];
    [self configRootWindow];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
