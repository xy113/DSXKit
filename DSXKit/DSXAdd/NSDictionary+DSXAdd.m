//
//  NSDictionary+DSXAdd.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "NSDictionary+DSXAdd.h"

@implementation NSDictionary(DSXAdd)

/**
 * JSON转换为字典
 */
+ (NSDictionary *)dictionaryWithJSON:(id)json{
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        return dictionary;
    }else {
        return nil;
    }
}

- (NSString *)toQueryString{
    NSString *str = @"";
    NSString *comma = @"";
    for (NSString *key in [self allKeys]) {
        str = [str stringByAppendingFormat:@"%@%@=%@",comma,key,[self objectForKey:key]];
        comma = @"&";
    }
    return str;
}

- (NSString *)dictionaryToJSON{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

@end


@implementation NSMutableDictionary(DSXAdd)

+ (NSMutableDictionary *)dictionaryWithJSON:(id)json{
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        return [NSMutableDictionary dictionaryWithDictionary:dictionary];
    }else {
        return nil;
    }
}

@end
