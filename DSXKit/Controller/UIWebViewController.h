//
//  UIWebViewController.h
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/23.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXRefreshControl.h"
#import "UIScrollView+Refresh.h"
#import "WebViewJavascriptBridge.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIWebViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic, readonly) UIWebView *webView;
@property(nonatomic, readwrite) NSURLRequest *request;
@property(nonatomic, assign)BOOL enableRefresh;
@property(nonatomic, assign)BOOL enableLoadMore;
@property(nonatomic, readonly)DSXRefreshHeader *refreshHeaderView;
@property(nonatomic, readonly)DSXRefreshFooter *refreshFooterView;
@property(nonatomic, retain)WebViewJavascriptBridge *JSBridge;

- (instancetype)init;
//设置刷新项
- (void)setRefreshTarget:(nullable id)target action:(nullable SEL)action;
//设置加载项
- (void)setLoadMoreTarget:(nullable id)target action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END
