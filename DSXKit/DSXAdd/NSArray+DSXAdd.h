//
//  NSArray+DSXAdd.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(DSXAdd)

+ (NSArray *)arrayWithJSON:(id)json;
- (NSString *)arrayToJSON;

@end

@interface NSMutableArray(DSXAdd)

+ (NSMutableArray *)arrayWithJSON:(id)json;

@end
