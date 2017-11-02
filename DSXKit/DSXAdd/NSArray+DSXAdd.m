//
//  NSArray+DSXAdd.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "NSArray+DSXAdd.h"

@implementation NSArray(DSXAdd)

+ (NSArray *)arrayWithJSON:(id)json{
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        return array;
    }else {
        return nil;
    }
}

- (NSString *)arrayToJSON{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

@end


@implementation NSMutableArray(DSXAdd)

+ (NSMutableArray *)arrayWithJSON:(id)json{
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        return [NSMutableArray arrayWithArray:array];
    }else {
        return nil;
    }
}

@end
