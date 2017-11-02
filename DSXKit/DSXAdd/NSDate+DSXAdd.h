//
//  NSDate+time.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDate(time)

- (NSString *)timestamp;
- (NSString *)dateTimeWithFormat:(nullable NSString *)format;

@end
NS_ASSUME_NONNULL_END
