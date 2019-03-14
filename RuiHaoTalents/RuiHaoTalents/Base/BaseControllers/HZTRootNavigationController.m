//
//  HZTRootNavigationController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTRootNavigationController.h"
#import "HZTLoginViewController.h"
@interface HZTRootNavigationController ()

@end

@implementation HZTRootNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self addObserVers];
    }
    return self;
}

-(void)addObserVers{
    NotificationRegister(HZTNOTIFICATION_SHOULD_LOGIN, self, @selector(shouldLogin), nil);
}

-(void)shouldLogin{
    HZTLoginViewController * login = [[HZTLoginViewController alloc]init];
    [self presentViewController:[[HZTBaseNavigationController alloc] initWithRootViewController:login] animated:YES completion:nil];
}

@end
