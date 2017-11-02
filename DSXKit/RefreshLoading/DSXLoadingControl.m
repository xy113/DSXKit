//
//  DSXLoadingFooterView.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXLoadingControl.h"

NSString *const DSXLoadingStateNormalText = @"上拉加载更多数据";
NSString *const DSXLoadingStateWillLoadingText = @"松开手立即加载";
NSString *const DSXLoadingStateLoadingText = @"正在加载数据..";
NSString *const DSXLoadingStateNoMoreDataText = @"没有更多内容了";

@implementation DSXLoadingControl

+ (instancetype)controlWithBlock:(void (^)(DSXLoadingControl * _Nonnull))loadingBlock{
    DSXLoadingControl *control = [[DSXLoadingControl alloc] init];
    control.loadingBlock = loadingBlock;
    return control;
}

+ (instancetype)controlWithTarget:(id)target action:(SEL)action{
    DSXLoadingControl *control = [[DSXLoadingControl alloc] init];
    control.target = target;
    control.action = action;
    return control;
}

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
        //设置初始状态
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
        inset.bottom = DSXRefreshControlHeight + 20;
        [UIView animateWithDuration:0.3f animations:^{
            [_scrollView setContentInset:inset];
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.target respondsToSelector:self.action]) {
                    DSXRefreshMsgSend(DSXRefreshMsgTarget(self.target), self.action, self);
                }
                
                if (self.loadingBlock) {
                    self.loadingBlock(self);
                }
            });
            
        }];
    }
}

- (void)endLoading{
    [UIView animateWithDuration:0.3 animations:^{
        [_scrollView setContentInset:_scrollViewOriginInset];
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _isLoading = NO;
            [_indicator stopAnimating];
            [self setLoadingState:DSXLoadingStateNormal];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.loadingCompletionBlock) {
                    self.loadingCompletionBlock(self);
                }
            });
        });
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _textLabel.center = CGPointMake(self.width/2, self.height/2);
    _indicator.position = CGPointMake(_textLabel.left - _indicator.width - 10, (self.height - _indicator.height)/2);
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        CGRect rect = CGRectMake(0, _scrollView.contentSize.height, _scrollView.width, DSXLoadingControlHeight);
        [self setFrame:rect];
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
    self.top = _scrollView.contentSize.height;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    if (self.loadingState == DSXLoadingStateLoading || self.loadingState == DSXLoadingStateNoMoreData || self.top == 0) {
        return;
    }
    
    if (_scrollView.isDragging) {
        CGFloat height = _scrollView.height + _scrollView.contentOffset.y - _scrollView.contentSize.height - _scrollView.contentInset.bottom;
        if (height > (DSXLoadingControlHeight + 20) && self.loadingState == DSXLoadingStateNormal) {
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
