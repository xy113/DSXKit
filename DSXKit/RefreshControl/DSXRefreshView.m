//
//  DSXRefreshView.m
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXRefreshView.h"

const CGFloat DSXRefreshHeaderHeight = 64.0;
const CGFloat DSXRefreshFooterHeight = 44.0;
NSString *const DSXRefreshKeyPathContentSize = @"contentSize";
NSString *const DSXRefreshKeyPathContentOffset = @"contentOffset";
NSString *const DSXRefreshKeyPathPanState = @"state";

@implementation DSXRefreshView
@synthesize target = _target;
@synthesize action = _action;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        [self removeObservers];
        self.originY = 0;
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
    [_scrollView addObserver:self forKeyPath:DSXRefreshKeyPathContentOffset options:options context:nil];
    [_scrollView addObserver:self forKeyPath:DSXRefreshKeyPathContentSize options:options context:nil];
    [_pan addObserver:self forKeyPath:DSXRefreshKeyPathPanState options:options context:nil];
}
//移除事件监听
- (void)removeObservers{
    [_scrollView removeObserver:self forKeyPath:DSXRefreshKeyPathContentOffset];
    [_scrollView removeObserver:self forKeyPath:DSXRefreshKeyPathContentSize];
    [_pan removeObserver:self forKeyPath:DSXRefreshKeyPathPanState];
    _pan = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:DSXRefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    // 看不见
    if (self.hidden) return;
    if ([keyPath isEqualToString:DSXRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:DSXRefreshKeyPathPanState]) {
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

- (void)execuAction{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_target respondsToSelector:_action]) {
            DSXRefreshMsgSend(DSXRefreshMsgTarget(_target), _action, self);
        }
    });
}

@end
