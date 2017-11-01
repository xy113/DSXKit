//
//  DSXRefreshHeader.m
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXRefreshHeader.h"
NSString *const DSXRefreshStateNormalText = @"下拉刷新当前内容";
NSString *const DSXRefreshStateWillRefreshText = @"松开手立即刷新";
NSString *const DSXRefreshStateRefreshingText = @"正在努力刷新中..";

@implementation DSXRefreshHeader
@synthesize image = _image;
@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;
@synthesize timeLabel = _timeLabel;
@synthesize indicator = _indicator;
@synthesize isRefreshing  = _isRefreshing;
@synthesize refreshState  = _refreshState;
@synthesize lastUpdateTimeKey = _lastUpdateTimeKey;

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _lastUpdateTimeKey = @"lastUpdateTimeKey";
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_textLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.textColor = [UIColor grayColor];
        [self addSubview:_timeLabel];
        [self updateLastUpdateTime];
        
        _image = [UIImage imageWithBundleName:@"DSXUI" imageName:@"arrow.png"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 40)];
        _imageView.image = _image;
        [self addSubview:_imageView];
        
        _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_indicator];
        [self setRefreshState:DSXRefreshStateNormal];
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    _imageView.image = image;
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
        
        [UIView animateWithDuration:0.3f animations:^{
            UIEdgeInsets inset = _scrollViewOriginInset;
            inset.top = self.height + 10;
            [_scrollView setContentInset:inset];
            //[_scrollView setContentOffset:CGPointMake(0, -top) animated:YES];
        } completion:^(BOOL finished) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self execuAction];
                });
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self endRefreshing];
                });
            });
        }];
    }
}

//刷新结束
- (void)endRefreshing{
    [UIView animateWithDuration:0.3f animations:^{
        [_scrollView setContentInset:_scrollViewOriginInset];
    } completion:^(BOOL finished) {
        _isRefreshing = NO;
        _imageView.hidden = NO;
        [_indicator stopAnimating];
        [self setRefreshState:DSXRefreshStateNormal];
        [self updateLastUpdateTime];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:_lastUpdateTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
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
        self.height = DSXRefreshHeaderHeight;
        self.originY = -DSXRefreshHeaderHeight - _scrollViewOriginInset.top;
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
    _textLabel.frame = CGRectMake((self.width - _textLabel.width)/2, 10, _textLabel.width, 20);
    _timeLabel.frame = CGRectMake((self.width - _timeLabel.width)/2, 35, _timeLabel.width, 12);
    _imageView.frame = CGRectMake(_textLabel.originX - 30, (self.height - 40)/2-2, 17, 40);
    _indicator.frame = CGRectMake(_textLabel.originX - 40, (self.height - 30)/2, 30, 30);
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
