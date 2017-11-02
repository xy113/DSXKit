//
//  DSXRefreshHeaderView.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXRefreshLoadingView.h"
#import "UIImage+DSXAdd.h"

typedef NS_ENUM(NSInteger,DSXRefreshState){
    DSXRefreshStateNormal = 0,
    DSXRefreshStateWillRefresh = 1,
    DSXRefreshStateRefreshing = 2,
};

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const DSXRefreshStateNormalText;
UIKIT_EXTERN NSString *const DSXRefreshStateWillRefreshText;
UIKIT_EXTERN NSString *const DSXRefreshStateRefreshingText;

@interface DSXRefreshControl : DSXRefreshLoadingView{
    @private
    UILabel *_textLabel, *_timeLabel;
    UIImageView *_imageView;
    UIActivityIndicatorView *_indicator;
}

//是否正在刷新
@property(nonatomic,assign)BOOL isRefreshing;
@property(nonatomic,strong)NSString *lastUpdateTimeKey;
@property(nonatomic, copy) void (^refreshBlock)(DSXRefreshControl *refreshControl);
@property(nonatomic, copy) void (^refreshCompletionBlcok)(DSXRefreshControl *refreshControl);
//当前状态
@property(nonatomic,readwrite)DSXRefreshState refreshState;

+ (instancetype)controlWithBlock:(nullable void (^)(DSXRefreshControl *refreshControl))refreshBlock;
+ (instancetype)controlWithTarget:(nullable id)target action:(nullable SEL)action;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)beginRefreshing;
- (void)endRefreshing;

@end
NS_ASSUME_NONNULL_END
