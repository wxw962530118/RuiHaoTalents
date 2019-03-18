//
//  HZTMyResumeHeaderView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTMyResumeListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTMyResumeHeaderView : UIView
+(instancetype)createMyResumeHeaderView;
/***/
@property (nonatomic, strong) HZTMyResumeListModel * listModel;
@end

NS_ASSUME_NONNULL_END
