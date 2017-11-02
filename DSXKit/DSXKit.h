//
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
#define SITEAPI @""

#endif

#ifdef DEBUG
#define DSXLog(...) NSLog(__VA_ARGS__)
#else
#define DSXLog(...)
#endif

#import <Foundation/Foundation.h>

#import "UIColor+color.h"
#import "UIView+size.h"
#import "NSString+Validate.h"
#import "NSString+Encryption.h"
#import "UIScrollView+Touch.h"
#import "UIScrollView+Refresh.h"
#import "UIView+toast.h"
#import "UIViewController+toast.h"
#import "NSDate+DSXAdd.h"
#import "NSURL+DSXAdd.h"
#import "UIImage+DSXAdd.h"
#import "UILabel+DSXAdd.h"
#import "NSArray+DSXAdd.h"
#import "NSDictionary+DSXAdd.h"
#import "UIAlertController+DSXAdd.h"
#import "UIBarButtonItem+DSXAdd.h"
#import "CLLocationManager+DSXAdd.h"

#import "DSXNavigationController.h"
#import "DSXTableViewController.h"
#import "DSXUIWebViewController.h"
#import "DSXWKWebViewController.h"
#import "DSXCookieHelper.h"
#import "DSXSandboxHelper.h"
#import "DSXDatePicker.h"
#import "DSXSearchBar.h"


