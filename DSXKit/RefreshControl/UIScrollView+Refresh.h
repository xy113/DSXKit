//
//  UIScrollView+Refresh.h
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXRefreshControl.h"

@interface UIScrollView (Refresh)

@property(nonatomic,readwrite,retain)DSXRefreshHeader *dsx_header;
@property(nonatomic,readwrite,retain)DSXRefreshFooter *dsx_footer;
@property(nonatomic,readwrite,retain)DSXRefreshControl *dsx_refreshControl;

@end
