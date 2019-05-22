//
//  HZTWorkExperienceView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTResumeModel.h"
#import "HZTProjiectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTWorkExperienceView : UIView
 +(instancetype)createWorkExperienceView;
/***/
@property (nonatomic, strong) HZTResumeModel * model;
/***/
@property (nonatomic, strong) HZTProjiectModel * projectModel;
@end

NS_ASSUME_NONNULL_END
