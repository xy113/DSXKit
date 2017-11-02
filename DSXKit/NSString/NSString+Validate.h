//
//  NSString+Validate.h
//  LADZhangWo
//
//  Created by Apple on 16/1/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(validate)

- (BOOL)isMatch:(NSString *)Regex;
- (BOOL)isEmail;
- (BOOL)isMobile;
- (BOOL)isUsername;
- (BOOL)isPassword;
- (BOOL)isNickname;
- (BOOL)isCarNo;
- (BOOL)isCarType;
- (BOOL)isIdentityCard;
- (BOOL)isURL;
- (BOOL)isChineseName;

@end
