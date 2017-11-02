//
//  NSString+Encryption.m
//  LADZhangWo
//
//  Created by Apple on 15/12/1.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "NSString+Encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(Encryption)

/**
 *  md5加密
 *
 *  @return 获取加密后的字符串
 */
- (NSString *)md5 {
    
    //  将传入OC字符串转换成C字符串
    const char *cStr = [self UTF8String];
    //  无符号字符数组 16位
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), digest);
    
    NSMutableString *encryptionString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        //  将转换后的字符转换成16进制, 02表示不足两位前面补0,  例如 "a" -> "0a",  "3" -> "03"
        [encryptionString appendFormat:@"%02x",digest[i]];
    }
    
    return encryptionString;
}

/**
 *  sha1加密
 *
 *  @return 获取加密后的字符串
 */
- (NSString *)sha1 {
    //  将字符串转换成 C字符串
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    //  C字符串转换成二进制数据
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (uint32_t)data.length, digest);
    
    NSMutableString *encryptionString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [encryptionString appendFormat:@"%02x", digest[i]];
    }
    
    return encryptionString;
}

- (NSString *)urlencode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithRange:NSMakeRange(0, self.length)]];
    /*
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)self,
                                                                                 nil,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
     */
}

- (NSString *)urldecode {
    return [self stringByRemovingPercentEncoding];
    /*
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
     */
}

@end
