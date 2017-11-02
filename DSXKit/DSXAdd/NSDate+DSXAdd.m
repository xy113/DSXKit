//
//  NSDate+time.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "NSDate+DSXAdd.h"

@implementation NSDate(time)

- (NSString *)timestamp{
    NSString *timeStr = [NSString stringWithFormat:@"%f", [self timeIntervalSince1970]];
    return [timeStr substringToIndex:10];
}

- (NSString *)dateTimeWithFormat:(NSString *)format{
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = format;
    return [fm stringFromDate:self];
}

@end
