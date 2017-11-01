//
//  DSXRefreshFooter.m
//  LADZhangWo
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXRefreshFooter.h"

NSString *const DSXLoadingStateNormalText = @"上拉加载更多数据";
NSString *const DSXLoadingStateWillLoadingText = @"松开手立即加载";
NSString *const DSXLoadingStateLoadingText = @"正在加载数据..";
NSString *const DSXLoadingStateNoMoreDataText = @"没有更多内容了";

@implementation DSXRefreshFooter
@synthesize isLoading = _isLoading;
@synthesize loadingState = _loadingState;

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:13.0];
        _textLabel.textColor = [UIColor grayColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_indicator];
        [self setLoadingState:DSXLoadingStateNormal];
    }
    return self;
}

- (void)setLoadingState:(DSXLoadingState)loadingState{
    _loadingState = loadingState;
    switch (loadingState) {
        case DSXLoadingStateNormal:
            _textLabel.text = DSXLoadingStateNormalText;
            break;
        case DSXLoadingStateWillLoading:
            _textLabel.text = DSXLoadingStateWillLoadingText;
            break;
        case DSXLoadingStateLoading:
            _textLabel.text = DSXLoadingStateLoadingText;
            break;
        case DSXLoadingStateNoMoreData:
            _textLabel.text = DSXLoadingStateNoMoreDataText;
            break;
        default:
            _textLabel.text = DSXLoadingStateNormalText;
    }
    [_textLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)beginLoading{
    if (_isLoading) {
        return;
    }else {
        _isLoading = YES;
        [_indicator startAnimating];
        [self setLoadingState:DSXLoadingStateLoading];
        
        UIEdgeInsets inset = _scrollViewOriginInset;
        inset.bottom = DSXRefreshFooterHeight + 20;
        [UIView animateWithDuration:0.3f animations:^{
            [_scrollView setContentInset:inset];
        } completion:^(BOOL finished) {
            [self execuAction];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self endLoading];
            });
        }];
    }
}

- (void)endLoading{
    [UIView animateWithDuration:0.3f animations:^{
        [_scrollView setContentInset:_scrollViewOriginInset];
    } completion:^(BOOL finished) {
        _isLoading = NO;
        [_indicator stopAnimating];
        [self setLoadingState:DSXLoadingStateNormal];
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _textLabel.frame = CGRectMake((self.width - _textLabel.width)/2, 10, _textLabel.width, 30);
    _indicator.frame = CGRectMake(_textLabel.originX - 30, 10, 30, 30);
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        CGRect rect = CGRectMake(0, _scrollView.contentSize.height, _scrollView.width, DSXRefreshFooterHeight);
        [self setFrame:rect];
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
    self.originY = _scrollView.contentSize.height;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    if (self.loadingState == DSXLoadingStateLoading || self.loadingState == DSXLoadingStateNoMoreData || self.originY == 0) {
        return;
    }
    
    if (_scrollView.isDragging) {
        CGFloat height = _scrollView.height + _scrollView.contentOffset.y - _scrollView.contentSize.height - _scrollView.contentInset.bottom;
        if (height > (DSXRefreshFooterHeight + 20) && self.loadingState == DSXLoadingStateNormal) {
            CGPoint newPoint = [[change objectForKey:@"new"] CGPointValue];
            CGPoint oldPoint = [[change objectForKey:@"old"] CGPointValue];
            if (newPoint.y <= oldPoint.y) {
                return;
            }else{
                [self setLoadingState:DSXLoadingStateWillLoading];
            }
        }else {
            return;
        }
    }else if(_loadingState == DSXLoadingStateWillLoading){
        [self beginLoading];
        return;
    }
}

@end
