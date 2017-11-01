//
//  UIScrollView+Refresh.m
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import <objc/runtime.h>

static NSString *const DSXRefreshKeyHeader = @"dsx_header";
static NSString *const DSXRefreshKeyFooter = @"dsx_footer";
static NSString *const DSXRefreshKeyRefreshControl = @"dsx_refreshControl";
@implementation UIScrollView(Refresh)

- (DSXRefreshHeader *)dsx_header{
    return objc_getAssociatedObject(self, &DSXRefreshKeyHeader);
}
- (void)setDsx_header:(DSXRefreshHeader *)dsx_header{
    if (self.dsx_header != dsx_header) {
        [self.dsx_header removeFromSuperview];
        [self insertSubview:dsx_header atIndex:0];
        
        [self willChangeValueForKey:DSXRefreshKeyHeader];
        objc_setAssociatedObject(self, &DSXRefreshKeyHeader, dsx_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:DSXRefreshKeyHeader];
    }
}

- (DSXRefreshFooter *)dsx_footer{
    return objc_getAssociatedObject(self, &DSXRefreshKeyFooter);
}

- (void)setDsx_footer:(DSXRefreshFooter *)dsx_footer{
    if (self.dsx_footer != dsx_footer) {
        [self.dsx_footer removeFromSuperview];
        [self addSubview:dsx_footer];
        
        [self willChangeValueForKey:DSXRefreshKeyFooter];
        objc_setAssociatedObject(self, &DSXRefreshKeyFooter, dsx_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:DSXRefreshKeyFooter];
    }
}

- (DSXRefreshControl *)dsx_refreshControl{
    return objc_getAssociatedObject(self, &DSXRefreshKeyRefreshControl);
}

- (void)setDsx_refreshControl:(DSXRefreshControl *)dsx_refreshControl{
    if (self.dsx_refreshControl != dsx_refreshControl) {
        self.dsx_header = dsx_refreshControl.header;
        self.dsx_footer = dsx_refreshControl.footer;
        [self willChangeValueForKey:DSXRefreshKeyRefreshControl];
        objc_setAssociatedObject(self, &DSXRefreshKeyRefreshControl, dsx_refreshControl, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:DSXRefreshKeyRefreshControl];
    }
}

@end
