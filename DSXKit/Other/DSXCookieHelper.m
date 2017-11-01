//
//  DSXCookieHelper.m
//  XingWeiForIPhone
//
//  Created by songdewei on 2016/11/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXCookieHelper.h"

@implementation DSXCookieHelper

+ (void)setCookie:(NSString *)cookieName value:(NSString *)cookieValue{
    NSString *name = [COOKIEPRE stringByAppendingString:cookieName];
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:name forKey:NSHTTPCookieName];
    [cookieProperties setObject:cookieValue forKey:NSHTTPCookieValue];
    [cookieProperties setObject:COOKIEDOMAIN forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:COOKIEPATH forKey:NSHTTPCookiePath];
    //[cookieProperties setObject:@"FALSE" forKey:NSHTTPCookieSecure];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //[cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain];
    [cookieStorage setCookie:cookie];
}

+ (NSString *)getCookie:(NSString *)cookieName{
    NSString *value;
    NSString *name = [COOKIEPRE stringByAppendingString:cookieName];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        if ([name isEqualToString:[cookie name]]) {
            value = [cookie value];
            break;
        }
    }
    return value;
}

+ (void)deleteCookie:(NSString *)cookieName{
    NSString *name = [COOKIEPRE stringByAppendingString:cookieName];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        if ([name isEqualToString:[cookie name]]) {
            [cookieStorage deleteCookie:cookie];
        }
    }
}

+ (void)clearCookies{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        [cookieStorage deleteCookie:cookie];
    }
}

+ (NSString *)getCookieString{
    NSString *cookieString = @"";
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        cookieString = [cookieString stringByAppendingFormat:@"%@=%@;", [cookie name], [cookie value]];
    }
    return cookieString;
}

@end
