//
//  UIScrollView+Refresh.h
//  LADZhangWo
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXRefreshControl.h"
#import "DSXLoadingControl.h"

@interface UIScrollView (Refresh)

@property(nonatomic,readwrite,retain) DSXRefreshControl *dsx_refreshControl;
@property(nonatomic,readwrite,retain) DSXLoadingControl *dsx_loadingControl;

@end
