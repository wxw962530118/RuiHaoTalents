//
//  HZTBaseNavigationController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseNavigationController.h"

@interface HZTBaseNavigationController ()

@end

@implementation HZTBaseNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HZTColorEmphasis,NSFontAttributeName:HZTFontSize(17)}];

        [self.navigationBar setTranslucent:false];
    }
    return self;
}

@end
