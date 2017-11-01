//
//  DSXFramework.h
//  DSXFramework
//
//  Created by songdewei on 2016/12/2.
//  Copyright © 2016年 DashiXiong. All rights reserved.
//

//定义屏幕宽度
#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
//定义屏幕高度
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif
//定义顶部高度
#ifndef TOP_HEIGHT
#define TOP_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height+self.navigationController.navigationBar.frame.size.height
#endif

#define IOSVERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#ifndef SITEAPI
#define SITEAPI @"http://dtjg.liaidicn.com/app.php?"

#endif

#ifdef DEBUG
#define DSXLog(...) NSLog(__VA_ARGS__)
#else
#define DSXLog(...)
#endif

#import <JavaScriptCore/JavaScriptCore.h>
#import "DSXURL.h"
#import "DSXJSON.h"
#import "DSXApi.h"
#import "DSXRefreshControl.h"
#import "DSXNavigationController.h"
#import "DSXTableViewController.h"
#import "NSString+Encryption.h"
#import "NSString+Validate.h"
#import "UIColor+color.h"
#import "UIView+size.h"
#import "UIScrollView+Touch.h"
#import "UIScrollView+Refresh.h"
#import "DSXCookieHelper.h"
#import "DSXSandboxHelper.h"
#import "DSXImageManager.h"
#import "DSXDate.h"
#import "DSXDatePicker.h"
#import "DSXSearchBar.h"
#import "UIImage+Bundle.h"
#import "DSXBarButtonItem.h"
#import "NSString+Validate.h"
#import "NSString+Encryption.h"
#import "UIViewController+toast.h"
