//
//  DSXJSON.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/8/30.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXJSON.h"

@implementation DSXJSON

+ (NSString *)jsonEncode:(id)object{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (id)jsonDecode:(NSData *)object{
    NSError *error;
    id data = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingAllowFragments error:&error];
    return data;
}

@end
