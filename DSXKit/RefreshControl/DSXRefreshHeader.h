//
//  DSXRefreshHeader.h
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXRefreshView.h"
#import "UIImage+Bundle.h"

typedef NS_ENUM(NSInteger,DSXRefreshState){
    DSXRefreshStateNormal = 0,
    DSXRefreshStateWillRefresh = 1,
    DSXRefreshStateRefreshing = 2,
};

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString *const DSXRefreshStateNormalText;
UIKIT_EXTERN NSString *const DSXRefreshStateWillRefreshText;
UIKIT_EXTERN NSString *const DSXRefreshStateRefreshingText;

@interface DSXRefreshHeader : DSXRefreshView

@property(nonatomic,readonly)UILabel *textLabel;
@property(nonatomic,readonly)UILabel *timeLabel;
@property(nonatomic,readwrite)UIImage *image;
@property(nonatomic,readonly)UIImageView *imageView;
@property(nonatomic,readonly)UIActivityIndicatorView *indicator;
@property(nonatomic,assign)BOOL isRefreshing;
@property(nonatomic,strong)NSString *lastUpdateTimeKey;
@property(nonatomic,readwrite)DSXRefreshState refreshState;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)beginRefreshing;
- (void)endRefreshing;

@end
NS_ASSUME_NONNULL_END
