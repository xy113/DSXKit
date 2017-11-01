//
//  NSString+Validate.m
//  LADZhangWo
//
//  Created by Apple on 16/1/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString(validate)

- (BOOL)isMatch:(NSString *)Regex{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}
//验证邮箱
- (BOOL)isEmail{
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

//验证手机号
- (BOOL)isMobile{
    //手机号以13，14, 15，17, 18开头，八个 \d 数字字符
    NSString *Regex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

//用户名验证
- (BOOL)isUsername{
    NSString *Regex = @"^[A-Za-z0-9\u4e00-\u9fa5]{2,20}+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

//密码验证
- (BOOL)isPassword{
    NSString *Regex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

//昵称验证
- (BOOL)isNickname{
    NSString *Regex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

//车牌号验证
- (BOOL)isCarNo{
    NSString *Regex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

//车型验证
- (BOOL)isCarType{
    NSString *Regex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

//身份证号验证
- (BOOL)isIdentityCard{
    NSString *Regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

//URL验证
- (BOOL)isURL{
    NSString *Regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isChineseName{
    NSString *Regex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [predicate evaluateWithObject:self];
}

@end
