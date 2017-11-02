//
//  NSString+Encryption.h
//  LADZhangWo
//
//  Created by Apple on 15/12/1.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString(Encryption)

- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)urlencode;
- (NSString *)urldecode;

@end
