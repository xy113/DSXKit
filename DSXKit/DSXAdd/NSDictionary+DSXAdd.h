//
//  NSDictionary+DSXAdd.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(DSXAdd)

+ (NSDictionary *)dictionaryWithJSON:(id)json;

- (NSString *)toQueryString;
- (NSString *)dictionaryToJSON;

@end

@interface NSMutableDictionary(DSXAdd)

+ (NSMutableDictionary *)dictionaryWithJSON:(id)json;

@end
