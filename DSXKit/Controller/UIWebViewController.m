//
//  UIWebViewController.m
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/23.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import "UIWebViewController.h"

@implementation UIWebViewController
@synthesize webView = _webView;
@synthesize request = _request;
@synthesize enableRefresh = _enableRefresh;
@synthesize enableLoadMore = _enableLoadMore;
@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize refreshFooterView = _refreshFooterView;
@synthesize JSBridge = _JSBridge;

- (instancetype)init{
    if (self = [super init]) {
        _webView = [[UIWebView alloc] init];
        [_webView loadHTMLString:@"<html><head><title></title></head><body></body></html>" baseURL:nil];
        _refreshHeaderView = [[DSXRefreshHeader alloc] init];
        _refreshFooterView = [[DSXRefreshFooter alloc] init];
        _JSBridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
        [_JSBridge setWebViewDelegate:self];
    }
    return self;
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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)setRequest:(NSURLRequest *)request{
    _request = request;
    [_webView loadRequest:request];
}

- (void)setEnableRefresh:(BOOL)enableRefresh{
    _enableRefresh = enableRefresh;
    if (enableRefresh) {
        _webView.scrollView.dsx_header = _refreshHeaderView;
    }else {
        _webView.scrollView.dsx_footer = nil;
    }
}

- (void)setEnableLoadMore:(BOOL)enableLoadMore{
    _enableLoadMore = enableLoadMore;
    if (enableLoadMore) {
        _webView.scrollView.dsx_footer = _refreshFooterView;
    }else {
        _webView.scrollView.dsx_footer = nil;
    }
}

- (void)setRefreshTarget:(id)target action:(SEL)action{
    [_refreshHeaderView setTarget:target action:action];
}

- (void)setLoadMoreTarget:(id)target action:(SEL)action{
    [_refreshFooterView setTarget:target action:action];
}

@end
