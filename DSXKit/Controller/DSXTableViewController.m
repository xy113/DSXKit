//
//  DSXTableViewController.m
//  XiangBaLao
//
//  Created by Apple on 16/1/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXTableViewController.h"

@implementation DSXTableViewController

- (instancetype)init{
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super init]) {
        self.pageSize = 20;
        self.currentPage  = 1;
        self.isRefreshing = NO;
        _dataList  = [[NSMutableArray alloc] init];
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
        _dsx_refreshControl = [[DSXRefreshControl alloc] init];
        _dsx_loadingControl = [[DSXLoadingControl alloc] init];
    }
    return self;
}

- (void)setEnablePullDownRefresh:(BOOL)enablePullDownRefresh{
    _enablePullDownRefresh = enablePullDownRefresh;
    if (enablePullDownRefresh) {
        self.tableView.dsx_refreshControl = self.dsx_refreshControl;
    }else {
        self.tableView.dsx_refreshControl = nil;
    }
}

- (void)setEnablePullUpLoadMore:(BOOL)enablePullUpLoadMore{
    _enablePullUpLoadMore = enablePullUpLoadMore;
    if (enablePullUpLoadMore) {
        self.tableView.dsx_loadingControl = self.dsx_loadingControl;
    }else {
        self.tableView.dsx_loadingControl = nil;
    }
}

- (void)setRefreshBlock:(void (^)(DSXRefreshControl * _Nonnull))refreshBlock{
    _refreshBlock = refreshBlock;
    self.dsx_refreshControl.refreshBlock = refreshBlock;
}

- (void)setLoadingBlock:(void (^)(DSXLoadingControl * _Nonnull))loadingBlock{
    _loadingBlock = loadingBlock;
    self.dsx_loadingControl.loadingBlock = loadingBlock;
}

- (void)setRefreshTarget:(id)target action:(SEL)action{
    [self.dsx_refreshControl setTarget:target action:action];
}

- (void)setLoadMoreTarget:(id)target action:(SEL)action{
    [self.dsx_loadingControl setTarget:target action:action];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.frame = self.view.bounds;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tableView.tableFooterView  = [[UIView alloc] init];
    self.tableView.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

@end
