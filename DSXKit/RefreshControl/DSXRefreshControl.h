//
//  DSXRefreshControl.h
//  LADZhangWo
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSXRefreshHeader.h"
#import "DSXRefreshFooter.h"

@interface DSXRefreshControl : NSObject

@property(nonatomic,readwrite)DSXRefreshHeader *header;
@property(nonatomic,readwrite)DSXRefreshFooter *footer;
@property(nonatomic,readonly)DSXRefreshState refreshState;
@property(nonatomic,readonly)DSXLoadingState loadingState;
@property(nonatomic,readonly)BOOL isRefreshing;
@property(nonatomic,readonly)BOOL isLoading;

- (instancetype)init;
- (void)beginRefreshing;
- (void)endRefreshing;
- (void)beginLoading;
- (void)endLoading;

@end
