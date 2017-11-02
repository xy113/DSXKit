//
//  UIScrollView+Refresh.m
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import <objc/runtime.h>

static NSString *const DSXRefreshControlKey = @"DSXRefreshControlKey";
static NSString *const DSXLoadingControlKey = @"DSXLoadingControlKey";

@implementation UIScrollView(Refresh)

- (DSXRefreshControl *)dsx_refreshControl{
    return objc_getAssociatedObject(self, &DSXRefreshControlKey);
}

- (void)setDsx_refreshControl:(DSXRefreshControl *)dsx_refreshControl{
    if (self.dsx_refreshControl != dsx_refreshControl) {
        [self.dsx_refreshControl removeFromSuperview];
        [self insertSubview:dsx_refreshControl atIndex:0];
        
        [self willChangeValueForKey:DSXRefreshControlKey];
        objc_setAssociatedObject(self, &DSXRefreshControlKey, dsx_refreshControl, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:DSXRefreshControlKey];
    }
}

- (DSXLoadingControl *)dsx_loadingControl{
    return objc_getAssociatedObject(self, &DSXLoadingControlKey);
}

- (void)setDsx_loadingControl:(DSXLoadingControl *)dsx_loadingControl{
    if (self.dsx_loadingControl != dsx_loadingControl) {
        [self.dsx_loadingControl removeFromSuperview];
        [self insertSubview:dsx_loadingControl atIndex:0];
        
        [self willChangeValueForKey:DSXLoadingControlKey];
        objc_setAssociatedObject(self, &DSXLoadingControlKey, dsx_loadingControl, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:DSXLoadingControlKey];
    }
}

@end
