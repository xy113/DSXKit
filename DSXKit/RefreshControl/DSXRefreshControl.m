//
//  DSXRefreshControl.m
//  LADZhangWo
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXRefreshControl.h"

@implementation DSXRefreshControl
@synthesize header   = _header;
@synthesize footer   = _footer;
@synthesize loadingState = _loadingState;
@synthesize refreshState = _refreshState;
@synthesize isRefreshing = _isRefreshing;
@synthesize isLoading = _isLoading;

- (instancetype)init{
    if (self = [super init]) {
        _header = [[DSXRefreshHeader alloc] init];
        _footer = [[DSXRefreshFooter alloc] init];
    }
    return self;
}

- (DSXRefreshState)refreshState{
    return [_header refreshState];
}

- (DSXLoadingState)loadingState{
    return [_footer loadingState];
}

- (BOOL)isRefreshing{
    return [_header isRefreshing];
}

- (BOOL)isLoading{
    return [_footer isLoading];
}

- (void)beginRefreshing{
    [_header beginRefreshing];
}

- (void)endRefreshing{
    [_header endRefreshing];
}

- (void)beginLoading{
    [_footer beginLoading];
}

- (void)endLoading{
    [_footer endLoading];
}

@end
