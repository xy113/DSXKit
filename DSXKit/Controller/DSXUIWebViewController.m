//
//  UIWebViewController.m
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/23.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import "DSXUIWebViewController.h"
#import "WebViewJavascriptBridge.h"

@implementation DSXUIWebViewController

- (instancetype)init{
    if (self = [super init]) {
        _webView = [[UIWebView alloc] init];
        [_webView loadHTMLString:@"<html><head><title></title></head><body></body></html>" baseURL:nil];

        _JSBridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
        [_JSBridge setWebViewDelegate:self];
        
        _dsx_refreshControl = [[DSXRefreshControl alloc] init];
        _dsx_loadingControl = [[DSXLoadingControl alloc] init];
    }
    return self;
}

- (void)setEnablePullDownRefresh:(BOOL)enablePullDownRefresh{
    _enablePullDownRefresh = enablePullDownRefresh;
    if (enablePullDownRefresh) {
        self.webView.scrollView.dsx_refreshControl = self.dsx_refreshControl;
    }else {
        self.webView.scrollView.dsx_refreshControl = nil;
    }
}

- (void)setEnablePullUpLoadMore:(BOOL)enablePullUpLoadMore{
    _enablePullUpLoadMore = enablePullUpLoadMore;
    if (enablePullUpLoadMore) {
        self.webView.scrollView.dsx_loadingControl = self.dsx_loadingControl;
    }else {
        self.webView.scrollView.dsx_loadingControl = nil;
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

- (void)setRequest:(NSURLRequest *)request{
    _request = request;
    [_webView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.frame = self.view.bounds;
    _webView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    //_webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_webView];
}

@end
