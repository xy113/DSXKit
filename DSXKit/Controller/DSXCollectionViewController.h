//
//  DSXCollectionViewController.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+Refresh.h"

NS_ASSUME_NONNULL_BEGIN
@interface DSXCollectionViewController : UIViewController

@property(nonatomic, readonly) UICollectionView * _Nullable collectionView;

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
//设置刷新项
- (void)setRefreshTarget:(nullable id)target action:(nullable SEL)action;
//设置加载项
- (void)setLoadMoreTarget:(nullable id)target action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END
