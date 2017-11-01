//
//  DSXCookieHelper.h
//  XingWeiForIPhone
//
//  Created by songdewei on 2016/11/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#ifndef COOKIEPRE
#define COOKIEPRE @""
#endif

#ifndef COOKIEDOMAIN
#define COOKIEDOMAIN @""
#endif

#ifndef COOKIEPATH
#define COOKIEPATH @"/"
#endif

#import <Foundation/Foundation.h>

@interface DSXCookieHelper : NSObject

+ (void)setCookie:(NSString *)cookieName value:(NSString *)cookieValue;
+ (NSString *)getCookie:(NSString *)cookieName;
+ (void)deleteCookie:(NSString *)cookieName;
+ (void)clearCookies;
+ (NSString *)getCookieString;

@end
