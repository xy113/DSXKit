//
//  DSXDate.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/8/25.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXDate.h"

@implementation DSXDate

+ (NSString *)timestamp{
    return [[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] substringToIndex:10];
}

@end
