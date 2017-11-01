//
//  DSXRefreshView.h
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Size.h"
#import <objc/runtime.h>
#import <objc/message.h>

// 运行时objc_msgSend
#define DSXRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define DSXRefreshMsgTarget(target) (__bridge void *)(target)

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN CGFloat const DSXRefreshHeaderHeight;
UIKIT_EXTERN CGFloat const DSXRefreshFooterHeight;
UIKIT_EXTERN NSString *const DSXRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const DSXRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const DSXRefreshKeyPathPanState;


@interface DSXRefreshView : UIView{
    UIPanGestureRecognizer *_pan;
    UIScrollView *_scrollView;
    UIEdgeInsets _scrollViewOriginInset;
}

@property(nonatomic, assign)id target;
@property(nonatomic, assign)SEL action;

- (instancetype)initWithFrame:(CGRect)frame;

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

- (void)setTarget:(nullable id)target action:(nullable SEL)action;
- (void)execuAction;

@end
NS_ASSUME_NONNULL_END
