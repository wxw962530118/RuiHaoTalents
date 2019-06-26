//
//  UIScrollView+HZTRefresh.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/23.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "UIScrollView+HZTRefresh.h"
#import <MJRefresh.h>
#import <objc/runtime.h>

typedef void(^RefreshBlock)(NSInteger pageIndex);
typedef void(^LoadMoreBlock)(NSInteger pageIndex);
@interface UIScrollView()
/**页码*/
@property (assign, nonatomic) NSInteger pageIndex;
/**下拉时候触发的block*/
@property (nonatomic, copy) RefreshBlock refreshBlock;
/**上拉时候触发的block*/
@property (nonatomic, copy) LoadMoreBlock loadMoreBlock;
@end

@implementation UIScrollView (HZTRefresh)

-(void)beginRefresh{
    [self.mj_header beginRefreshing];
}

- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void(^)(NSInteger pageIndex))refreshBlock{
    __weak typeof(self) weakSelf = self;
    self.refreshBlock = refreshBlock;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf resetPageNum];
        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock(weakSelf.pageIndex);
        }
        [weakSelf endHeaderRefresh];
    }];
    if (beginRefresh && animation) {
        /**有动画的刷新*/
        [self beginHeaderRefresh];
    }else if (beginRefresh && !animation){
        /**没有动画 刷新*/
        [self.mj_header executeRefreshingCallback];
    }
    header.mj_h = 70.0;
    self.mj_header = header;
}

- (void)addFooterWithWithHeaderWithAutoRefresh:(BOOL)autoRefresh loadMoreBlock:(void(^)(NSInteger pageIndex))loadMoreBlock{
    self.loadMoreBlock = loadMoreBlock;
    if (autoRefresh) {
        MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            if (self.loadMoreBlock) {
                self.loadMoreBlock(self.pageIndex);
            }
        }];
        footer.automaticallyRefresh = autoRefresh;
        footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
        footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"~~已经全部加载完毕哦O(∩_∩)O~~" forState:MJRefreshStateNoMoreData];
        
        self.mj_footer = footer;
    }
    else{
        MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            if (self.loadMoreBlock) {
                self.loadMoreBlock(self.pageIndex);
            }
        }];
        
        footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
        footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"~~已经全部加载完毕哦O(∩_∩)O~~" forState:MJRefreshStateNoMoreData];
        self.mj_footer = footer;
    }
}

-(void)beginHeaderRefresh {
    [self resetPageNum];
    [self.mj_header beginRefreshing];
}

- (void)resetPageNum {
    self.pageIndex = 0;
}

- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
}

-(void)endHeaderRefresh {
    [self.mj_header endRefreshing];
    [self resetNoMoreData];
}

-(void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}

- (void)endFooterNoMoreData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshingWithNoMoreData];
    });
}

static void * pagaIndexKey = &pagaIndexKey;
- (void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, &pagaIndexKey, @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)pageIndex{
    return [objc_getAssociatedObject(self, &pagaIndexKey) integerValue];
}

static void * RefreshBlockKey = &RefreshBlockKey;
- (void)setRefreshBlock:(void (^)(void))RefreshBlock{
    objc_setAssociatedObject(self, &RefreshBlockKey, RefreshBlock, OBJC_ASSOCIATION_COPY);
}

- (RefreshBlock)refreshBlock{
    return objc_getAssociatedObject(self, &RefreshBlockKey);
}

static void *LoadMoreBlockKey = &LoadMoreBlockKey;
- (void)setLoadMoreBlock:(LoadMoreBlock)loadMoreBlock{
    objc_setAssociatedObject(self, &LoadMoreBlockKey, loadMoreBlock, OBJC_ASSOCIATION_COPY);
}

- (LoadMoreBlock)loadMoreBlock{
    return objc_getAssociatedObject(self, &LoadMoreBlockKey);
}

-(void)handleScrollIndicatorInsets{
    self.contentInset = UIEdgeInsetsMake(IS_IPhoneX() ? 88 : 64, 0, 0, 0);
    self.scrollIndicatorInsets = self.contentInset;
}

@end
