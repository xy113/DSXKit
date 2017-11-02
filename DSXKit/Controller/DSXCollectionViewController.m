//
//  DSXCollectionViewController.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXCollectionViewController.h"

@implementation DSXCollectionViewController

- (instancetype)init{
    if (self = [super init]) {
        self.pageSize = 20;
        self.currentPage  = 1;
        self.isRefreshing = NO;
        self.dataList  = [[NSMutableArray alloc] init];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_collectionView];
        
        _dsx_refreshControl = [[DSXRefreshControl alloc] init];
        _dsx_loadingControl = [[DSXLoadingControl alloc] init];
    }
    return self;
}

- (void)setEnablePullDownRefresh:(BOOL)enablePullDownRefresh{
    _enablePullDownRefresh = enablePullDownRefresh;
    if (enablePullDownRefresh) {
        self.collectionView.dsx_refreshControl = self.dsx_refreshControl;
    }else {
        self.collectionView.dsx_refreshControl = nil;
    }
}

- (void)setEnablePullUpLoadMore:(BOOL)enablePullUpLoadMore{
    _enablePullUpLoadMore = enablePullUpLoadMore;
    if (enablePullUpLoadMore) {
        self.collectionView.dsx_loadingControl = self.dsx_loadingControl;
    }else {
        self.collectionView.dsx_loadingControl = nil;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.frame = self.view.bounds;
}


@end
