//
//  DSXRefreshView.m
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXRefreshLoadingView.h"

const CGFloat DSXRefreshControlHeight = 64.0;
const CGFloat DSXLoadingControlHeight = 44.0;
NSString *const DSXRefreshLoadingKeyPathContentSize = @"contentSize";
NSString *const DSXRefreshLoadingKeyPathContentOffset = @"contentOffset";
NSString *const DSXRefreshLoadingKeyPathPanState = @"state";

@implementation DSXRefreshLoadingView
@synthesize target = _target;
@synthesize action = _action;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        [self removeObservers];
        self.top = 0;
        self.width = newSuperview.width;
        _scrollView = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
        _scrollViewOriginInset = _scrollView.contentInset;
        [self addObservers];
    }else {
        return;
    }
}

//- (void)didMoveToSuperview{
//    [super didMoveToSuperview];
//    UIView *newSuperview = self.superview;
//    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
//        [self removeObservers];
//        _scrollView = (UIScrollView *)newSuperview;
//        _scrollView.alwaysBounceVertical = YES;
//        _scrollViewOriginInset = _scrollView.contentInset;
//        [self addObservers];
//    }else {
//        return;
//    }
//}

#pragma mark - KVO监听
//添加事件监听
- (void)addObservers{
    _pan = _scrollView.panGestureRecognizer;
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [_scrollView addObserver:self forKeyPath:DSXRefreshLoadingKeyPathContentOffset options:options context:nil];
    [_scrollView addObserver:self forKeyPath:DSXRefreshLoadingKeyPathContentSize options:options context:nil];
    [_pan addObserver:self forKeyPath:DSXRefreshLoadingKeyPathPanState options:options context:nil];
}
//移除事件监听
- (void)removeObservers{
    [_scrollView removeObserver:self forKeyPath:DSXRefreshLoadingKeyPathContentOffset];
    [_scrollView removeObserver:self forKeyPath:DSXRefreshLoadingKeyPathContentSize];
    [_pan removeObserver:self forKeyPath:DSXRefreshLoadingKeyPathPanState];
    _pan = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:DSXRefreshLoadingKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    // 看不见
    if (self.hidden) return;
    if ([keyPath isEqualToString:DSXRefreshLoadingKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:DSXRefreshLoadingKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}

//==============
- (void)setTarget:(id)target{
    _target = target;
}

- (void)setAction:(SEL)action{
    _action = action;
}

- (void)setTarget:(id)target action:(SEL)action{
    _target = target;
    _action = action;
}

@end
