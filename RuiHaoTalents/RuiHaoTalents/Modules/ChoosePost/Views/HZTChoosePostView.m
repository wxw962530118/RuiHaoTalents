//
//  HZTChoosePostView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTChoosePostView.h"
#import "HZTChoosePostCell.h"

@interface HZTChoosePostView ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/***/
@property (nonatomic, copy) void (^Block)(NSString * name,NSString * Id,MenuLevelType type);
/***/
@property (nonatomic, assign) MenuLevelType type;
@end

@implementation HZTChoosePostView

-(instancetype)initWithType:(MenuLevelType)type callBack:(void (^)(NSString * _Nonnull, NSString * _Nonnull, MenuLevelType))callBack{
    if (self = [super init]) {
        self.type = type;
        self.Block = callBack;
    }
    return self;
}

-(void)setDataArray:(NSMutableArray<HZTChoosePostModel *> *)dataArray{
    _dataArray = dataArray;
    [self.mainTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZTChoosePostCell * cell = [HZTChoosePostCell cellWithTableViewFromXIB:tableView];
    cell.model = self.dataArray[indexPath.section];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.Block) {
        self.Block(self.dataArray[indexPath.section].name, self.dataArray[indexPath.section].id, self.type);
    }
}

#pragma mark --- 懒加载相关
-(UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self);
        }];
    }
    return _mainTableView;
}
@end
