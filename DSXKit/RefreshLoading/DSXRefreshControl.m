//
//  DSXRefreshHeaderView.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXRefreshControl.h"

NSString *const DSXRefreshStateNormalText = @"下拉刷新当前内容";
NSString *const DSXRefreshStateWillRefreshText = @"松开手立即刷新";
NSString *const DSXRefreshStateRefreshingText = @"正在努力刷新中..";

@implementation DSXRefreshControl
@synthesize isRefreshing  = _isRefreshing;
@synthesize refreshState  = _refreshState;
@synthesize lastUpdateTimeKey = _lastUpdateTimeKey;

+ (instancetype)controlWithBlock:(void (^)(DSXRefreshControl * _Nonnull))refreshBlock{
    DSXRefreshControl *control = [[DSXRefreshControl alloc] init];
    control.refreshBlock = refreshBlock;
    return control;
}

+ (instancetype)controlWithTarget:(id)target action:(SEL)action{
    DSXRefreshControl *control = [[DSXRefreshControl alloc] init];
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
        [self addSubview:_textLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.textColor = [UIColor grayColor];
        [self addSubview:_timeLabel];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 40)];
        _imageView.image = [UIImage imageWithBundleName:@"DSXUI" imageName:@"arrow.png"];;
        [self addSubview:_imageView];
        
        _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_indicator];
        
        _lastUpdateTimeKey = @"lastUpdateTimeKey";
        [self updateLastUpdateTime];
        //设置初始状态
        [self setRefreshState:DSXRefreshStateNormal];
    }
    return self;
}

- (void)setRefreshState:(DSXRefreshState)refreshState{
    _refreshState = refreshState;
    switch (_refreshState) {
        case DSXRefreshStateNormal:
            _textLabel.text = DSXRefreshStateNormalText;
            _imageView.transform = CGAffineTransformMakeRotation(0);
            break;
        case DSXRefreshStateWillRefresh:
            _textLabel.text = DSXRefreshStateWillRefreshText;
            _imageView.transform = CGAffineTransformMakeRotation(M_PI);
            break;
        case DSXRefreshStateRefreshing:
            _textLabel.text = DSXRefreshStateRefreshingText;
            break;
        default:
            _textLabel.text = DSXRefreshStateNormalText;
            break;
    }
    [_textLabel sizeToFit];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}

//开始刷新
- (void)beginRefreshing{
    if (_refreshState != DSXRefreshStateWillRefresh) {
        return;
    }else {
        _isRefreshing = YES;
        _imageView.hidden = YES;
        [_indicator startAnimating];
        [self setRefreshState:DSXRefreshStateRefreshing];
        
        [UIView animateWithDuration:0.3 animations:^{
            UIEdgeInsets inset = _scrollViewOriginInset;
            inset.top = self.height + 10;
            [_scrollView setContentInset:inset];
            //[_scrollView setContentOffset:CGPointMake(0, -top) animated:YES];
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.target respondsToSelector:self.action]) {
                    DSXRefreshMsgSend(DSXRefreshMsgTarget(self.target), self.action, self);
                }
                
                if (_refreshBlock) {
                    _refreshBlock(self);
                }
            });
        }];
    }
}

//刷新结束
- (void)endRefreshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            [_scrollView setContentInset:_scrollViewOriginInset];
        } completion:^(BOOL finished) {
            _isRefreshing = NO;
            _imageView.hidden = NO;
            [_indicator stopAnimating];
            [self setRefreshState:DSXRefreshStateNormal];
            [self updateLastUpdateTime];
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:_lastUpdateTimeKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (_refreshCompletionBlcok) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _refreshCompletionBlcok(self);
                });
            }
        }];
    });
}

- (void)updateLastUpdateTime{
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:_lastUpdateTimeKey];
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @"今天 HH:mm";
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        // 3.显示日期
        _timeLabel.text = [NSString stringWithFormat:@"最后更新: %@", time];
    } else {
        _timeLabel.text = @"最后更新: 无记录";
    }
    [_timeLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        self.height = DSXRefreshControlHeight;
        self.top = -DSXRefreshControlHeight - _scrollViewOriginInset.top;
    }
}

//- (void)didMoveToSuperview{
//    [super didMoveToSuperview];
//    UIView *newSuperview = self.superview;
//    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
//        self.height = DSXRefreshHeaderHeight;
//        self.originY = -DSXRefreshHeaderHeight - _scrollViewOriginInset.top;
//    }
//}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_textLabel sizeToFit];
    [_timeLabel sizeToFit];
    
    CGFloat contentHeight = _textLabel.height + _timeLabel.height;
    _textLabel.center = CGPointMake(self.width/2, (self.height - contentHeight)/2 + _textLabel.height/2);
    _timeLabel.center = CGPointMake(self.width/2, self.height - _timeLabel.height/2 - 10);
    
    CGFloat left = _textLabel.left < _timeLabel.left ? _textLabel.left : _timeLabel.left;
    _imageView.position = CGPointMake(left - 30, (self.height - 40)/2);
    _indicator.position = CGPointMake(left - 40, (self.height - 30)/2);
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_refreshState == DSXRefreshStateWillRefresh) {
        _refreshState = DSXRefreshStateRefreshing;
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    if (_isRefreshing) {
        return;
    }else {
        if (_scrollView.isDragging) {
            CGFloat height = -_scrollView.contentOffset.y - _scrollView.contentInset.top - 20 - self.height;
            if (height > 0 && _refreshState == DSXRefreshStateNormal) {
                [self setRefreshState:DSXRefreshStateWillRefresh];
            }else {
                return;
            }
        }else if(_refreshState == DSXRefreshStateWillRefresh){
            [self beginRefreshing];
            return;
        }
    }
}

@end
