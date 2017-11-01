//
//  DSXTableViewController.h
//  XiangBaLao
//
//  Created by Apple on 16/1/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXRefreshControl.h"
#import "UIScrollView+Refresh.h"

NS_ASSUME_NONNULL_BEGIN
@interface DSXTableViewController : UIViewController

@property(nonatomic,readonly)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSArray *moreData;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)BOOL isRefreshing;
@property(nonatomic,assign)BOOL enableRefresh;
@property(nonatomic,assign)BOOL enableLoadMore;
@property(nonatomic, readonly)DSXRefreshHeader *refreshHeaderView;
@property(nonatomic, readonly)DSXRefreshFooter *refreshFooterView;

- (instancetype)init;
- (instancetype)initWithStyle:(UITableViewStyle)style;
//设置刷新项
- (void)setRefreshTarget:(nullable id)target action:(nullable SEL)action;
//设置加载项
- (void)setLoadMoreTarget:(nullable id)target action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END
