//
//  DSXTableViewController.h
//  XiangBaLao
//
//  Created by Apple on 16/1/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+Refresh.h"

NS_ASSUME_NONNULL_BEGIN
@interface DSXTableViewController : UIViewController

@property(nonatomic, readonly) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) NSArray *moreData;
@property(nonatomic, assign) NSInteger currentPage;
@property(nonatomic, assign) NSInteger pageSize;
@property(nonatomic, assign) BOOL isRefreshing;
@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, assign) BOOL enablePullDownRefresh;
@property(nonatomic, assign) BOOL enablePullUpLoadMore;
@property(nonatomic, readonly)DSXRefreshControl *dsx_refreshControl;
@property(nonatomic, readonly)DSXLoadingControl *dsx_loadingControl;
@property(nonatomic, copy) void (^refreshBlock)(DSXRefreshControl *refreshControl);
@property(nonatomic, copy) void (^loadingBlock)(DSXLoadingControl *loadingControl);

- (instancetype)init;
- (instancetype)initWithStyle:(UITableViewStyle)style;
//设置刷新项
- (void)setRefreshTarget:(nullable id)target action:(nullable SEL)action;
//设置加载项
- (void)setLoadMoreTarget:(nullable id)target action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END
