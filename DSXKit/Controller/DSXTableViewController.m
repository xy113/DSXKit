//
//  DSXTableViewController.m
//  XiangBaLao
//
//  Created by Apple on 16/1/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXTableViewController.h"

@implementation DSXTableViewController
@synthesize tableView = _tableView;
@synthesize dataList  = _dataList;
@synthesize moreData  = _moreData;
@synthesize isRefreshing   = _isRefreshing;
@synthesize enableRefresh  = _enableRefresh;
@synthesize enableLoadMore = _enableLoadMore;
@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize refreshFooterView = _refreshFooterView;

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
        _refreshHeaderView = [[DSXRefreshHeader alloc] init];
        _refreshFooterView = [[DSXRefreshFooter alloc] init];
    }
    return self;
}

- (void)setEnableRefresh:(BOOL)enableRefresh{
    _enableRefresh = enableRefresh;
    if (enableRefresh) {
        _tableView.dsx_header = _refreshHeaderView;
    }else {
        _tableView.dsx_header = nil;
    }
}

- (void)setEnableLoadMore:(BOOL)enableLoadMore{
    _enableLoadMore = enableLoadMore;
    if (enableLoadMore) {
        _tableView.dsx_footer = _refreshFooterView;
    }else {
        _tableView.dsx_footer = nil;
    }
}

- (void)setRefreshTarget:(id)target action:(SEL)action{
    [_refreshHeaderView setTarget:target action:action];
}

- (void)setLoadMoreTarget:(id)target action:(SEL)action{
    [_refreshFooterView setTarget:target action:action];
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
