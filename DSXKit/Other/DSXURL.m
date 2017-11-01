//
//  DSXURL.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/8/29.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXURL.h"

@implementation DSXURL

- (NSDictionary *)params{
    _parameters = [NSMutableDictionary dictionary];
    NSArray *array = [[self query] componentsSeparatedByString:@"&"];
    for (NSString *param in array) {
        NSArray *arr = [param componentsSeparatedByString:@"="];
        if ([arr count] == 2) {
            [_parameters setObject:[arr[1] stringByRemovingPercentEncoding] forKey:arr[0]];
        }
    }
    return _parameters;
}

- (NSString *)getParameter:(NSString *)name{
    if (!_parameters) {
        [self params];
    }
    return (NSString *)[_parameters objectForKey:name];
}

+ (NSString *)buildQueryString:(NSDictionary *)params{
    NSString *str = @"";
    NSString *comma = @"";
    for (NSString *key in [params allKeys]) {
        str = [str stringByAppendingFormat:@"%@%@=%@",comma,key,[params objectForKey:key]];
        comma = @"&";
    }
    return str;
}

@end
