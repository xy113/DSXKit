//
//  DSXLoadingFooterView.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXRefreshLoadingView.h"

typedef NS_ENUM(NSInteger,DSXLoadingState) {
    DSXLoadingStateNormal = 0,
    DSXLoadingStateWillLoading = 1,
    DSXLoadingStateLoading = 2,
    DSXLoadingStateNoMoreData = 3
};

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const DSXLoadingStateNormalText;
UIKIT_EXTERN NSString *const DSXLoadingStateWillLoadingText;
UIKIT_EXTERN NSString *const DSXLoadingStateLoadingText;
UIKIT_EXTERN NSString *const DSXLoadingStateNoMoreDataText;

@interface DSXLoadingControl : DSXRefreshLoadingView{
    @private
    UILabel *_textLabel;
    UIActivityIndicatorView *_indicator;
}

@property(nonatomic,readonly)BOOL isLoading;
@property(nonatomic,readwrite)DSXLoadingState loadingState;
@property(nonatomic, copy) void (^loadingBlock)(DSXLoadingControl *loadingControl);
@property(nonatomic, copy) void (^loadingCompletionBlock)(DSXLoadingControl *loadingControl);

+ (instancetype)controlWithBlock:(nullable void (^)(DSXLoadingControl *loadingControl))loadingBlock;
+ (instancetype)controlWithTarget:(nullable id)target action:(nullable SEL)action;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)beginLoading;
- (void)endLoading;

@end
NS_ASSUME_NONNULL_END
