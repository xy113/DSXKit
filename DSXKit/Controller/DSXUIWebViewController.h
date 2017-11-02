//
//  UIWebViewController.h
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/23.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+color.h"
#import "UIScrollView+Refresh.h"

NS_ASSUME_NONNULL_BEGIN

@class WebViewJavascriptBridge;
@interface DSXUIWebViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic, readonly) UIWebView *webView;
@property(nonatomic, readwrite) NSURLRequest *request;
@property(nonatomic, assign) BOOL isRefreshing;
@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, assign) BOOL enablePullDownRefresh;
@property(nonatomic, assign) BOOL enablePullUpLoadMore;
@property(nonatomic, readonly)DSXRefreshControl *dsx_refreshControl;
@property(nonatomic, readonly)DSXLoadingControl *dsx_loadingControl;
@property(nonatomic, copy) void (^refreshBlock)(DSXRefreshControl *refreshControl);
@property(nonatomic, copy) void (^loadingBlock)(DSXLoadingControl *loadingControl);
@property(nonatomic, readonly)WebViewJavascriptBridge *JSBridge;

- (instancetype)init;
//设置刷新项
- (void)setRefreshTarget:(nullable id)target action:(nullable SEL)action;
//设置加载项
- (void)setLoadMoreTarget:(nullable id)target action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END
