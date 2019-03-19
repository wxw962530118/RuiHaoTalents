//
//  HZTMyResumeCustomCell.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTProjiectModel.h"
#import "HZTResumeModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,MyResumeCellCallBackType){
    MyResumeCellCallBackType_Delete,     /**添加*/
    MyResumeCellCallBackType_LookMore   /**查看更多*/
};

@interface HZTMyResumeCustomCell : UITableViewCell
/**项目经验*/
@property (nonatomic, strong) HZTProjiectModel * projiectModel;
/**工作经历*/
@property (nonatomic, strong) HZTResumeModel * resumeModel;
/***/
@property (nonatomic, copy) void (^callBack)(MyResumeCellCallBackType type);
@end

NS_ASSUME_NONNULL_END
